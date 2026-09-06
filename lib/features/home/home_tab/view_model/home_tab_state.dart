import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';
import 'package:movies_app/core/errors/api_error.dart';

abstract class HomeTabState {}


class HomeLoadingState extends HomeTabState {}

class HomeSuccessState extends HomeTabState {
  final List<MovieModel> movies;

  HomeSuccessState({required this.movies});
}
class HomeErrorState extends HomeTabState {
  final ApiError error;

  HomeErrorState({required this.error});
}

