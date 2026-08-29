import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/auth_service.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> sendResetEmail({required String email}) async {
    emit(ForgetPasswordLoading());

    try {
      await AuthService.instance.sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccess());
    } on AuthException catch (e) {
      emit(ForgetPasswordFailure(e.message));
    } catch (e) {
      emit(ForgetPasswordFailure('Something went wrong. Please try again.'));
    }
  }
}