import 'package:flutter/cupertino.dart';
import 'package:movies_app/core/utils/app_colors.dart';

import '../utils/app_responsive.dart';

class CustomTabBar extends StatelessWidget {
  CustomTabBar({super.key, required this.isSelected, required this.txt});

  bool isSelected;
  String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        //horizontal: AppResponsive.w(context, 10),
        vertical: AppResponsive.h(context, 20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 25),
        vertical: AppResponsive.h(context, 10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        border: BoxBorder.all(
          color: !isSelected ? AppColors.primary : AppColors.transparent,
          width: 2,
        ),
        color: isSelected ? AppColors.primary : AppColors.transparent,
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: isSelected ? AppColors.background : AppColors.primary,
        ),
      ),
    );
  }
}
