import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/service/movie_service.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({required this.tmdbService}) : super(DetailsInitial()) {
    on<DetailsInitialEvent>((event, emit) async {
      emit(DetailsLoading());
      try {
        final movieDetails = await tmdbService.fetchMovieDetails(event.movieId);
        emit(DetailsLoaded(movie: movieDetails));
      } catch (e) {
        emit(DetailsError(e.toString()));
      }
    });
  }
  final TMDBService tmdbService;
}
