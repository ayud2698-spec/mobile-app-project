// lib/acara29.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MODEL

class Product {
  final int id;
  final String name;
  final double price;
  bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.isAvailable = true,
  });
}

// CONTROLLER (State Management GetX)

class ProductController extends GetxController {
  // Reactive state (.obs = observable)
  var counter = 0.obs;
  var products = <Product>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.value = [
      Product(id: 1, name: 'Laptop', price: 8000000),
      Product(id: 2, name: 'Mouse', price: 150000),
      Product(id: 3, name: 'Keyboard', price: 300000, isAvailable: false),
      Product(id: 4, name: 'Monitor', price: 2000000),
      Product(id: 5, name: 'Headphone', price: 500000),
    ];
  }

  // Methods
  void increment() => counter++;
  void decrement() => counter--;
  void reset() => counter.value = 0;

  // Computed: filter berdasarkan search
  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) return products;
    return products
        .where((p) =>
            p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void toggleAvailability(Product p) {
    p.isAvailable = !p.isAvailable;
    products.refresh(); // trigger rebuild list
  }
}

// HALAMAN

class Acara29 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dependency Management: Get.put() → daftarkan controller
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 29: GetX'),
        backgroundColor: Colors.deepPurple,
        actions: [
          // ============ TOMBOL HOME ============
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============ 1. COUNTER (Reactive State) ============
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '1. Reactive State (Counter)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 16),
                    // Obx() otomatis rebuild saat counter berubah
                    Obx(() => Text(
                          '${controller.counter}',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        )),
                    SizedBox(height: 16),
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
                          onPressed: controller.reset,
                          icon:
                              Icon(Icons.refresh, size: 40, color: Colors.blue),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: controller.increment,
                          icon: Icon(Icons.add_circle,
                              size: 40, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // ============ 2. PRODUCT LIST (Observable List) ============
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. Observable List (Products)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 12),
                    // Search field
                    TextField(
                      onChanged: (v) => controller.searchQuery.value = v,
                      decoration: InputDecoration(
                        hintText: 'Cari produk...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Obx() untuk rebuild otomatis
                    Obx(() {
                      final items = controller.filteredProducts;
                      if (items.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: Text('Tidak ada produk')),
                        );
                      }
                      return Column(
                        children: items
                            .map((p) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(child: Text('${p.id}')),
                                  title: Text(p.name),
                                  subtitle:
                                      Text('Rp ${p.price.toStringAsFixed(0)}'),
                                  trailing: IconButton(
                                    icon: Icon(
                                      p.isAvailable
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: p.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    onPressed: () =>
                                        controller.toggleAvailability(p),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // ============ 3. INFO ============
            Card(
              elevation: 4,
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3. Tiga Pilar GetX',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 8),
                    Text('✓ State Management: .obs + Obx()'),
                    SizedBox(height: 4),
                    Text('✓ Dependency Management: Get.put() / Get.find()'),
                    SizedBox(height: 4),
                    Text('✓ Route Management: Get.to() / Get.back()'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
