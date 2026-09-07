import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/features/movie_details/model/movie_details_model.dart';
import 'package:movies_app/features/movie_details/model/movie_suggestion_model.dart';
import 'package:movies_app/features/movie_details/view_model/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieService _movieService;

  MovieDetailsCubit(this._movieService) : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final results = await Future.wait([
        _movieService.getMovieById(movieId),
        _movieService.getMovieSuggestions(movieId),
      ]);

      emit(
        MovieDetailsSuccess(
          movieDetails: results[0] as MovieDetailsModel,
          suggestions: results[1] as List<MovieSuggestionModel>,
        ),
      );
    } catch (e) {
      if (e is ApiError) {
        emit(MovieDetailsError(e));
      } else {
        emit(MovieDetailsError(ApiError(message: e.toString())));
      }
    }
  }
}
