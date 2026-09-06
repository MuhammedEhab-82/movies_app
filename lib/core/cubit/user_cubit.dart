import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/model/user_model.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial()) {
    checkAuthStatus();
  }

  final AuthService _authService = AuthService.instance;

  Future<void> checkAuthStatus() async {
    emit(const UserLoading());
    try {
      final user = await _authService.getCurrentUser();
      emit(UserAuthenticated(user));
    } catch (_) {
      final hasSeenIntro = await LocalStorageService.hasSeenIntro();
      emit(hasSeenIntro ? const UserLoggedOut() : const UserNewVisitor());
    }
  }

  void setUser(UserModel user) {
    emit(UserAuthenticated(user));
  }

  Future<void> signOut() async {
    await _authService.signOut();
    emit(const UserLoggedOut());
  }
}