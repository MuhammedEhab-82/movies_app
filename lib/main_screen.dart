import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/utils/app_routes.dart';


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
        initialRoute: AppRoutes.logIn,
        routes: AppRoutes.routes,
      ),
    );
  }
}
