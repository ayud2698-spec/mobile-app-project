// lib/model/popular_movies.dart

class PopularMovies {
  final int page;
  final List<Results> results;

  PopularMovies({required this.page, required this.results});

  factory PopularMovies.fromJson(Map<String, dynamic> json) {
    return PopularMovies(
      page: json['page'] ?? 1,
      results:
          (json['results'] as List).map((i) => Results.fromJson(i)).toList(),
    );
  }
}

class Results {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Results({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '-',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  String get fullPosterUrl {
    if (posterPath.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
