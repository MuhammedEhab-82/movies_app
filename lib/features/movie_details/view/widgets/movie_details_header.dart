import 'package:flutter/material.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/recommend_bg.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../model/movie_details_model.dart';

class MovieDetailsHeader extends StatelessWidget {
  final MovieDetailsModel movie;

  const MovieDetailsHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = movie.backgroundImage.startsWith('http');

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: AppResponsive.h(context, 600),
           child:RecommendBg(recommendedMovie:  isNetworkImage
                     ? movie.backgroundImage
                     : AppIcons.imagePlaceholder,),),
      //
        // ),
        // Container(
        //   width: double.infinity,
        //   height: AppResponsive.h(context, 600),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         AppColors.transparent,
        //         AppColors.background.withOpacity(0.5),
        //         AppColors.background,
        //       ],
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: AppResponsive.h(context, 250),
          top: AppResponsive.h(context, 150),
          right: AppResponsive.w(context, 100),
          left: AppResponsive.w(context, 100),
          child: Image.asset(AppImages.PlayButton),
        ),
        Positioned(
          bottom: AppResponsive.h(context, 100),
          left: AppResponsive.w(context, 10),
          right: AppResponsive.w(context, 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              movie.title,
              style: AppStyles.bold24white,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: AppResponsive.h(context, 60),
          left: AppResponsive.w(context, 10),
          right: AppResponsive.w(context, 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              movie.year.toString(),
              style: AppStyles.reg20lightGrey,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: AppResponsive.h(context, 0),
          left: AppResponsive.w(context, 10),
          right: AppResponsive.w(context, 10),
          child: CustomButton(
            text: AppStrings.watch,
            onPressed: () {
              //todo: navigate to watch movie screen
            },
            color: AppColors.red,
            textColor: AppColors.white,
            textStyle: AppStyles.bold20white,
            height: AppResponsive.h(context, 55),
          ),
        ),
      ],
    );
  }
}
