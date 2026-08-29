import 'package:flutter/material.dart';

import '../../../../../core/utils/app_responsive.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatarPath;
  final VoidCallback onTap;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.avatarPath,
    required this.onTap,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppResponsive.w(context, size),
        height: AppResponsive.w(context, size),
        child: ClipOval(
          child: Image.asset(avatarPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}