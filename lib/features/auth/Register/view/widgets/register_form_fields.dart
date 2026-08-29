import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../utils/validators.dart';

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
          prefixIcon: AppIcons.Name,
          validator: RegisterValidators.name,
        ),
        CustomTextField(
          controller: emailController,
          hintText: AppStrings.email,
          prefixIcon: AppIcons.Email,
          validator: RegisterValidators.email,
        ),
        CustomTextField(
          controller: passwordController,
          hintText: AppStrings.password,
          prefixIcon: AppIcons.Password,
          isPassword: true,
          validator: RegisterValidators.password,
        ),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: AppStrings.confirmPassword,
          prefixIcon: AppIcons.Password,
          isPassword: true,
          validator: (value) => RegisterValidators.confirmPassword(
            value,
            passwordController.text,
          ),
        ),
        CustomTextField(
          controller: phoneController,
          hintText: AppStrings.phoneNumber,
          prefixIcon: AppIcons.Phone,
          keyboardType: TextInputType.phone,
          validator: RegisterValidators.phone,
        ),
      ],
    );
  }
}