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

class HomeLoadedTopRated extends HomeState {
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;
  final bool isLoading;

  const HomeLoadedTopRated({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
    required this.isLoading,
  });

  const HomeLoadedTopRated.initial({
    this.movies = const [],
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoading = true,
  });

  @override
  List<Object?> get props => [movies, page, hasReachedMax];

  HomeLoadedTopRated copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return HomeLoadedTopRated(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }
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
