import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_responsive.dart';

class RecommendBg extends StatelessWidget {
  final String recommendedMovie;
  const RecommendBg({super.key,required this.recommendedMovie});
  @override
  Widget build(BuildContext context) {
    final bool isOfflineCard = recommendedMovie == AppIcons.imagePlaceholder;
    final bool isNetworkImage = recommendedMovie.startsWith('http');
    final imageWidget = isOfflineCard
        ? Image.asset(
      AppIcons.imagePlaceholder,
      fit: BoxFit.contain,
      width: AppResponsive.w(context, 70),
      height: AppResponsive.h(context, 70),
    )
        : Image(
      image: isNetworkImage ? NetworkImage(recommendedMovie) : AssetImage(recommendedMovie),
      fit: BoxFit.cover,
    );
    return  Ink.image(
      image: imageWidget.image,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
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
