import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

abstract class ProfileTabMoviesState {}

class ProfileTabMoviesInitial extends ProfileTabMoviesState {}

class ProfileTabMoviesLoading extends ProfileTabMoviesState {}

class ProfileTabMoviesLoaded extends ProfileTabMoviesState {
  final List<MovieModel> movies;
  ProfileTabMoviesLoaded({required this.movies});
}

class ProfileTabMoviesError extends ProfileTabMoviesState {
  final String message;
  ProfileTabMoviesError({required this.message});
}
