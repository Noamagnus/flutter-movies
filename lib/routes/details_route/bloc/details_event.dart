part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class DetailsInitialEvent extends DetailsEvent {
  final String movieId;

  const DetailsInitialEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class DetailsSecondEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class DetailsThirdEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}
