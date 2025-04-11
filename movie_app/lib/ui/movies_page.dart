import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

import 'package:movie_app/services/tmdb_api.dart';
import 'package:movie_app/ui/movie_page.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  FutureBuilder movieFutureBuilder<T>({
    // Le FutureBuilder est un widget qui construit son contenu en fonction de l'état d'un Future.
    // Un Future étant une opération asynchrone qui peut se terminer avec succès ou échouer.
    required Future<T> future,
    // ValueWidgetBuilder est une fonction qui construit un widget en fonction de l'état du Future.
    required ValueWidgetBuilder<T> builder,
  }) {
    // Le FutureBuilder est utilisé pour construire le widget en fonction de l'état du Future.
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final theme = Theme.of(context);

        if (snapshot.hasError) {
          return Text(
            'Une erreur est survenue.\n${snapshot.error?.toString()}',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.error,
              fontStyle: FontStyle.italic,
            ),
          );
        }

        if (!snapshot.hasData) {
          return Text(
            'Aucune données disponibles.',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontStyle: FontStyle.italic,
            ),
          );
        }

        return builder(context, snapshot.data!, null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tmdbApiApi = context.read<TmdbApi>();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            movieFutureBuilder(
              future: tmdbApiApi.getPopularMovies(),
              builder: (context, data, _) {
                return MovieBlock(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _formatVote(double value) =>
    '${((value * 10).round() / 10)}/10 en moyenne';

class MovieBlock extends StatelessWidget {
  const MovieBlock(this.movies, {super.key});

  final Iterable<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "lES FILMS POPULAIRES",
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (Movie movie in movies)
                ListTile(
                  title: Text(movie.title),
                  subtitle: Text(
                      '${_formatVote(movie.voteAverage)} ${movie.voteCount}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MoviePage(movie: movie),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
