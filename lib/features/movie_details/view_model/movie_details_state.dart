import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/features/movie_details/model/movie_details_model.dart';
import 'package:movies_app/features/movie_details/model/movie_suggestion_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  final List<MovieSuggestionModel> suggestions;

  MovieDetailsSuccess({required this.movieDetails, required this.suggestions});
}

class MovieDetailsError extends MovieDetailsState {
  final ApiError error;

  MovieDetailsError(this.error);
}
