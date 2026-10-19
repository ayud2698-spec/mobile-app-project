// lib/acara39.dart
import 'package:flutter/material.dart';
import 'data/auth_api.dart';

class Acara39 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 39: Authentication UI'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _token; // Menyimpan token jika berhasil login

  Future<void> _prosesLogin() async {
    // 1. Validasi Form terlebih dahulu
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Set loading state
    setState(() {
      _isLoading = true;
      _token = null;
    });

    // 3. Panggil API dari Acara 38
    final response = await AuthApi.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    // 4. Update UI berdasarkan hasil
    setState(() {
      _isLoading = false;
      if (response.token != null) {
        _token = response.token;
        // Jika berhasil, kita bisa arahkan ke halaman Home/Dashboard
        _showSuccessDialog(response.token!);
      } else {
        // Jika gagal, tampilkan snackbar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Gagal: ${response.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _showSuccessDialog(String token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Login Berhasil'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selamat datang!'),
            SizedBox(height: 8),
            Text('Token Anda:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(token, style: TextStyle(fontFamily: 'monospace')),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // Header
            Icon(Icons.lock_person, size: 100, color: Colors.indigo),
            SizedBox(height: 16),
            Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Silakan login untuk melanjutkan',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 40),

            // Form Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email wajib diisi';
                if (!value.contains('@')) return 'Format email salah';
                return null;
              },
            ),
            SizedBox(height: 16),

            // Form Password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Password wajib diisi';
                if (value.length < 6) return 'Minimal 6 karakter';
                return null;
              },
            ),
            SizedBox(height: 32),

            // Tombol Login
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _prosesLogin,
                      child: Text('LOGIN',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

            SizedBox(height: 24),

            // Teks bantuan (Biar tidak bingung)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text('Gunakan akun dummy ini untuk login:',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Email: eve.holt@reqres.in',
                      style: TextStyle(fontSize: 12)),
                  Text('Pass: cityslicka', style: TextStyle(fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
