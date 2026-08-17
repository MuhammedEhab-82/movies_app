import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/features/auth/Login/view/login_screen.dart';
import 'package:movies_app/features/auth/Register/view/register_screen.dart';

import 'features/home/HomeScreen.dart';
import 'core/utils/app_theme.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.logIn,
      routes: AppRoutes.routes,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,


    );
  }
}
