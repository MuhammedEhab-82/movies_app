import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/services/local_storage_service.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/features/home/auth_gate.dart';
import 'package:movies_app/features/on_boarding/view/screens/introduction_screen.dart';

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
        home: FutureBuilder<bool>(
          future: LocalStorageService.hasSeenIntro(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final hasSeenIntro = snapshot.data ?? false;
            return hasSeenIntro ? const AuthGate() : const IntroductionScreen();
          },
        ),
      ),
    );
  }
}