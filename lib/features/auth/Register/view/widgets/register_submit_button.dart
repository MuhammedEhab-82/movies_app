import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_strings.dart';

class RegisterSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomButton(
          text: isLoading ? '' : AppStrings.createAccount,
          onPressed: onPressed,
          width: double.infinity,
          height: AppResponsive.h(context, 60),
          borderRadius: 16,
        ),
        if (isLoading)
          const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
      ],
    );
  }
}