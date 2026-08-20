import 'package:flutter/material.dart';

import 'features/home/HomeScreen.dart';
import 'core/utils/app_theme.dart';
import 'features/login/forget_password.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForgetPasswordScreen(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,


    );
  }
}
