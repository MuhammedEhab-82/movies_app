import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/movie_list_view.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/recommend_bg.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

final MovieService movieService = MovieService(
  DioClient(),
);

class _HomeTabState extends State<HomeTab> {
  late int pageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<String> recommendedMovies = [
      AppImages.MoviePoster1,
      AppImages.MoviePoster2,
      AppImages.MoviePoster3,
      AppImages.MoviePoster4,
      AppImages.MoviePoster5,
      AppImages.MoviePoster6,
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppResponsive.h(context, 650),
            child: Stack(
              children: [
                RecommendBg(recommendedMovie: recommendedMovies[pageIndex]),
                Column(
                  children: [
                    Image.asset(AppImages.AvailableNow),
                    CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          pageIndex = index;
                          setState(() {});
                        },
                        initialPage: pageIndex,
                        disableCenter: true,
                        enlargeCenterPage: true,
                        viewportFraction:
                            AppResponsive.w(context, 234) /
                            AppResponsive.designWidth,
                        height: AppResponsive.h(context, 400),
                      ),
                      items: recommendedMovies.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return MovieCard(
                              path: i,
                              rating: '7.7',
                              isRecommended: true,
                              movieId: 78168,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Image.asset(AppImages.WatchNow),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(AppStrings.action, style: AppStyles.reg20white),
              Spacer(),
              TextButton(
                onPressed: () {
                  //todo : navigate
                },
                child: Row(
                  children: [
                    Text(AppStrings.seeMore, style: AppStyles.reg16primary),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          MovieListView(recommendedMovies: recommendedMovies),
        ],
      ),
    );
  }
}
