// lib/acara19_tab.dart
import 'package:flutter/material.dart';

class TabNavigationPage extends StatefulWidget {
  @override
  _TabNavigationPageState createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {
  int _currentIndex = 0;

  // Daftar halaman yang ditampilkan sesuai tab
  final List<Widget> _pages = [
    HomeTab(),
    SearchTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Tab Navigation'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _pages[_currentIndex],
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
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        tooltip: 'Tambah',
      ),
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
          Text(
            'Halaman Beranda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Ini adalah konten tab Beranda'),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('Hasil Pencarian ${i + 1}'),
                  subtitle: Text('Deskripsi item ${i + 1}'),
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
          Text(
            'Achmad Hilmy Firdaus',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('achmad.hilmy@polije.ac.id'),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}
