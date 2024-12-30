import 'package:equatable/equatable.dart';
import 'genre.dart';

class Movie extends Equatable {
  final List<Genre>? genres;
  final int id;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int? runtime;

  const Movie({
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      genres: json['genres'] != null ? (json['genres'] as List<dynamic>).map((e) => Genre.fromJson(e)).toList() : null,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      runtime: json['runtime'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genres': genres?.map((genre) => genre.toJson()).toList(), // Convert Genre objects to JSON
      'id': id,
      'original_language': originalLanguage,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'runtime': runtime,
    };
  }

  @override
  List<Object?> get props => [
        genres,
        id,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
        runtime,
      ];
}
