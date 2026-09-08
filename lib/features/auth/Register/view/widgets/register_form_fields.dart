import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_strings.dart';
import 'package:movies_app/core/utils/validators.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  const RegisterFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        CustomTextField(
          controller: nameController,
          hintText: AppStrings.name,
          prefixIcon: AppIcons.name,
          validator: Validators.name,
        ),
        CustomTextField(
          controller: emailController,
          hintText: AppStrings.email,
          prefixIcon: AppIcons.email,
          validator: Validators.email,
        ),
        CustomTextField(
          controller: passwordController,
          hintText: AppStrings.password,
          prefixIcon: AppIcons.password,
          isPassword: true,
          validator: Validators.password,
        ),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: AppStrings.confirmPassword,
          prefixIcon: AppIcons.password,
          isPassword: true,
          validator: (value) => Validators.confirmPassword(
            value,
            passwordController.text,
          ),
        ),
        CustomTextField(
          controller: phoneController,
          hintText: AppStrings.phoneNumber,
          prefixIcon: AppIcons.phone,
          keyboardType: TextInputType.phone,
          validator: Validators.phone,
        ),
      ],
    );
  }
}