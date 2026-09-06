import 'package:movies_app/core/errors/api_error.dart';
import '../../../browse_tab/model/movie_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
final List<MovieModel> movies;

SearchSuccessState({required this.movies});
}

class SearchErrorState extends SearchStates {
final ApiError error;

SearchErrorState({
required this.error});
}

