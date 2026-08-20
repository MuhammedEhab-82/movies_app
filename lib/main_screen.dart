import 'package:flutter/material.dart';
import 'package:movies_app/features/on_boarding/view/screens/introduction_screen/introduction_screen.dart';

import 'core/utils/app_routes.dart';
import 'features/home/HomeScreen.dart';
import 'features/on_boarding/view/screens/onBoarding_screen/onBoarding.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute:AppRoutes.introduction,
      routes: {
        AppRoutes.onBoarding: (context) => OnBoarding(),
        AppRoutes.home:(context) => HomeScreen(),
        AppRoutes.introduction:(context) => IntroductionScreen(),

      },

    );
  }
}
