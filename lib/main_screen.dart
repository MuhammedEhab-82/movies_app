import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_routes.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute:AppRoutes.introduction,
      routes: AppRoutes.routes,

    );
  }
}
