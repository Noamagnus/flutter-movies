import 'dart:convert';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/utilities/helper_functions.dart';
import 'package:flutter_movies_app/utilities/paginated_response.dart';
import 'package:http/http.dart' as http;

class TMDBService {
  final String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=${getApiKey()}&language=en-US'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Movie>.from(data['results'].map((m) => Movie.fromJson(m)));
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
  Future<PaginatedResponse<Movie>> fetchTopRatedMovies({required int page}) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=${getApiKey()}&language=en-US&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PaginatedResponse<Movie>.fromJson(data, (m) => Movie.fromJson(m));
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/search/movie?api_key=${getApiKey()}&query=$query&language=en-US'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Movie>.from(data['results'].map((m) => Movie.fromJson(m)));
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<Movie> fetchMovieDetails(String movieId) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/$movieId?api_key=${getApiKey()}&language=en-US'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }


}
