import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor:AppColors.background,
    cardColor: AppColors.primary,
    bottomSheetTheme:BottomSheetThemeData(
      modalBackgroundColor: AppColors.gray,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.gray,
      unselectedItemColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.background,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.primary,
        size: 30,
      ),
      titleTextStyle: AppStyles.reg16primary,
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle:AppStyles.bold20black ,
      unselectedLabelStyle:AppStyles.bold20primary,
      indicatorColor: AppColors.primary,
      labelPadding: EdgeInsets.symmetric(vertical:2,horizontal: 4),
    ),
  );
}