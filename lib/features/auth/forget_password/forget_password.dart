import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';

import '../../../core/utils/app_strings.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Verification email sent')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Verify Email',
                      borderRadius: 15,
                      textStyle: AppStyles.reg14white.copyWith(
                        color: Colors.black,
                      ),
                      onPressed: _onVerifyPressed,
                      color: AppColors.primary,
                      textColor: Colors.black,
                    ),
                  ),

                  SizedBox(height: AppResponsive.h(context, 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

