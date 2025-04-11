class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.posterImagePath,
  });

  final int id;

  /// Titre.
  final String title;

  /// Description.
  final String overview;

  /// Date de sortie.
  final DateTime? releaseDate;

  /// Moyenne des votes (sur 10).
  final double voteAverage;

  /// Nombre de votes.
  final int voteCount;

  /// Chemin de l'image de l'affiche.
  final String posterImagePath;

  Movie.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as int,
          title: json['title'],
          overview: json['overview'],
          releaseDate: DateTime.tryParse(json['release_date']),
          voteAverage: json['vote_average'].toDouble(),
          voteCount: json['vote_count'] as int,
          posterImagePath: json['poster_path'] ?? "",
        );
}
