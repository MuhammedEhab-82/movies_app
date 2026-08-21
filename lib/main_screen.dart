import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Main Screen')),
        body: const Center(child: Text('Welcome to the Main Screen!')),
      ),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

    );
  }
}
