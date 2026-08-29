import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/auth_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterInitial());

  final AuthService _authService = AuthService.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    int avatar = 1,
  }) async {
    emit(const RegisterLoading());
    try {
      final user = await _authService.registerWithEmail(
        name: name,
        email: email,
        password: password,
        phone: phone,
        avatar: avatar,
      );
      emit(RegisterSuccess(user));
    } on AuthException catch (e) {
      emit(RegisterFailure(e.message));
    } catch (_) {
      emit(const RegisterFailure('Something went wrong. Please try again.'));
    }
  }
}