import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:  EdgeInsets.symmetric(vertical:AppResponsive.designHeight*0.02,horizontal: AppResponsive.designWidth*0.02),
        child: Stack(
          children: [
            Image.asset(AppImages.MoviesPosters,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
              children: [
              AppStrings.moviesPosterTitle,
              AppStrings.moviesPosterDescription,
               CustomButton(text: AppStrings.exploreNow,width: double.infinity, onPressed: (){
                      // TODO : NAVIGATE TO ONBOARDING
                      Navigator.of(context).pushNamed(AppRoutes.onBoarding);
                    })
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
}
