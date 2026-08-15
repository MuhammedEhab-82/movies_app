import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_responsive.dart';

class RatingWidget extends StatelessWidget {
  final String rating;
  final Widget icon;

  const RatingWidget({super.key, required this.rating, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 8),
        vertical: AppResponsive.h(context, 4),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 10),
        vertical: AppResponsive.h(context, 8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.transparentBlack,
      ),
      child: Row(
        spacing: AppResponsive.w(context, 4),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
