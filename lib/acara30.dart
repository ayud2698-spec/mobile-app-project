// lib/acara30.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ============================================================
// MODEL
// ============================================================
class Product {
  final int id;
  final String name;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get subtotal => product.price * quantity;
}

// ============================================================
// CONTROLLER
// ============================================================
class CartController extends GetxController {
  // ============ OBSERVABLE STATE ============
  // RxList: daftar item di keranjang
  var cart = <CartItem>[].obs;

  // RxInt: counter sederhana
  var counter = 0.obs;

  // RxString: filter pencarian
  var searchQuery = ''.obs;

  // Daftar produk yang tersedia
  final List<Product> allProducts = [
    Product(id: 1, name: 'Laptop', price: 8000000, image: '💻'),
    Product(id: 2, name: 'Mouse', price: 150000, image: '🖱️'),
    Product(id: 3, name: 'Keyboard', price: 300000, image: '⌨️'),
    Product(id: 4, name: 'Monitor', price: 2000000, image: '🖥️'),
    Product(id: 5, name: 'Headphone', price: 500000, image: '🎧'),
    Product(id: 6, name: 'Charger', price: 100000, image: '🔌'),
  ];

  // ============ COMPUTED VALUE ============
  // Getter otomatis update saat `cart` berubah
  double get totalPrice {
    return cart.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  int get totalItems {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  // Filter produk berdasarkan search
  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) return allProducts;
    return allProducts
        .where((p) =>
            p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  // ============ METHODS ============
  void increment() => counter++;
  void decrement() => counter--;

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      // Sudah ada, tambah quantity
      cart[index].quantity++;
      cart.refresh();
    } else {
      // Belum ada, tambah item baru
      cart.add(CartItem(product: product));
    }
    Get.snackbar(
      'Ditambahkan',
      '${product.name} masuk keranjang',
      duration: Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
    );
  }

  void removeFromCart(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
    // refresh tidak perlu karena RxList otomatis update saat remove
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      cart.refresh();
    } else {
      cart.remove(item);
    }
  }

  void clearCart() {
    cart.clear();
  }

  // ============ WORKERS ============
  @override
  void onInit() {
    super.onInit();

    // ever: dipanggil setiap kali counter berubah
    ever(counter, (value) {
      print('🔄 Counter berubah: $value');
    });

    // once: hanya dipanggil sekali saat pertama berubah
    once(cart, (value) {
      if (value.isNotEmpty) {
        print('🛒 Item pertama masuk keranjang');
      }
    });
  }
}

// ============================================================
// HALAMAN UTAMA
// ============================================================
class Acara30 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Acara 30: GetX State Management'),
          backgroundColor: Colors.deepPurple,
          actions: [
            // Tombol Home
            IconButton(
              icon: Icon(Icons.home),
              tooltip: 'Kembali ke Beranda',
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.shopping_bag), text: 'Produk'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'Keranjang'),
              Tab(icon: Icon(Icons.info), text: 'Info'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductTab(controller: controller),
            CartTab(controller: controller),
            InfoTab(controller: controller),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TAB 1: PRODUK
// ============================================================
class ProductTab extends StatelessWidget {
  final CartController controller;
  ProductTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            onChanged: (v) => controller.searchQuery.value = v,
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        // List produk
        Expanded(
          child: Obx(() {
            final items = controller.filteredProducts;
            if (items.isEmpty) {
              return Center(child: Text('Tidak ada produk'));
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final p = items[i];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Text(p.image, style: TextStyle(fontSize: 32)),
                    title: Text(p.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Rp ${p.price.toStringAsFixed(0)}'),
                    trailing: ElevatedButton.icon(
                      onPressed: () => controller.addToCart(p),
                      icon: Icon(Icons.add, size: 18),
                      label: Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

// ============================================================
// TAB 2: KERANJANG
// ============================================================
class CartTab extends StatelessWidget {
  final CartController controller;
  CartTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.cart.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
              SizedBox(height: 16),
              Text('Keranjang masih kosong',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 8),
              Text('Tambah produk dari tab Produk',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: controller.cart.length,
              itemBuilder: (ctx, i) {
                final item = controller.cart[i];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Text(item.product.image,
                        style: TextStyle(fontSize: 32)),
                    title: Text(item.product.name),
                    subtitle: Text(
                        'Rp ${item.product.price.toStringAsFixed(0)} x ${item.quantity} = Rp ${item.subtotal.toStringAsFixed(0)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => controller.decreaseQuantity(item),
                        ),
                        Text('${item.quantity}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () {
                            item.quantity++;
                            controller.cart.refresh();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Total & aksi
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Item:', style: TextStyle(fontSize: 16)),
                    Text('${controller.totalItems}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Harga:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Rp ${controller.totalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Hapus Semua',
                            middleText: 'Yakin ingin mengosongkan keranjang?',
                            textConfirm: 'Ya',
                            textCancel: 'Batal',
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.red,
                            onConfirm: () {
                              controller.clearCart();
                              Get.back();
                            },
                          );
                        },
                        child: Text('Kosongkan'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.snackbar(
                            'Checkout',
                            'Total: Rp ${controller.totalPrice.toStringAsFixed(0)}',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.deepPurple,
                            colorText: Colors.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

// ============================================================
// TAB 3: INFO (Demo Counter & Workers)
// ============================================================
class InfoTab extends StatelessWidget {
  final CartController controller;
  InfoTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Counter demo
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Demo Counter (.obs)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple)),
                  SizedBox(height: 16),
                  Obx(() => Text(
                        '${controller.counter}',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      )),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: controller.decrement,
                        icon: Icon(Icons.remove_circle,
                            size: 40, color: Colors.red),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: controller.increment,
                        icon: Icon(Icons.add_circle,
                            size: 40, color: Colors.green),
                      ),
                    ],
                  ),
                  Text('Lihat console — setiap perubahan dicatat oleh ever()',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          // Info tabs
          Card(
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reactive State Manager',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple)),
                  SizedBox(height: 8),
                  Text('• .obs membuat variabel jadi observable'),
                  Text('• Obx() otomatis rebuild saat observable berubah'),
                  Text('• RxList, RxInt, RxString — tipe reactive'),
                  Text('• .refresh() untuk trigger rebuild manual'),
                  Text('• ever(), once() — worker GetX'),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Computed Value',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green[800])),
                  SizedBox(height: 8),
                  Text('• totalPrice dihitung dari cart (fold)'),
                  Text('• totalItems dihitung dari cart'),
                  Text('• Otomatis update saat cart berubah'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
