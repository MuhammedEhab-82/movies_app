import 'package:flutter/material.dart';
import 'package:movies_app/features/movie_details/view/screens/movie_details.dart';

import '../../features/auth/Login/view/login_screen.dart';
import '../../features/auth/Register/view/register_screen.dart';
import '../../features/auth/forget_password/forget_password.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/profile_tab/view/screens/edit_profile.dart';
import '../../features/on_boarding/view/screens/introduction_screen.dart';
import '../../features/on_boarding/view/screens/onBoarding.dart';

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
    introduction: (context) => const IntroductionScreen(),
    onBoarding: (context) => const OnBoarding(),
    logIn: (context) => LoginScreen(),
    signUp: (context) => SignUpScreen(),
    home: (context) => const HomeScreen(),
    updateProfile: (context) => const UpdateProfileScreen(),
    forgotPassword: (context) => const ForgetPasswordScreen(),
    movieDetails: (context) {
      final arguments = ModalRoute
          .of(context)
          ?.settings
          .arguments;
      final int movieId = arguments is int ? arguments : 0;

      return MovieDetails(
        movieId: movieId,
      );
    },
  };
}