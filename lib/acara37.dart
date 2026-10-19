// lib/acara37.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Acara37 extends StatefulWidget {
  @override
  _Acara37State createState() => _Acara37State();
}

class _Acara37State extends State<Acara37> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Fungsi Login
  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Email dan Password wajib diisi!'),
            backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.message ?? 'Login Gagal'),
            backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Fungsi Register
  Future<void> _register() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Email dan Password wajib diisi!'),
            backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.message ?? 'Registrasi Gagal'),
            backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 37: Firebase Auth'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      // StreamBuilder mendengarkan status login secara real-time
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          // Tampilan saat loading ngecek status
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // JIKA USER SUDAH LOGIN
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user, size: 100, color: Colors.green),
                  SizedBox(height: 16),
                  Text('Login Berhasil Sebagai:',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                    snapshot.data!.email ?? 'User',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => _auth.signOut(),
                    icon: Icon(Icons.logout),
                    label: Text('LOGOUT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                ],
              ),
            );
          }

          // JIKA USER BELUM LOGIN (Tampilkan Form)
          return SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(Icons.lock_outline, size: 80, color: Colors.deepOrange),
                SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password (min 6 karakter)',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 32),
                _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              child: Text('LOGIN'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding: EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _register,
                              child: Text('DAFTAR AKUN BARU'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
