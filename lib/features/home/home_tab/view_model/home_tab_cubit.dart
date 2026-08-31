import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_tab_state.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/errors/api_error.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  final MovieService _movieService;
  HomeTabCubit(this._movieService): super(HomeLoadingState());

  void getLastMovies() async {
    emit(HomeLoadingState());
    try {
      final movies = await _movieService.getAllMovies(
        limit: 5
      );
      emit(HomeSuccessState(movies: movies));
    } catch (e) {
      emit(HomeErrorState(error: ApiError(message: e.toString())));
    }
  }
}