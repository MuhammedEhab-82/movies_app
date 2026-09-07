import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/fire_base_utils.dart';
import 'package:movies_app/features/auth/model/user_model.dart';
import 'package:movies_app/features/home/profile_tab/cubit/update_profile_states.dart';

// todo : view model => state management
class UpdateProfileViewModel extends Cubit<UpdateProfileStates>{
  UpdateProfileViewModel(): super(UpdateInitialState());
  // todo : hold data - handel logic
UserModel? currentUser ;
 Future <void> updateData (UserModel newUser) async{
newUser.id = currentUser!.id ;
await FireBaseUtils.updateUserInFirestore(newUser);
currentUser = newUser ;
}
}