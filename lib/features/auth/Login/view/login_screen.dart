import 'package:flutter/cupertino.dart';
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

class LoginScreen extends StatelessWidget {
  bool isArabic = false;
  LoginScreen({super.key});
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
          child: Column(
            spacing: AppResponsive.h(context, 20),
            children: [
              SizedBox(height: AppResponsive.h(context, 15)),
              Image.asset(AppImages.AppLogo),
              SizedBox(height: AppResponsive.h(context, 25)),
              CustomTextField(
                hintText: AppStrings.Email,
                prefixIcon: AppIcons.Email,
              ),
              CustomTextField(
                hintText: AppStrings.Password,
                prefixIcon: AppIcons.Password,
                isPassword: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
                    child: Text(
                      AppStrings.ForgetPassword,
                      style: AppStyles.reg14primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppResponsive.h(context, 3)),
              CustomButton(
                text: AppStrings.Login,
                  onPressed: (){
                    login(context);
                  },
                width: double.infinity,
                height: AppResponsive.h(context, 56),
                borderRadius: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.DontHaveAccount, style: AppStyles.reg14white),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.signUp);
                    },
                    child: Text(
                      AppStrings.CreateOne,
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
                  Text(AppStrings.OR, style: AppStyles.reg16primary),
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
                text: AppStrings.LoginWithGoogle,
                onPressed: (){
                  loginWithGoogle(context);
                },
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
    );
  }

  void login(BuildContext context) {
    // todo FireBase Auth

    // todo validation
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }
  void loginWithGoogle(BuildContext context) {
    // todo Google Auth

    // todo validation
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }
}
