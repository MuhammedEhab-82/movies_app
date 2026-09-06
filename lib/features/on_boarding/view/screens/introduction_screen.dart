import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/services/local_storage_service.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();

    LocalStorageService.markIntroSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.MoviesPosters,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
                vertical: AppResponsive.h(context, 32),
                horizontal: AppResponsive.w(context, 16)
            ),
            child: Column(
              spacing: AppResponsive.h(context, 16),
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.moviesPosterTitle,
                  style: AppStyles.med36white,
                  textAlign: TextAlign.center,
                ),
                Text(
                  AppStrings.moviesPosterDescription,
                  style: AppStyles.reg20lightGrey,
                  textAlign: TextAlign.center,
                ),
                CustomButton(
                  text: AppStrings.exploreNow,
                  width: double.infinity,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.onBoarding);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}