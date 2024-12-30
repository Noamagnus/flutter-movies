import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/routes/details_route/bloc/details_bloc.dart';
import 'package:flutter_movies_app/routes/home_route/home_route.dart';
import 'package:flutter_movies_app/service/movie_service.dart';
import 'package:flutter_movies_app/utilities/helper_functions.dart';
import 'package:flutter_movies_app/utilities/locale_language.dart';
import 'package:flutter_movies_app/widgets/icon_with_text.dart';

class MovieDetailsRoute extends StatelessWidget {
  static const path = '/details';
  static const fullPath = '${HomeRoute.path}/details';
  final String id;

  const MovieDetailsRoute({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc(tmdbService: context.read<TMDBService>())..add(DetailsInitialEvent(movieId: id)),
      child: MovieDetailsView(),
    );
  }
}

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            final movie = state.movie;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        IconWithText(
                          icon: Icons.star_border_outlined,
                          text: movie.voteAverage.toStringAsFixed(1),
                        ),
                        IconWithText(
                          icon: Icons.calendar_today_outlined,
                          text: getYearFromDate(movie.releaseDate),
                        ),
                        IconWithText(
                          icon: Icons.movie,
                          text: '${movie.genres?.map((g) => g.name).join(', ')}',
                        ),
                        IconWithText(
                          icon: Icons.access_time_outlined,
                          text: createRuntimeDisplayValue(movie.runtime),
                        ),
                        IconWithText(
                          icon: Icons.language,
                          text: getHumanReadableLanguage(movie.originalLanguage),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(movie.overview),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is DetailsError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No movie selected.'));
        },
      ),
    );
  }
}
