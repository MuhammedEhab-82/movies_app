import 'package:flutter/material.dart';

import 'core/utils/app_theme.dart';
import 'features/home/HomeScreen.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,


    );
  }
}
