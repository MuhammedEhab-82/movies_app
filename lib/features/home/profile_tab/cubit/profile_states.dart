import '../../../../../core/errors/api_error.dart';
import 'package:movies_app/features/auth/model/user_model.dart';

abstract class ProfileStates  {}
class ProfileInitialState extends ProfileStates{}
class ProfileLoadingState extends ProfileStates{}
class ProfileSuccessState extends ProfileStates{
}
class ProfileErrorState extends ProfileStates{
  final ApiError error;
  ProfileErrorState({required this.error});

}

class ProfileUserLoadedState extends ProfileStates{
  final UserModel user;
  ProfileUserLoadedState({required this.user});
}