import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/Widget/language_switch.dart';
import 'package:movies_app/features/auth/Widget/profile_avatar_slider.dart';

import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void createAccount() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppIcons.Back),
        ),
        title: Text(
          AppStrings.Register,
          style: AppStyles.reg16primary,
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ProfileAvatarSlider(),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: AppResponsive.h(context, 16),
                  children: [
                    Text(
                      AppStrings.Avatar,
                      style: AppStyles.reg16white,
                    ),

                    // Name
                    CustomTextField(
                      controller: nameController,
                      hintText: AppStrings.Name,
                      prefixIcon: AppIcons.Name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required";
                        }

                        if (value.trim().length < 3) {
                          return "Name must be at least 3 characters";
                        }

                        return null;
                      },
                    ),

                    // Email
                    CustomTextField(
                      controller: emailController,
                      hintText: AppStrings.Email,
                      prefixIcon: AppIcons.Email,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Please enter a valid email";
                        }

                        return null;
                      },
                    ),

                    // Password
                    CustomTextField(
                      controller: passwordController,
                      hintText: AppStrings.Password,
                      prefixIcon: AppIcons.Password,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),

                    // Confirm Password
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: AppStrings.ConfirmPassword,
                      prefixIcon: AppIcons.Password,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }

                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    // Phone Number
                    CustomTextField(
                      controller: phoneController,
                      hintText: AppStrings.PhoneNumber,
                      prefixIcon: AppIcons.Phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        }

                        final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

                        if (!phoneRegex.hasMatch(value.trim())) {
                          return "Please enter a valid phone number";
                        }

                        return null;
                      },
                    ),

                    CustomButton(
                      text: AppStrings.CreateAccount,
                      onPressed: createAccount,
                      width: double.infinity,
                      height: AppResponsive.h(context, 60),
                      borderRadius: 16,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.AlreadyHaveAccount,
                          style: AppStyles.reg14white,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppStrings.Login,
                            style: AppStyles.reg14primary,
                          ),
                        ),
                      ],
                    ),

                    LanguageSwitch(isArabic: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
