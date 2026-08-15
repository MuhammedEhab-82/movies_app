import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_theme.dart';

import 'core/widgets/custom_button.dart';
import 'core/widgets/custom_text_field.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Main Screen')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Main Screen!'),
              const SizedBox(height: 16),
              CustomButton(
                text: 'hy',
                onPressed: () {},
              ),
              CustomTextField(
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              )
            ],
          ),
        ),
      ),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
