import 'package:flutter/material.dart';

import 'features/home/HomeScreen.dart';
import 'core/utils/app_theme.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,


    );
  }
}
