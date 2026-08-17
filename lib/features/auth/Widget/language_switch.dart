import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_responsive.dart';

class LanguageSwitch extends StatelessWidget {
  bool isArabic;
  LanguageSwitch({super.key,required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.transparentBlack,
          border: Border.all(color: AppColors.primary),borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppResponsive.w(context, 30),
          children: [
            InkWell(
              onTap: (){

              },
              child: Container(
                  decoration: BoxDecoration(border:Border.all(color: isArabic?AppColors.transparentBlack:AppColors.primary,
                      width: 5),borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(AppIcons.LR,)),
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                  decoration: BoxDecoration(border:Border.all(color: isArabic?AppColors.primary:AppColors.transparentBlack,
                      width: 5),borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(AppIcons.EG)),
            ),
          ],
        ),
      ),
    );
  }
}
