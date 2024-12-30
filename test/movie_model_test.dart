import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/models/genre.dart';

void main() {
  group('Movie Model Tests', () {
    test('fromJson creates a valid Movie object', () {
      final json = {
        'id': 1,
        'genres': [
          {'id': 28, 'name': 'Action'},
          {'id': 12, 'name': 'Adventure'},
        ],
        'original_language': 'en',
        'overview': 'This is a test movie overview.',
        'popularity': 99.9,
        'poster_path': '/testPoster.jpg',
        'release_date': '2023-12-31',
        'title': 'Test Movie',
        'vote_average': 8.2,
        'vote_count': 120,
        'runtime': 150,
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 1);
      expect(movie.genres?.length, 2);
      expect(movie.genres?[0].id, 28);
      expect(movie.genres?[0].name, 'Action');
      expect(movie.originalLanguage, 'en');
      expect(movie.overview, 'This is a test movie overview.');
      expect(movie.popularity, 99.9);
      expect(movie.posterPath, '/testPoster.jpg');
      expect(movie.releaseDate, '2023-12-31');
      expect(movie.title, 'Test Movie');
      expect(movie.voteAverage, 8.2);
      expect(movie.voteCount, 120);
      expect(movie.runtime, 150);
    });

    test('toJson converts a Movie object to JSON', () {
      final movie = Movie(
        id: 1,
        genres: [
          Genre(id: 28, name: 'Action'),
          Genre(id: 12, name: 'Adventure'),
        ],
        originalLanguage: 'en',
        overview: 'This is a test movie overview.',
        popularity: 99.9,
        posterPath: '/testPoster.jpg',
        releaseDate: '2023-12-31',
        title: 'Test Movie',
        voteAverage: 8.2,
        voteCount: 120,
        runtime: 150,
      );

      final json = movie.toJson();

      expect(json['id'], 1);
      expect((json['genres'] as List).length, 2);
      expect((json['genres'] as List)[0]['id'], 28);
      expect((json['genres'] as List)[0]['name'], 'Action');
      expect(json['original_language'], 'en');
      expect(json['overview'], 'This is a test movie overview.');
      expect(json['popularity'], 99.9);
      expect(json['poster_path'], '/testPoster.jpg');
      expect(json['release_date'], '2023-12-31');
      expect(json['title'], 'Test Movie');
      expect(json['vote_average'], 8.2);
      expect(json['vote_count'], 120);
      expect(json['runtime'], 150);
    });

    test('fromJson handles null genres, posterPath, and runtime', () {
      final json = {
        'id': 2,
        'genres': null,
        'original_language': 'fr',
        'overview': 'This is another test movie overview.',
        'popularity': 45.3,
        'poster_path': null,
        'release_date': '2023-11-15',
        'title': 'Another Test Movie',
        'vote_average': 7.3,
        'vote_count': 50,
        'runtime': null,
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 2);
      expect(movie.genres, isNull);
      expect(movie.posterPath, isNull);
      expect(movie.runtime, isNull);
      expect(movie.originalLanguage, 'fr');
      expect(movie.overview, 'This is another test movie overview.');
      expect(movie.popularity, 45.3);
      expect(movie.releaseDate, '2023-11-15');
      expect(movie.title, 'Another Test Movie');
      expect(movie.voteAverage, 7.3);
      expect(movie.voteCount, 50);
    });

    test('toJson handles null optional fields correctly', () {
      final movie = Movie(
        id: 2,
        genres: null,
        originalLanguage: 'fr',
        overview: 'This is another test movie overview.',
        popularity: 45.3,
        posterPath: null,
        releaseDate: '2023-11-15',
        title: 'Another Test Movie',
        voteAverage: 7.3,
        voteCount: 50,
        runtime: null,
      );

      final json = movie.toJson();

      expect(json['id'], 2);
      expect(json['genres'], isNull);
      expect(json['poster_path'], isNull);
      expect(json['runtime'], isNull);
      expect(json['original_language'], 'fr');
      expect(json['overview'], 'This is another test movie overview.');
      expect(json['popularity'], 45.3);
      expect(json['release_date'], '2023-11-15');
      expect(json['title'], 'Another Test Movie');
      expect(json['vote_average'], 7.3);
      expect(json['vote_count'], 50);
    });
  });
}
