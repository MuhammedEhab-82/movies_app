import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import '../../../../core/utils/app_colors.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({
    super.key,
    this.radius = 16,
    this.color = AppColors.gray,
    required this.image,
    required this.castName,
    required this.characterName,
  });

  final double radius;
  final Color? color;
  final String image;
  final String castName;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(context, 20)),
      child: Container(
        padding: EdgeInsetsGeometry.all(AppResponsive.w(context, 10)),
        //height: AppResponsive.h(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(radius),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(image),
            SizedBox(width: AppResponsive.w(context, 10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppResponsive.h(context, 10),
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${AppStrings.castName}: $castName',
                      style: AppStyles.reg20white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${AppStrings.characterName}: ',
                          style: AppStyles.reg20white,
                        ),
                        TextSpan(
                          text: characterName,
                          style: AppStyles.reg20white,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
