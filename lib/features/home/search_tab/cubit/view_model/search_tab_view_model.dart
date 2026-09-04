import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/search_tab/cubit/view_model/search_states.dart';
import '../../../../../core/errors/api_error.dart';
import '../../../../../core/network/api_service.dart';

class SearchTabViewModel extends Cubit<SearchStates> {
  final MovieService _movieService;

  Timer? _debounce;

  SearchTabViewModel({
    required MovieService movieService,
  })  : _movieService = movieService,
        super(SearchInitialState());

  Future<void> searchMovies(String movieName) async {
    // Cancel the previous timer
    _debounce?.cancel();

    // If search field is empty
    if (movieName.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }


        try {
          emit(SearchLoadingState());

          final movies = await _movieService.getAllMovies(
            movieName: movieName,
          );

          emit(SearchSuccessState(movies: movies));
        } catch (e) {

          emit(
            SearchErrorState(
              error: ApiError(message: e.toString()),
            ),
          );
        }
      }

  }

