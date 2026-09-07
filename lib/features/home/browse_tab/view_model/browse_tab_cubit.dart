import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_state.dart';

class BrowseTabCubit extends Cubit<BrowseTabState> {
  final MovieService _movieService;

  BrowseTabCubit(this._movieService) : super(BrowseTabInitial());

  final List<String> genres = ["Action", "Drama", "Comedy", "Horror","Sci-Fi","Thriller"];
  int _selectedIndex = 0;

  void getMoviesByGenre(int index) async {
    _selectedIndex = index;
    emit(BrowseTabLoading());
    try
    {
      final
      movies
      =
      await
      _movieService
          .
      getAllMovies
        (
          genre
              :
          genres
          [
          index
          ]
      );
      emit
        (
          BrowseTabSuccess
            (
              movies
                  :
              movies
              ,
              selectedIndex
                  :
              _selectedIndex
          )
      );

    }catch(e){
      if(e is ApiError){
        emit(BrowseTabError(e));
      }else{
        emit(BrowseTabError(ApiError(message: e.toString())));
      }
    }
  }
  int get selectedIndex => _selectedIndex;
}
