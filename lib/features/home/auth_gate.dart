import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/user_cubit.dart';
import '../../core/cubit/user_state.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../features/auth/Login/view/login_screen.dart';
import 'home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _hasCheckedAuth = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasCheckedAuth && !context.read<UserCubit>().isAuthenticated) {
        _hasCheckedAuth = true;
        context.read<UserCubit>().checkAuthState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          if (currentRoute != AppRoutes.logIn) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.logIn,
              (route) => false,
            );
          }
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            return const HomeScreen();
          }

          if (state is UserUnauthenticated) {
            return const LoginScreen();
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