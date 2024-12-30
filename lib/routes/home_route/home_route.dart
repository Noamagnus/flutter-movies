import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/routes/details_route/details_route.dart';
import 'package:flutter_movies_app/service/movie_service.dart';
import 'package:flutter_movies_app/utilities/extensions.dart';
import 'package:flutter_movies_app/widgets/movie_home_tile.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_bloc.dart';

class HomeRoute extends StatelessWidget {
  static const path = '/';

  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(tmdbService: context.read<TMDBService>())..add(FetchPopularMovies()),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Movies',
          style: context.textTheme?.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.search),
              ),
              hintText: 'Search movies...',
              onSubmitted: (query) {
                homeBloc.add(SearchMovies(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieHomeTile(
                        movie: movie,
                        onTap: () {
                          context.push(
                            '${MovieDetailsRoute.path}/${movie.id}',
                          );
                        },
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Search or view popular movies.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
