import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onSave;

  const ProfileActionButtons({
    super.key,
    required this.onDelete,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Delete Account',
            borderRadius: 15,
            textStyle: AppStyles.reg14white,
            onPressed: onDelete,
            color: AppColors.red,
            textColor: AppColors.white,
          ),
        ),
        SizedBox(height: AppResponsive.h(context, 12)),

        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Update Data',
            borderRadius: 15,
            textStyle: AppStyles.reg14white,
            onPressed: onSave,
            color: AppColors.primary,
            textColor: Colors.black,
          ),
        ),
      ],
    );
  }
}