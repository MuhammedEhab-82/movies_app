import 'package:flutter/material.dart';
import 'features/home/HomeScreen.dart';
import 'core/utils/app_theme.dart';
import 'features/home/profile_tab/view/screens/edit_profile.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const UpdateProfileScreen(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,


    );
  }
}
