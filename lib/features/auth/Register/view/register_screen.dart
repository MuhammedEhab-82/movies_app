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
        title: Text("Register",style: AppStyles.reg16primary,),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 160,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 0.5,
              enlargeFactor: 0.4,
            ),
            items: [1,2,3,4,5,6,7,8,9].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(0),
                      child: Image.asset("assets/images/ProfileAvatars/2x/Profile0$i.png")
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: AppResponsive.h(context, 16),
              children: [
                Text("Avatar",style: AppStyles.reg16white,),
                CustomTextField(hintText: "Name", prefixIcon: AppIcons.Name),
                CustomTextField(hintText: "Email", prefixIcon: AppIcons.Email),
                CustomTextField(hintText: "Password", prefixIcon: AppIcons.Password,isPassword: true,),
                CustomTextField(hintText: "Confirm Password", prefixIcon: AppIcons.Password,isPassword: true,),
                CustomTextField(hintText: "Phone Number", prefixIcon: AppIcons.Phone),
                CustomButton(text: "Create Account", onPressed: (){},width: double.infinity,height: AppResponsive.h(context, 60),borderRadius: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have Account ? ",style: AppStyles.reg14white,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Text("Login",style: AppStyles.reg14primary,))
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
