import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/models/movie.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              // onChanged: (query) {
              //   homeBloc.add(SearchMovies(query));
              // },
              onSubmitted: (query) {
                homeBloc.add(SearchMovies(query));
              },
            ),
          ),
          Row(
            children: [
              TextButton(
                child: Text("Popular Movies"),
                onPressed: () {
                  homeBloc.add(FetchPopularMovies());
                },
              ),
              TextButton(
                child: Text("Top Rated Movies"),
                onPressed: () {
                  homeBloc.add(FetchTopRatedMovies());
                },
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return PopularMovieList(movies: state.movies);
                } else if (state is HomeLoadedTopRated) {
                  return TopRatedList(movies: state.movies, isLoading: state.isLoading,);
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

class PopularMovieList extends StatelessWidget {
  const PopularMovieList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
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
  }
}

class TopRatedList extends StatefulWidget {
  const TopRatedList({
    super.key,
    required this.movies,
    required this.isLoading,
  });

  final List<Movie> movies;
  final bool isLoading;

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        context.read<HomeBloc>().add(FetchMoreTopRatedMovies());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  int getCorrectionIndex(bool isLoading) {
    if (isLoading) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.movies.length + getCorrectionIndex(widget.isLoading),
      itemBuilder: (context, index) {
        if (index < widget.movies.length) {
          final movie = widget.movies[index];
          return MovieHomeTile(
            movie: movie,
            onTap: () {
              context.push(
                '${MovieDetailsRoute.path}/${movie.id}',
              );
            },
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(
              bottom: 200,
            ),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomeRoute extends StatefulWidget {
//   static const String path = '/Home';
//
//   const HomeRoute({
//     super.key,
//   });
//
//   @override
//   State<HomeRoute> createState() => _HomeRouteState();
// }
//
// class _HomeRouteState extends State<HomeRoute> {
//   final ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
//
//   @override
//   void initState() {
//     context.read<HomeBloc>().add(HomeInitialEvent());
//     _scrollController.addListener(() {
//       if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
//         context.read<HomeBloc>().add(HomeLoadNextPage());
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(() {});
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   int getCorrectionIndex(bool isLoading) {
//     if (isLoading) {
//       return 1;
//     }
//     return 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HomeBloc, HomeState>(
//       listener: (context, state) {
//         if (state is HomeSuccess) {
//           showOtrsSnackBar(
//             context: context,
//             message: 'Invite accepted successfully',
//           );
//         }
//         if (state is HomeError) {
//           showOtrsSnackBar(
//             context: context,
//             message: 'Something went wrong, please try again',
//             type: SnackBarType.error,
//           );
//         }
//       },
//       child: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if (state is HomeLoading) {
//             return const Center(
//               child: Loader(),
//             );
//           } else if (state is HomeLoaded) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 5,
//                       vertical: 10,
//                     ),
//                     child: ListView.separated(
//                       controller: _scrollController,
//                       separatorBuilder: (context, index) => const SizedBox(
//                         height: 15,
//                       ),
//                       itemCount: state.listOfJobs.length + getCorrectionIndex(state.isLoading),
//                       itemBuilder: (context, index) {
//                         if (index < state.listOfJobs.length) {
//                           return JobTeaserCard(
//                             job: state.listOfJobs[index],
//                             isFavourite: state.listOfJobs[index].isFavorite ?? false,
//                           );
//                         } else {
//                           return const Padding(
//                             padding: EdgeInsets.only(
//                               bottom: 200,
//                             ),
//                             child: Center(
//                               child: SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else if (state is HomeError) {
//             return Center(
//               child: Text(state.message),
//             );
//           }
//           return const Center(
//             child: Text('Something went wrong...'),
//           );
//         },
//       ),
//     );
//   }
// }
