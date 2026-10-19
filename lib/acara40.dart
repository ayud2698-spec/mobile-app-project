// lib/acara40.dart
import 'package:flutter/material.dart';
import 'model/popular_movies.dart';
import 'data/api_provider.dart';

class Acara40 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 40: MovieDB HomeScreen'),
        backgroundColor: Colors.black, // Tema gelap ala bioskop
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: MovieGridScreen(),
    );
  }
}

class MovieGridScreen extends StatefulWidget {
  @override
  _MovieGridScreenState createState() => _MovieGridScreenState();
}

class _MovieGridScreenState extends State<MovieGridScreen> {
  late Future<PopularMovies> _moviesFuture;

  @override
  void initState() {
    super.initState();
    // Menggunakan ApiProvider dari Acara 35
    _moviesFuture = ApiProvider.fetchPopularMovies();
  }

  void _refresh() {
    setState(() {
      _moviesFuture = ApiProvider.fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMovies>(
      future: _moviesFuture,
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.amber));
        }

        // 2. Error State
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.red),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text('Pastikan API Key TMDB sudah benar.',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 16),
                ElevatedButton(onPressed: _refresh, child: Text('Coba Lagi')),
              ],
            ),
          );
        }

        // 3. Success State
        final movies = snapshot.data?.results ?? [];

        return RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            // Membuat grid 2 kolom
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65, // Mengatur rasio tinggi/lebar poster
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => _showMovieDetail(context, movie),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian Gambar Poster
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          child: movie.posterPath.isNotEmpty
                              ? Image.network(
                                  movie.fullPosterUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey[800],
                                  child: Icon(Icons.movie,
                                      size: 60, color: Colors.grey),
                                ),
                        ),
                      ),
                      // Bagian Judul & Rating
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  movie.voteAverage.toStringAsFixed(1),
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Dialog detail saat poster di-tap
  void _showMovieDetail(BuildContext context, Results movie) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis kecil di atas sebagai handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              SizedBox(height: 20),
              Text(movie.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text('${movie.voteAverage} / 10',
                      style: TextStyle(color: Colors.amber, fontSize: 16)),
                  SizedBox(width: 16),
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(movie.releaseDate,
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              SizedBox(height: 24),
              Text('Overview',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(movie.overview,
                  style: TextStyle(color: Colors.grey[400], height: 1.5)),
              SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
