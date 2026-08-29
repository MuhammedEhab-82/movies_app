import '../../model/user_model.dart';

sealed class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final UserModel user;
  const RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String message;
  const RegisterFailure(this.message);
}