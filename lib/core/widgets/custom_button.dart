import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final bool isOutlined; /// If it's true, the button will be outlined (with a border only) instead of being full.

  final Color color;


  final Color textColor;

  final IconData? icon;

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
    this.textColor = AppColors.black,
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
          const SizedBox(width: 6),
          Icon(
            icon,
            color: isOutlined ? color : textColor,
            size: (effectiveStyle.fontSize ?? 20) + 2,
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
          side: BorderSide(color: color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: content,
      ),
    );
  }
}