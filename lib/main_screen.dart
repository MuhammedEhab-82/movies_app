import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/cubit/user_state.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'features/auth/Login/view/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/on_boarding/view/screens/introduction_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        home: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading || state is UserInitial) {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is UserAuthenticated) {
              return const HomeScreen();
            }

            if (state is UserLoggedOut) {
              return const LoginScreen();
            }

            return const IntroductionScreen();
          },
        ),
      ),
    );
  }
}