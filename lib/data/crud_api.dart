// lib/data/crud_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class CrudApi {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // 1. READ (GET)
  static Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat data');
  }

  // 2. CREATE (POST)
  static Future<bool> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    );
    return response.statusCode == 201; // 201 = Created
  }

  // 3. UPDATE (PUT)
  static Future<bool> updatePost(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': 1}),
    );
    return response.statusCode == 200;
  }

  // 4. DELETE (DELETE)
  static Future<bool> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    return response.statusCode == 200;
  }

  // Tambahkan di dalam class CrudApi
  // 5. READ DETAIL (GET by ID)
  static Future<Post> getPostDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Data dengan ID $id tidak ditemukan');
    }
  }
}
