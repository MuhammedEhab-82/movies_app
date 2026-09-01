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

void searchMovies(String movieName) {
// Cancel the previous timer
_debounce?.cancel();

// If search field is empty
if (movieName.trim().isEmpty) {
emit(SearchInitialState());
return;
}

// Wait 500ms after the user stops typing
_debounce = Timer(
const Duration(milliseconds: 500),
() async {
emit(SearchLoadingState());

try {
final movies = await _movieService.searchMovies(movieName);

emit(SearchSuccessState(movies: movies));
} catch (e) {
emit(
SearchErrorState(
error: ApiError(message: e.toString()),
),
);
}
},
);
}

@override
Future<void> close() {
_debounce?.cancel();
return super.close();
}
}

