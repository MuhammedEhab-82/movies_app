import 'package:flutter/material.dart';

import '../../features/auth/Login/view/login_screen.dart';
import '../../features/auth/Register/view/register_screen.dart';

class AppRoutes {

  static const String onBoarding = '/onBoarding';
  static const String introduction = '/introduction';
  static const String logIn = '/logIn';
  static const String forgotPassword = '/forgotPassword';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String updateProfile = '/updateProfile';
  static const String movieDetails = '/movieDetails';

  static Map<String, WidgetBuilder> routes = {
    // onBoarding: (context) => const OnboardingScreen(),
     logIn: (context) => LoginScreen(),
     signUp: (context) => SignUpScreen(),
    // home: (context) => const HomeScreen(),
    // updateProfile: (context) => const UpdateProfileScreen(),
    // forgotPassword: (context) => const ForgotPasswordScreen(),
    // movieDetails: (context) => const MovieDetailsScreen(),
  };
}
