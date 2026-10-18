// lib/acara32.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Acara32 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 32: Route Management GetX'),
        backgroundColor: Colors.deepPurple,
        actions: [
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
            // ============ HEADER ============
            Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.route, color: Colors.deepPurple, size: 32),
                        SizedBox(width: 8),
                        Text(
                          'Route Management',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Klik tombol di bawah untuk melihat berbagai cara navigasi GetX.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // ============ 1. GET.TO ============
            _sectionTitle('1. Get.to() — Pindah Halaman'),
            _tombol('Get.to(Page A)', Colors.blue, () {
              Get.to(() => PageA());
            }),
            _hint('Pindah ke halaman baru. Ada tombol back di AppBar.'),

            // ============ 2. GET.TONAMED ============
            _sectionTitle('2. Get.toNamed() — Named Route'),
            _tombol('Get.toNamed("/page-b")', Colors.teal, () {
              Get.toNamed('/page-b');
            }),
            _hint(
                'Pindah pakai nama route. Route didaftarkan di GetMaterialApp.'),

            // ============ 3. KIRIM ARGUMEN ============
            _sectionTitle('3. Kirim Argumen'),
            _tombol('Get.to + Argumen', Colors.orange, () {
              Get.to(
                () => PageWithArgs(),
                arguments: 'Halo dari Acara 32!',
              );
            }),
            _hint('Kirim data ke halaman tujuan via arguments.'),

            // ============ 4. GET.OFF ============
            _sectionTitle('4. Get.off() — Ganti Halaman'),
            _tombol('Get.off(PageA)', Colors.purple, () {
              Get.off(() => PageA());
            }),
            _hint('Pindah + hapus halaman ini dari history. Tidak bisa back.'),

            // ============ 5. GET.OFFALL ============
            _sectionTitle('5. Get.offAll() — Reset History'),
            _tombol('Get.offAll(PageA)', Colors.red, () {
              Get.offAll(() => PageA());
            }),
            _hint('Hapus SEMUA history, mulai dari halaman baru.'),

            // ============ 6. SNACKBAR & DIALOG ============
            _sectionTitle('6. Snackbar & Dialog Tanpa Context'),
            Row(
              children: [
                Expanded(
                  child: _tombol('Snackbar', Colors.green, () {
                    Get.snackbar(
                      'Halo!',
                      'Ini snackbar dari GetX',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      margin: EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                  }),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _tombol('Dialog', Colors.indigo, () {
                    Get.defaultDialog(
                      title: 'Konfirmasi',
                      middleText: 'Yakin ingin lanjut?',
                      textConfirm: 'Ya',
                      textCancel: 'Batal',
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.deepPurple,
                      onConfirm: () {
                        Get.back();
                        Get.snackbar('OK', 'Anda klik Ya');
                      },
                    );
                  }),
                ),
              ],
            ),
            _hint(
                'Snackbar & Dialog tanpa context! Cukup Get.snackbar / Get.defaultDialog.'),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper: judul section
  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.deepPurple),
      ),
    );
  }

  // Helper: tombol
  Widget _tombol(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Helper: hint
  Widget _hint(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
      ),
    );
  }
}

// ============================================================
// HALAMAN A
// ============================================================
class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman A'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.looks_one, size: 100, color: Colors.blue),
            SizedBox(height: 16),
            Text('Ini Halaman A',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.to(() => PageB()),
              child: Text('Get.to(Page B)'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text('Get.back()'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN B
// ============================================================
class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman B'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.looks_two, size: 100, color: Colors.teal),
            SizedBox(height: 16),
            Text('Ini Halaman B',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Dibuka via Named Route "/page-b"',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Get.back()'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN DENGAN ARGUMEN
// ============================================================
class PageWithArgs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil argumen yang dikirim
    final String pesan = Get.arguments ?? '(tidak ada argumen)';

    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman dengan Argumen'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, size: 100, color: Colors.orange),
              SizedBox(height: 16),
              Text('Argumen yang diterima:',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pesan,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Get.back()'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
