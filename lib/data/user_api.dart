// lib/data/user_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserApi {
  static const String baseUrl = 'https://reqres.in/api';

  static Future<UserResponse> getUsers(int page) async {
    final url = Uri.parse('$baseUrl/users?page=$page');

    try {
      // Reqres.in membutuhkan api-key di header
      final response = await http.get(
        url,
        headers: {'x-api-key': 'reqres-free-v1'},
      );

      if (response.statusCode == 200) {
        return UserResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat data (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error jaringan: $e');
    }
  }
}
