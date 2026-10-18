// lib/acara19.dart
import 'package:flutter/material.dart';
import 'acara19_tab.dart';

class Acara19 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // ============ ROUTE GENERATOR ============
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// ============ ROUTE GENERATOR ============
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
      case '/tab':
        return MaterialPageRoute(builder: (_) => TabNavigationPage());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}

// ============ HALAMAN 1: HOME ============
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar Named Routing'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 80, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Halaman Home',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Named routing — pindah ke /about
                Navigator.pushNamed(context, '/about');
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Ke AboutPage'),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/tab');
              },
              icon: Icon(Icons.tab),
              label: Text('Ke Bottom Tab Navigation'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Route yang tidak terdaftar → ErrorPage
                Navigator.pushNamed(context, '/halaman-404');
              },
              icon: Icon(Icons.error),
              label: Text('Ke Halaman Tidak Ada'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ HALAMAN 2: ABOUT ============
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Halaman About',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ HALAMAN ERROR ============
class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error 404'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Halaman Tidak Ditemukan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
