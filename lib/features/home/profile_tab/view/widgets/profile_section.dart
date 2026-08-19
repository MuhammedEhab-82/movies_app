import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../model/user_profile.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          spacing: AppResponsive.h(context, 15),
          children: [
            Image.asset(
              userProfile.avatarUrl,
              fit: BoxFit.cover,
              width: AppResponsive.w(context, 118),
            ),
            Text(userProfile.name, style: AppStyles.bold20white),
          ],
        ),
        Column(
          spacing: AppResponsive.h(context, 20),
          children: [
            Text(
              '${userProfile.watchlist!.length}',
              style: AppStyles.bold36white,
            ),
            Text(AppStrings.watchlist, style: AppStyles.bold24white),
          ],
        ),
        Column(
          spacing: AppResponsive.h(context, 20),

          children: [
            Text(
              '${userProfile.history!.length}',
              style: AppStyles.bold36white,
            ),
            Text(AppStrings.history, style: AppStyles.bold24white),
          ],
        ),
      ],
    );
  }
}
