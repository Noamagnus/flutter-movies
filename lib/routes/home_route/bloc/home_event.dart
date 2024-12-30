part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchPopularMovies extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SearchMovies extends HomeEvent {
  final String query;

  const SearchMovies(this.query);

  @override
  List<Object?> get props => [query];
}
