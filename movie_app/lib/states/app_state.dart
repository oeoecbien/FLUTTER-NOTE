import 'package:flutter/material.dart';

import '../models/movie.dart';

class AppState extends ChangeNotifier {
  final Map<int, Movie> _favorites = {};

  /// La liste des films favoris.
  Iterable<Movie> get favorites => _favorites.values;

  /// Ajoute un film à la liste des favoris.
  void addFavorite(Movie movie) {
    _favorites.putIfAbsent(movie.id, () => movie);
    // ... A COMPLETER ...
  }

  /// Retire un film de la liste des favoris.
  void removeFavorite(Movie movie) {
    _favorites.remove(movie.id);
    // ... A COMPLETER ...
  }

  /// Retire un film des favoris, ou l'ajoute s'il ne l'est pas déjà.
  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      removeFavorite(movie);
    } else {
      addFavorite(movie);
    }
  }

  /// Indique si un film est dans la liste des favoris.
  bool isFavorite(Movie movie) {
    return _favorites.containsKey(movie.id);
  }
}
