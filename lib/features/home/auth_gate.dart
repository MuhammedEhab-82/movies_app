import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/user_cubit.dart';
import '../../core/cubit/user_state.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import 'home_screen.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    final userCubit = context.read<UserCubit>();
    // Already loaded (e.g. we just came from Login/Register success) ->
    // no need to hit Firebase/Firestore again.
    if (userCubit.state is! UserAuthenticated) {
      userCubit.checkAuthState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.logIn);
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            return const HomeScreen();
          }
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        },
      ),
    );
  }
}
