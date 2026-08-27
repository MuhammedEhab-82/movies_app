import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class RecommendBg extends StatelessWidget {
  final String recommendedMovie;
  const RecommendBg({super.key,required this.recommendedMovie});
  @override
  Widget build(BuildContext context) {
    return  Ink.image(
      image: AssetImage(recommendedMovie),
      width: double.infinity,
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.transparentBlack,
              AppColors.semitransparentBlack,
              AppColors.background, // Darkens the bottom
            ],
          ),
        ),
      ),
    );
  }
}
