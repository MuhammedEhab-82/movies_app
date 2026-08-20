import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/Widget/language_switch.dart';
import 'package:movies_app/features/auth/Widget/profile_avatar_slider.dart';

import '../../../../core/utils/app_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Image.asset(AppIcons.Back)),
        title: Text(AppStrings.Register,style: AppStyles.reg16primary,),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ProfileAvatarSlider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: AppResponsive.h(context, 16),
              children: [
                Text(AppStrings.Avatar,style: AppStyles.reg16white,),
                CustomTextField(hintText: AppStrings.Name, prefixIcon: AppIcons.Name),
                CustomTextField(hintText: AppStrings.Email, prefixIcon: AppIcons.Email),
                CustomTextField(hintText: AppStrings.Password, prefixIcon: AppIcons.Password,isPassword: true,),
                CustomTextField(hintText: AppStrings.ConfirmPassword, prefixIcon: AppIcons.Password,isPassword: true,),
                CustomTextField(hintText: AppStrings.PhoneNumber, prefixIcon: AppIcons.Phone),
                CustomButton(text: AppStrings.CreateAccount, onPressed: (){},width: double.infinity,height: AppResponsive.h(context, 60),borderRadius: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.AlreadyHaveAccount,style: AppStyles.reg14white,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Text(AppStrings.Login,style: AppStyles.reg14primary,))
                  ],
                ),
                LanguageSwitch(isArabic: false),
              ],
            ),
          )
        ],
      ),
    );
  }
}
