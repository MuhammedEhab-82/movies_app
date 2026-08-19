import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import '../utils/app_responsive.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  final Widget? prefixIcon;
  final bool isPassword;

  /// If true, it will be a password field (it will automatically have an eye icon)

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double borderRadius;
  final Color fillColor;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  const CustomTextField({
    super.key,

    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.borderRadius = 15,
    this.fillColor = AppColors.gray,
    this.textStyle,
    this.hintStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapUpOutside: (details) {
        FocusScope.of(context).unfocus();
      },
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: widget.textStyle ?? AppStyles.reg16white,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppStyles.reg16grey,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.lightGrey,
                ),

                onPressed: () {
                  setState(() => _obscureText = !_obscureText);
                },
              )
            : null,

        contentPadding: EdgeInsets.symmetric(
          vertical: AppResponsive.h(context, 16),
          horizontal: AppResponsive.w(context, 16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.red, width: 1.5),
        ),
      ),
    );
  }
}
