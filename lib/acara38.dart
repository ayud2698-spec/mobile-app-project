// lib/acara38.dart
import 'package:flutter/material.dart';
import 'data/auth_api.dart';
import 'model/auth_model.dart';

class Acara38 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 38: Auth API'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _token; // Menyimpan token jika berhasil login

  Future<void> _prosesLogin() async {
    setState(() {
      _isLoading = true;
      _token = null;
    });

    // Panggil fungsi dari API
    final response = await AuthApi.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      if (response.token != null) {
        _token = response.token;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login Berhasil! Token: ${response.token}'),
              backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Gagal: ${response.error}'),
              backgroundColor: Colors.red),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.security, size: 80, color: Colors.teal),
          SizedBox(height: 32),

          // Jika sudah login, tampilkan info sukses
          if (_token != null) ...[
            Text('Status: LOGGED IN',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Token: $_token',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => _token = null),
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ] else ...[
            // Jika belum login, tampilkan form
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'eve.holt@reqres.in', // Petunjuk email yang benar
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'cityslicka', // Petunjuk password yang benar
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _prosesLogin,
                      child: Text('LOGIN'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.all(16)),
                    ),
                  ),
          ],
        ],
      ),
    );
  }
}
