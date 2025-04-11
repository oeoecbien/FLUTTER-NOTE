import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'config.dart';

import 'package:movie_app/services/tmdb_api.dart';

import '../ui/movies_page.dart';

void main() {
  Intl.defaultLocale = 'fr_FR';
  initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => TmdbApi(apiKey: tmdbApiKey),
        ),
      ],
      child: const MyMovieApp(),
    ),
  );
}

class MyMovieApp extends StatelessWidget {
  const MyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MoviesPage(),
    );
  }
}
