import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_tab_state.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/errors/api_error.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  final MovieService _movieService;
  HomeTabCubit(this._movieService) : super(HomeLoadingState());
  // some genres
  final List<String> genres = ["Action", "Drama", "Comedy", "Horror","Sci-Fi","Thriller"];

  void getLastMovies({int? genreIndex,String? sorting}) async {
    emit(HomeLoadingState());
    try {
      final movies = await _movieService.getAllMovies(
        sortBy: sorting,
        limit: 5,
        genre: genreIndex != null ? genres[genreIndex] : null,
      );
      emit(HomeSuccessState(movies: movies));
    } catch (e) {
      emit(HomeErrorState(error: ApiError(message: e.toString())));
    }
  }
}
