import '../../../../../core/errors/api_error.dart';

abstract class ProfileStates  {}
class ProfileInitialState extends ProfileStates{}
class ProfileLoadingState extends ProfileStates{}
class ProfileSuccessState extends ProfileStates{
}
class ProfileErrorState extends ProfileStates{
  final ApiError error;
  ProfileErrorState({required this.error});

}