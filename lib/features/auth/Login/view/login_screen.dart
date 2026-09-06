import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/Widget/language_switch.dart';
import 'package:movies_app/features/auth/Login/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/Login/cubit/login_state.dart';
import 'package:movies_app/features/auth/Login/utils/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
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
      context.read<LoginCubit>().login(
            email: emailController.text,
            password: passwordController.text,
          );
    }
  }

  void loginWithGoogle() {
    context.read<LoginCubit>().loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Link the login result to the app-wide UserCubit so the
          // Profile tab shows the real logged-in user right away.
          context.read<UserCubit>().setUser(state.user);
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
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
                      validator: LoginValidators.email,
                    ),

                    CustomTextField(
                      controller: passwordController,
                      hintText: AppStrings.password,
                      prefixIcon: AppIcons.Password,
                      isPassword: true,
                      validator: LoginValidators.password,
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

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return SizedBox(
                            height: AppResponsive.h(context, 56),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }
                        return CustomButton(
                          text: AppStrings.login,
                          onPressed: login,
                          width: double.infinity,
                          height: AppResponsive.h(context, 56),
                          borderRadius: 16,
                        );
                      },
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

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const SizedBox.shrink();
                        }
                        return CustomButton(
                          text: AppStrings.loginWithGoogle,
                          onPressed: loginWithGoogle,
                          icon: AppIcons.Google,
                          width: double.infinity,
                          height: AppResponsive.h(context, 56),
                          borderRadius: 16,
                        );
                      },
                    ),
                    LanguageSwitch(isArabic: isArabic),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
