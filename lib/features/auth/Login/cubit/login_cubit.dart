import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/auth_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  final AuthService _authService = AuthService.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());
    try {
      final user = await _authService.loginWithEmail(
        email: email,
        password: password,
      );
      emit(LoginSuccess(user));
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(const LoginFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(const LoginLoading());
    try {
      final user = await _authService.signInWithGoogle();
      emit(LoginSuccess(user));
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(const LoginFailure('Something went wrong. Please try again.'));
    }
  }
}
