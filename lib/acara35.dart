// lib/acara35.dart
import 'package:flutter/material.dart';
// Panggil Model dan API
import 'model/popular_movies.dart';
import 'data/api_provider.dart';

class Acara35 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 35: Movie DB API'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  // Tipe Future berubah menjadi PopularMovies (sesuai Model)
  late Future<PopularMovies> _moviesFuture;

  @override
  void initState() {
    super.initState();
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.amber));
        }

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
                ElevatedButton(onPressed: _refresh, child: Text('Coba Lagi')),
              ],
            ),
          );
        }

        // Ambil list results dari object PopularMovies
        final movies = snapshot.data?.results ?? [];

        return RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                color: Colors.grey[850],
                margin: EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () => _showMovieDetail(context, movie),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: movie.posterPath.isNotEmpty
                            ? Image.network(movie.fullPosterUrl,
                                fit: BoxFit.cover)
                            : Container(
                                color: Colors.grey,
                                child: Icon(Icons.movie, color: Colors.white)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(movie.voteAverage.toStringAsFixed(1),
                                      style: TextStyle(color: Colors.amber)),
                                  SizedBox(width: 16),
                                  Text(movie.releaseDate,
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(movie.overview,
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 13),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
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

  void _showMovieDetail(BuildContext context, Results movie) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  'Rating: ⭐ ${movie.voteAverage} | Rilis: ${movie.releaseDate}',
                  style: TextStyle(color: Colors.amber)),
              SizedBox(height: 16),
              Text(movie.overview,
                  style: TextStyle(color: Colors.white70, height: 1.5)),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
