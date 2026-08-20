import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import '../../../../../core/utils/app_styles.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:  EdgeInsets.symmetric(vertical:AppResponsive.designHeight*0.04,horizontal: AppResponsive.designWidth*0.04),
        child: Stack(
          children: [
            Image.asset(AppImages.MoviesPosters,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
            Column(
              spacing: AppResponsive.designHeight*0.02,
              mainAxisAlignment: MainAxisAlignment.end,
            children: [
                         Text(AppStrings.moviesPosterTitle,style: AppStyles.med36white,textAlign: TextAlign.center,) ,
                         Text(AppStrings.moviesPosterDescription,style:  AppStyles.reg20lightGrey,textAlign: TextAlign.center,) ,
             CustomButton(text: AppStrings.exploreNow,width: double.infinity, onPressed: (){
                    // TODO : NAVIGATE TO ONBOARDING
                    Navigator.of(context).pushNamed(AppRoutes.onBoarding);
                  })
                ],
              ),
          ],
        ),
      )
    );
  }
}
