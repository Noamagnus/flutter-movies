import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/service/movie_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.tmdbService}) : super(HomeInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(HomeLoading());
      try {
        final movies = await tmdbService.fetchPopularMovies();
        emit(HomeLoaded(movies));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<SearchMovies>((event, emit) async {
      emit(HomeLoading());
      try {
        final movies = await tmdbService.searchMovies(event.query);
        emit(HomeLoaded(movies));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }

  final TMDBService tmdbService;
}
