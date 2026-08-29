import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import '../../../core/utils/app_strings.dart';
import 'cubit/forget_password_cubit.dart';
import 'cubit/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(),
      child: const _ForgetPasswordView(),
    );
  }
}

class _ForgetPasswordView extends StatefulWidget {
  const _ForgetPasswordView();

  @override
  State<_ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<_ForgetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final RegExp emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }

    return null;
  }

  void _onVerifyPressed() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ForgetPasswordCubit>().sendResetEmail(
      email: _emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset link sent to your email'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: ImageIcon(
              const AssetImage(AppIcons.Back),
              color: AppColors.primary,
              size: AppResponsive.w(context, 21),
            ),
          ),
          title: Text('Forget Password', style: AppStyles.reg14primary),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.w(context, 16),
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: AppResponsive.h(context, 16)),

                    ClipRRect(
                      child: Image.asset(
                        'assets/images/ForgotPasswordVector.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: AppResponsive.h(context, 24)),

                    CustomTextField(
                      controller: _emailController,
                      borderRadius: 15,
                      hintText: AppStrings.email,
                      hintStyle: AppStyles.reg14white,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: _validateEmail,
                      prefixIcon: AppIcons.Email,
                    ),

                    SizedBox(height: AppResponsive.h(context, 20)),

                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        final isLoading = state is ForgetPasswordLoading;

                        return SizedBox(
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomButton(
                                text: isLoading ? '' : 'Verify Email',
                                borderRadius: 15,
                                textStyle: AppStyles.reg14white.copyWith(
                                  color: Colors.black,
                                ),
                                onPressed: _onVerifyPressed,
                                color: AppColors.primary,
                                textColor: Colors.black,
                              ),
                              if (isLoading)
                                const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: AppResponsive.h(context, 24)),
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