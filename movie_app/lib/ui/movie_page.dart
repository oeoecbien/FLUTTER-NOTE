import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

import 'package:movie_app/services/tmdb_api.dart';
import 'package:movie_app/ui/movies_page.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  FutureBuilder weatherFutureBuilder<T>({
    required Future<T> future,
    required ValueWidgetBuilder<T> builder,
  }) {
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
            'Aucune donnée disponible à cet emplacement.',
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
    final tmdbApi = context.read<TmdbApi>();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            weatherFutureBuilder(
              future: tmdbApi.getRecommendedMovies(widget.movie),
              builder: (context, data, _) {
                return MoviesBlock(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
