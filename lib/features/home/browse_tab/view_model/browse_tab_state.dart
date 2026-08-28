import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

abstract class BrowseTabState {}

class BrowseTabInitial extends BrowseTabState {}

class BrowseTabLoading extends BrowseTabState {}

class BrowseTabSuccess extends BrowseTabState {
  final List<MovieModel> movies;
  final int selectedIndex;

  BrowseTabSuccess({required this.movies, required this.selectedIndex});
}

class BrowseTabError extends BrowseTabState {
  final ApiError error;

  BrowseTabError(this.error);
}
