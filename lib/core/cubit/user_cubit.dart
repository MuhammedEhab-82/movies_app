import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/model/user_model.dart';
import '../services/auth_service.dart';
import '../utils/fire_base_utils.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  final AuthService _authService = AuthService.instance;

  Future<void> checkAuthState() async {
    if (isClosed) return;

    emit(const UserLoading());
    final user = await _authService.getCurrentUser();

    if (isClosed) return;

    emit(user != null ? UserAuthenticated(user) : const UserUnauthenticated());
  }

  Future<void> deleteAccount(UserModel userProfile) async {
    await FireBaseUtils.deleteUserInFirestore(userProfile);
    await _authService.deleteAccount();

    if (!isClosed) {
      emit(const UserUnauthenticated());
    }
  }

  void setUser(UserModel user) {
    if (!isClosed) {
      emit(UserAuthenticated(user));
    }
  }

  void updateUser(UserModel user) {
    if (!isClosed) {
      emit(UserAuthenticated(user));
    }
  }

  Future<void> logout() async {
    await _authService.signOut();

    if (!isClosed) {
      emit(const UserUnauthenticated());
    }
  }

  UserModel? get currentUser {
    final currentState = state;
    return currentState is UserAuthenticated ? currentState.user : null;
  }

  bool get isAuthenticated => state is UserAuthenticated;
}