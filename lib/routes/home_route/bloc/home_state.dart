part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Movie> movies;

  const HomeLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class HomeDetailsLoaded extends HomeState {
  final Map<String, dynamic> movieDetails;

  const HomeDetailsLoaded(this.movieDetails);

  @override
  List<Object?> get props => [movieDetails];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
