// lib/acara20.dart
import 'package:flutter/material.dart';

class Acara20 extends StatefulWidget {
  @override
  _Acara20State createState() => _Acara20State();
}

class _Acara20State extends State<Acara20> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    SearchTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============ APPBAR ============
      appBar: AppBar(
        title: Text(_getTitle()),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      // ============ DRAWER (KIRI) ============
      drawer: AppDrawer(),

      // ============ ENDDRAWER (KANAN) ============
      endDrawer: AppEndDrawer(),

      // ============ BODY (sesuai tab aktif) ============
      body: _pages[_currentIndex],

      // ============ BOTTOM TAB NAVIGATION ============
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Beranda';
      case 1:
        return 'Pencarian';
      case 2:
        return 'Profil Saya';
      default:
        return 'Aplikasi';
    }
  }
}

// ============ DRAWER KIRI ============
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Drawer
          UserAccountsDrawerHeader(
            accountName: Text("Achmad Hilmy Firdaus",
                style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text("achmad.hilmy@polije.ac.id"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 20, color: Colors.deepPurple),
              ),
            ],
          ),

          // Menu Items
          DrawerTile(
            icon: Icons.home,
            title: 'Beranda',
            onTap: (ctx) {
              Navigator.pop(ctx);
            },
          ),
          DrawerTile(
            icon: Icons.person,
            title: 'Profil',
            onTap: (ctx) {
              Navigator.pop(ctx);
              Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Halaman Profil',
                          warna: Colors.deepPurple,
                        )),
              );
            },
          ),
          DrawerTile(
            icon: Icons.settings,
            title: 'Pengaturan',
            onTap: (ctx) {
              Navigator.pop(ctx);
              Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Halaman Pengaturan',
                          warna: Colors.blueGrey,
                        )),
              );
            },
          ),
          DrawerTile(
            icon: Icons.notifications,
            title: 'Notifikasi',
            onTap: (ctx) {
              Navigator.pop(ctx);
              Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Halaman Notifikasi',
                          warna: Colors.orange,
                        )),
              );
            },
          ),

          Divider(),

          DrawerTile(
            icon: Icons.help_outline,
            title: 'Bantuan',
            onTap: (ctx) {
              Navigator.pop(ctx);
            },
          ),
          DrawerTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            onTap: (ctx) {
              Navigator.pop(ctx);
              Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Tentang Aplikasi',
                          warna: Colors.teal,
                        )),
              );
            },
          ),
          DrawerTile(
            icon: Icons.logout,
            title: 'Keluar',
            onTap: (ctx) {
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}

// ============ DRAWER KANAN ============
class AppEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.filter_list, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'Filter & Opsi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DrawerTile(
            icon: Icons.sort,
            title: 'Urutkan',
            onTap: (ctx) => Navigator.pop(ctx),
          ),
          DrawerTile(
            icon: Icons.filter_alt,
            title: 'Filter',
            onTap: (ctx) => Navigator.pop(ctx),
          ),
          DrawerTile(
            icon: Icons.star,
            title: 'Favorit',
            onTap: (ctx) => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}

// ============ TILE REUSABLE ============
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function(BuildContext) onTap;

  const DrawerTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: () => onTap(context),
    );
  }
}

// ============ TAB 1: HOME ============
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text('Halaman Beranda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Geser dari kiri atau tekan ☰ untuk membuka drawer'),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Detail dari Beranda',
                          warna: Colors.deepPurple,
                        )),
              );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Ke Halaman Detail'),
          ),
        ],
      ),
    );
  }
}

// ============ TAB 2: SEARCH ============
class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari sesuatu...',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text('Hasil Pencarian ${i + 1}'),
                    subtitle: Text('Klik untuk lihat detail'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPage(
                                  judul: 'Detail Item ${i + 1}',
                                  warna: Colors.blue,
                                )),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============ TAB 3: PROFILE ============
class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text('Achmad Hilmy Firdaus',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('achmad.hilmy@polije.ac.id'),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetailPage(
                          judul: 'Edit Profil',
                          warna: Colors.deepPurple,
                        )),
              );
            },
            icon: Icon(Icons.edit),
            label: Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}

// ============ HALAMAN DETAIL (tujuan navigasi) ============
class DetailPage extends StatelessWidget {
  final String judul;
  final Color warna;

  const DetailPage({Key? key, required this.judul, required this.warna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: warna,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description, size: 100, color: warna),
            SizedBox(height: 16),
            Text(judul,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
