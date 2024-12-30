import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/router/router.dart';
import 'package:flutter_movies_app/service/movie_service.dart';
import 'package:flutter_movies_app/theme/theme.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (_) => TMDBService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      theme: darkTheme
    );
  }
}
