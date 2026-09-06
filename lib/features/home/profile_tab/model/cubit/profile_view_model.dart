// todo : view model => state management
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/profile_tab/model/cubit/profile_states.dart';
import '../../../../../core/errors/api_error.dart';
import '../../../../../core/utils/fire_base_utils.dart';

class ProfileViewModel extends Cubit<ProfileStates>{
  ProfileViewModel(): super(ProfileInitialState());
  // todo : hold data - handel logic

  // Future<void> addMovie(String userId, int movieId) async {
  //   emit(ProfileLoadingState());
  //   try{
  //     await FireBaseUtils.addMovieToWatchlist(
  //       userId: userId,
  //       movieId: movieId,
  //     );
  //     emit(ProfileSuccessState());
  //   }catch(e){
  //    emit(ProfileErrorState(error: ApiError(message: e.toString())));
  //   }
  // }

  // Future<void>removeMovie (String userId , int movieId)async{
  //   await FireBaseUtils.removeMovieFromWatchlist(movieId:movieId,userId: userId);
  // }

  Future<void> toggleMovie(String userId, int movieId) async {
    emit(ProfileLoadingState());
    try {
      final user = await FireBaseUtils.getUserFromFirestore(userId);

      if (user == null) {
        return;
      }

      if (user.watchlist.contains(movieId.toString())) {
        await FireBaseUtils.removeMovieFromWatchlist(
          userId: userId,
          movieId: movieId,
        );
        emit(ProfileSuccessState());

      } else {
        await FireBaseUtils.addMovieToWatchlist(
          userId: userId,
          movieId: movieId,
        );
        emit(ProfileSuccessState());

      }
    } catch (e) {
      emit(ProfileErrorState(error: ApiError(message: e.toString())));
    }
  }
  // Future<void> updateWatchlist({
  //   required String userId,
  //   required int movieId,
  //   required bool isFavourite,
  // }) async {
  //   emit(ProfileLoadingState());
  //   try {
  //     if (isFavourite) {
  //       await FireBaseUtils.addMovieToWatchlist(
  //         userId: userId,
  //         movieId: movieId,
  //       );
  //       emit(ProfileSuccessState());
  //     } else {
  //       await FireBaseUtils.removeMovieFromWatchlist(
  //         userId: userId,
  //         movieId: movieId,
  //       );
  //       emit(ProfileSuccessState());
  //     }
  //   } catch (e) {
  //     emit(ProfileErrorState(error: ApiError(message: e.toString())));
  //
  //   }
  // }
}
