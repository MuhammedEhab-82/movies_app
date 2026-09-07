import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/model/user_model.dart';
import '../services/auth_service.dart';
import '../utils/fire_base_utils.dart';
import 'user_state.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  final AuthService _authService = AuthService.instance;

  Future<void> checkAuthState() async {
    emit(const UserLoading());
    final user = await _authService.getCurrentUser();
    if (user != null) {
      emit(UserAuthenticated(user));
    } else {
      emit(const UserUnauthenticated());
    }
  }

  Future<void> deleteAccount(UserModel userModel) async {
    await FireBaseUtils.deleteUserInFirestore(userModel);
    await _authService.deleteAccount();

    emit(const UserUnauthenticated());
  }

  void setUser(UserModel user) {
    emit(UserAuthenticated(user));
  }


  void updateUser(UserModel user) {
    emit(UserAuthenticated(user));
  }

  Future<void> logout() async {
    await _authService.signOut();
    emit(const UserUnauthenticated());
  }

  UserModel? get currentUser {
    final state = this.state;
    return state is UserAuthenticated ? state.user : null;
  }
}
