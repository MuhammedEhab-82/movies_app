import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/Widget/language_switch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isArabic = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  void loginWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppResponsive.h(context, 30),
            horizontal: AppResponsive.w(context, 20),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: AppResponsive.h(context, 20),
                children: [
                  SizedBox(height: AppResponsive.h(context, 15)),

                  Image.asset("assets/images/2x/AppLogo.png"),

                  SizedBox(height: AppResponsive.h(context, 25)),

                  CustomTextField(
                    controller: emailController,
                    hintText: AppStrings.email,
                    prefixIcon: AppIcons.Email,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return "Please enter a valid email";
                      }

                      return null;
                    },
                  ),

                  CustomTextField(
                    controller: passwordController,
                    hintText: AppStrings.password,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.forgotPassword),
                        child: Text(
                          AppStrings.forgetPassword,
                          style: AppStyles.reg14primary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppResponsive.h(context, 3)),

                  CustomButton(
                    text: AppStrings.login,
                    onPressed: login,
                    width: double.infinity,
                    height: AppResponsive.h(context, 56),
                    borderRadius: 16,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: AppStyles.reg14white,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.signUp);
                        },
                        child: Text(
                          AppStrings.createOne,
                          style: AppStyles.reg14primary,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          indent: AppResponsive.w(context, 75),
                          endIndent: AppResponsive.w(context, 20),
                          thickness: 1,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(AppStrings.or, style: AppStyles.reg16primary),
                      Expanded(
                        child: Divider(
                          indent: AppResponsive.w(context, 20),
                          endIndent: AppResponsive.w(context, 75),
                          thickness: 1,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  CustomButton(
                    text: AppStrings.loginWithGoogle,
                    onPressed: loginWithGoogle,
                    icon: AppIcons.Google,
                    width: double.infinity,
                    height: AppResponsive.h(context, 56),
                    borderRadius: 16,
                  ),
                  LanguageSwitch(isArabic: isArabic),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

