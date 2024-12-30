part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();
}

final class DetailsInitial extends DetailsState {
  @override
  List<Object> get props => [];
}

final class DetailsLoading extends DetailsState {
  @override
  List<Object> get props => [];
}

final class DetailsLoaded extends DetailsState {
  final Movie movie;

  const DetailsLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class DetailsError extends DetailsState {
  const DetailsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class DetailsSuccess extends DetailsState {
  @override
  List<Object> get props => [];
}
