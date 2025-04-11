import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class TmdbApi {
  TmdbApi({
    required this.apiKey,
    this.lang = 'fr-FR',
  });

  static const String baseUrl = 'https://api.themoviedb.org/3';

  final String apiKey;
  final String lang;

  /// Donne l'URL complète d'une image.
  String getImageUrl(String imagePath) {
    return 'https://image.tmdb.org/t/p/w500/$imagePath';
  }

  /// Retourne la liste des films populaires du moment.
  Future<Iterable<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/movie/popular?api_key=$apiKey&language=$lang',
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body.isEmpty) (throw Exception('Val Null'));

      final data = json.decode(response.body) as Map<String, dynamic>;

      return (data['results'] as List<dynamic>).map((e) => Movie.fromJson(e));
    }

    throw Exception(
      'Impossible de récupérer les données (HTTP ${response.statusCode})',
    );
  }

  /// Retourne la liste des recommandations associées à un film donné.
  Future<Iterable<Movie>> getRecommendedMovies(Movie movie) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/movie/${movie.id}/recommendations?api_key=$apiKey&language=$lang',
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      return (data['results'] as List<dynamic>).map((e) => Movie.fromJson(e));
    }

    throw Exception(
      'Impossible de récupérer les données (HTTP ${response.statusCode})',
    );
  }
}
