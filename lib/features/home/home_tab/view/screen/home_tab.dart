import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/custom_slider.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/latest_movies.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/movie_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/home_tab/view_model/home_tab_cubit.dart';
import 'package:movies_app/features/home/home_tab/view_model/home_tab_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../browse_tab/model/movie_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

final MovieService movieService = MovieService(DioClient());

class _HomeTabState extends State<HomeTab> {
  final cubit = HomeTabCubit(MovieService(DioClient()));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getLastMovies();
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
            child: BlocBuilder<HomeTabCubit, HomeTabState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is HomeSuccessState) {
                  return LatestMovies(state: state);
                } else if (state is HomeErrorState) {
                  return Center(
                    child: Text(
                      state.error.message,
                      style: AppStyles.reg16white,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Image.asset(AppImages.AvailableNow),
                      Skeletonizer(
                        child: CustomSlider(
                          state: HomeSuccessState(
                            movies: List.generate(5, (_) => MovieModel.empty()),
                          ),
                          pageIndex: 0,
                        ),
                      ),
                      Image.asset(AppImages.WatchNow),
                    ],
                  );
                }
              },
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
