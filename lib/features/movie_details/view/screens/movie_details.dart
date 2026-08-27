import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/recommend_bg.dart';

import '../../../../core/widgets/movie_card.dart';
import '../widgets/cast.dart';
import '../widgets/screenShots.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  static final List<String> screenshotsMovies = [
    AppImages.Screenshots1,
    AppImages.Screenshots2,
    AppImages.Screenshots3,
  ];
  static final List<String> images = [
    AppImages.MoviePoster1,
    AppImages.MoviePoster2,
    AppImages.MoviePoster3,
    AppImages.MoviePoster4,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
            size: 30,
          ),
        ),
        actions: [Icon(Icons.bookmark, color: AppColors.white, size: 30)],

        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          spacing: AppResponsive.h(context, 20),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppResponsive.h(context, 700),
                  child: RecommendBg(recommendedMovie: AppImages.MoviePoster1),
                ),
                Positioned(
                  bottom: AppResponsive.h(context, 300),
                  top: AppResponsive.h(context, 200),
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
                      "Doctor Strange in the Multiverse  of Madness",
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
                      "2022",
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: " 15 ",
                  onPressed: () {},
                  icon: AppIcons.Favourite,
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
                CustomButton(
                  text: " 90 ",
                  onPressed: () {},
                  icon: AppIcons.Watch,
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
                CustomButton(
                  text: " 7.6 ",
                  onPressed: () {},
                  icon: AppIcons.Star,
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(AppStrings.screenshots, style: AppStyles.bold20white),
            ),
            ScreenShots(
              itemCount: screenshotsMovies.length,
              images: screenshotsMovies,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(AppStrings.similar, style: AppStyles.bold20white),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsGeometry.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return MovieCard(path: images[index], rating: '8.5');
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(AppStrings.summery, style: AppStyles.bold20white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(
                "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                style: AppStyles.reg16white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(AppStrings.cast, style: AppStyles.bold20white),
            ),
            CastWidget(
              image: AppImages.Profile01,
              castName: " Hayley Atwell ",
              characterName: "Captain Carter",
            ),
            CastWidget(
              image: AppImages.Profile01,
              castName: "Elizabeth Olsen ",
              characterName: "Wanda Maximoff / The Scarlet Witch",
            ),
            CastWidget(
              image: AppImages.Profile01,
              castName: "Rachel McAdams ",
              characterName: "Dr. Christine Palmer",
            ),
            CastWidget(
              image: AppImages.Profile01,
              castName: "Charlize Theron ",
              characterName: "Clea",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 20),
              ),
              child: Text(AppStrings.genres, style: AppStyles.bold20white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                CustomButton(
                  text: AppStrings.action,
                  onPressed: () {
                    // todo:go to action movies
                  },
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
                CustomButton(
                  text: AppStrings.sciFi,
                  onPressed: () {
                    // todo:go to Sci_Fi movies
                  },
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
                CustomButton(
                  text: AppStrings.adventure,
                  onPressed: () {
                    // todo:go to adventure movies
                  },
                  color: AppColors.gray,
                  textColor: AppColors.white,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 15),
              ),
              child: Row(
                spacing: AppResponsive.w(context, 10),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    text: AppStrings.fantasy,
                    onPressed: () {
                      // todo:go to fantasy movies
                    },
                    color: AppColors.gray,
                    textColor: AppColors.white,
                  ),
                  CustomButton(
                    text: AppStrings.horror,
                    onPressed: () {
                      // todo:go to horror movies
                    },
                    color: AppColors.gray,
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppResponsive.h(context, 50)),
          ],
        ),
      ),
    );
  }
}
