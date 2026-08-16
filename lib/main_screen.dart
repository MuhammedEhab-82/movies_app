import 'package:flutter/material.dart';

import 'core/utils/app_assets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Main Screen')),
        body: const Center(child: Image(image: AssetImage(AppImages.AppLogo))),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,

    );
  }
}
