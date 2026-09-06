import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/auth/Widget/language_switch.dart';
import 'package:movies_app/features/auth/Widget/profile_avatar_slider.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import 'widgets/register_form_fields.dart';
import 'widgets/register_submit_button.dart';
import '../../../../core/cubit/user_cubit.dart';
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  int selectedAvatar = 1;

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
      avatar: selectedAvatar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.read<UserCubit>().setUser(state.user);
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Image.asset(AppIcons.Back),
          ),
          title: Text(AppStrings.register, style: AppStyles.reg16primary),
        ),
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ProfileAvatarSlider(
                  initialAvatar: selectedAvatar,
                  onAvatarSelected: (avatar) {
                    setState(() => selectedAvatar = avatar);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: AppResponsive.h(context, 16),
                    children: [
                      Text(AppStrings.avatar, style: AppStyles.reg16white),

                      RegisterFormFields(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        phoneController: phoneController,
                      ),

                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return RegisterSubmitButton(
                            isLoading: state is RegisterLoading,
                            onPressed: _onCreateAccountPressed,
                          );
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.alreadyHaveAccount, style: AppStyles.reg14white),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(AppStrings.login, style: AppStyles.reg14primary),
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