// todo : view model => state management
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/profile_tab/cubit/profile_states.dart';
import 'package:movies_app/features/auth/model/user_model.dart';
import '../../../../../core/errors/api_error.dart';
import '../../../../../core/utils/fire_base_utils.dart';

class ProfileViewModel extends Cubit<ProfileStates>{
  ProfileViewModel(): super(ProfileInitialState());
  // todo : hold data - handel logic

  UserModel? currentUser;

  Future<void> loadUser(String userId) async {
    emit(ProfileLoadingState());
    try{
      final user = await FireBaseUtils.getUserFromFirestore(userId);
      if(user == null){
        emit(ProfileErrorState(error: ApiError(message: 'User not found')));
        return;
      }
      currentUser = user;
      emit(ProfileUserLoadedState(user: user));
    }catch(e){
      emit(ProfileErrorState(error: ApiError(message: e.toString())));
    }
  }

  Future<void> toggleMovie(String userId, int movieId) async {
    emit(ProfileLoadingState());
    try {
      final user = currentUser ?? await FireBaseUtils.getUserFromFirestore(userId);

      if (user == null) {
        emit(ProfileErrorState(error: ApiError(message: 'User not found')));
        return;
      }

      if (user.watchlist.contains(movieId.toString())) {
        await FireBaseUtils.removeMovieFromWatchlist(
          userId: userId,
          movieId: movieId,
        );
        user.watchlist.remove(movieId.toString());
      } else {
        await FireBaseUtils.addMovieToWatchlist(
          userId: userId,
          movieId: movieId,
        );
        user.watchlist.add(movieId.toString());
      }

      currentUser = user;
      emit(ProfileUserLoadedState(user: user));

    } catch (e) {
      emit(ProfileErrorState(error: ApiError(message: e.toString())));
    }
  }

  Future<void> addToHistory(String userId, int movieId) async {
    try {
      final user = currentUser ?? await FireBaseUtils.getUserFromFirestore(userId);
      if (user == null) {
        emit(ProfileErrorState(error: ApiError(message: 'User not found')));
        return;
      }

      await FireBaseUtils.addMovieToHistory(userId: userId, movieId: movieId);
      if (!user.history.contains(movieId.toString())) {
        user.history.add(movieId.toString());
      }

      currentUser = user;
      emit(ProfileUserLoadedState(user: user));
    } catch (e) {
      emit(ProfileErrorState(error: ApiError(message: e.toString())));
    }
  }
}
