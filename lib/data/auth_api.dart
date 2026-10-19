// lib/data/auth_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/auth_model.dart';

class AuthApi {
  static const String baseUrl = 'https://reqres.in/api';

  // Fungsi untuk Login
  static Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1',
        },
        // Kirim data email dan password dalam format JSON
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonData);
      } else {
        // Jika server menolak (misal password salah), ambil pesan error dari server
        return AuthResponse(error: jsonData['error'] ?? 'Login gagal');
      }
    } catch (e) {
      return AuthResponse(error: 'Error jaringan: $e');
    }
  }
}
