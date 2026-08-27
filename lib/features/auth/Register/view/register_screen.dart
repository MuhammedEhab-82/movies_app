import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
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

  void _onCreateAccountPressed() {
    if (!formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppIcons.Back),
          ),
          title: Text(
            AppStrings.register,
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
                        AppStrings.avatar,
                        style: AppStyles.reg16white,
                      ),

                      CustomTextField(
                        controller: nameController,
                        hintText: AppStrings.name,
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

                      CustomTextField(
                        controller: emailController,
                        hintText: AppStrings.email,
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

                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: AppStrings.confirmPassword,
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

                      CustomTextField(
                        controller: phoneController,
                        hintText: AppStrings.phoneNumber,
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

                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          final isLoading = state is RegisterLoading;

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomButton(
                                text: isLoading ? '' : AppStrings.createAccount,
                                onPressed: _onCreateAccountPressed,
                                width: double.infinity,
                                height: AppResponsive.h(context, 60),
                                borderRadius: 16,
                              ),
                              if (isLoading)
                                const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAccount,
                            style: AppStyles.reg14white,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppStrings.login,
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
      ),
    );
  }
}