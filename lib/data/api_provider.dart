// lib/data/api_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/popular_movies.dart';

class ApiProvider {
  // JANGAN LUPA GANTI DENGAN API KEY KAMU
  static const String apiKey = 'c26219c124be1ab6f7bc28da0ce82f77';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<PopularMovies> fetchPopularMovies() async {
    final url = Uri.parse(
        '$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Ubah JSON menjadi object menggunakan Model
        return PopularMovies.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat data (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
