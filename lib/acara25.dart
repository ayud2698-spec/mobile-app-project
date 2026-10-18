// lib/acara25.dart
import 'package:flutter/material.dart';

class Acara25 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Belajar Form Flutter",
      home: BelajarForm(),
    );
  }
}

class BelajarForm extends StatefulWidget {
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

class _BelajarFormState extends State<BelajarForm> {
  // Kunci untuk trigger validasi Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk membaca isi field
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telpController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus
    _namaController.dispose();
    _emailController.dispose();
    _telpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Belajar Form Flutter"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============ JUDUL ============
              Text(
                "Form Pendaftaran",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Silakan isi data diri Anda di bawah ini.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 24),

              // ============ 1. NAMA LENGKAP ============
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: "contoh: Achmad Hilmy Firdaus",
                  labelText: "Nama Lengkap",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  if (value.length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null; // null = valid
                },
              ),
              SizedBox(height: 16),

              // ============ 2. EMAIL ============
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "contoh: hilmy@polije.ac.id",
                  labelText: "Email",
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  // Regex sederhana untuk cek format email
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ============ 3. NOMOR TELEPON ============
              TextFormField(
                controller: _telpController,
                decoration: InputDecoration(
                  hintText: "contoh: 0812xxxxxxx",
                  labelText: "Nomor Telp",
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'Nomor telepon minimal 10 digit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ============ 4. PASSWORD ============
              TextFormField(
                controller: _passwordController,
                obscureText: true, // sembunyikan teks
                decoration: InputDecoration(
                  hintText: "Masukkan password",
                  labelText: "Password",
                  icon: Icon(Icons.security),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // ============ TOMBOL SUBMIT ============
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    // Trigger validasi seluruh Form
                    if (_formKey.currentState!.validate()) {
                      // Kalau semua valid, tampilkan hasil
                      _showResultDialog();
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog hasil input
  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Data Berhasil Dikirim'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${_namaController.text}'),
            SizedBox(height: 8),
            Text('Email: ${_emailController.text}'),
            SizedBox(height: 8),
            Text('Telp: ${_telpController.text}'),
            SizedBox(height: 8),
            Text('Password: ${'*' * _passwordController.text.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}