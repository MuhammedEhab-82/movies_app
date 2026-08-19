import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import '../utils/app_responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final bool isOutlined;

  /// If it's true, the button will be outlined (with a border only) instead of being full.

  final Color color;

  final Color textColor;

  final String? icon;

  final double? width;

  final double height;
  final double borderRadius;

  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.color = AppColors.primary,
    this.textColor = AppColors.background,
    this.icon,
    this.width,
    this.height = 48,
    this.borderRadius = 24,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (textStyle ?? AppStyles.bold20black).copyWith(
      color: isOutlined ? color : textColor,
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: effectiveStyle),
        if (icon != null) ...[
          SizedBox(width: AppResponsive.w(context, 6)),
          Image.asset(
            icon!,
            color: isOutlined ? color : textColor,
            width: (effectiveStyle.fontSize ?? 20) + 2,
            height: (effectiveStyle.fontSize ?? 20) + 2,
          ),
        ],
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: color,
                  width: AppResponsive.w(context, 1.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.w(context, 20),
                ),
              ),
              child: content,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.w(context, 20),
                ),
              ),
              child: content,
            ),
    );
  }
}
