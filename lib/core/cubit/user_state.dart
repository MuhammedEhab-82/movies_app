import '../../features/auth/model/user_model.dart';

sealed class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserAuthenticated extends UserState {
  final UserModel user;
  const UserAuthenticated(this.user);
}


class UserLoggedOut extends UserState {
  const UserLoggedOut();
}


class UserNewVisitor extends UserState {
  const UserNewVisitor();
}