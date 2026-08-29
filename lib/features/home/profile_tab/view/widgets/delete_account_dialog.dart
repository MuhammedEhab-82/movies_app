import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

Future<void> showDeleteAccountDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.gray,
        title: Text('Delete Account', style: AppStyles.bold20primary),
        content: Text(
          'Are you sure you want to delete your account? '
              'This action cannot be undone.',
          style: AppStyles.reg16white,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: AppStyles.reg16white),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onConfirm();
            },
            child: Text(
              'Delete',
              style: AppStyles.reg16primary.copyWith(color: AppColors.red),
            ),
          ),
        ],
      );
    },
  );
}