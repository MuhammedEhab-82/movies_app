import 'dart:math';

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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/movie_list_view.dart';
import 'package:movies_app/features/home/home_tab/view_model/home_tab_cubit.dart';
import 'package:movies_app/features/home/home_tab/view_model/home_tab_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../browse_tab/model/movie_model.dart';

class HomeTab extends StatefulWidget {
  final void Function(int genreIndex)? onNavigateToBrowse;
  const HomeTab({super.key, this.onNavigateToBrowse});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

final MovieService movieService = MovieService(DioClient());

class _HomeTabState extends State<HomeTab> {
  final lastMoviesCubit = HomeTabCubit(MovieService(DioClient()));
  final listCubit = HomeTabCubit(MovieService(DioClient()));
  late int randomGenre;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastMoviesCubit.getLastMovies();
    Random random = Random();
    randomGenre = random.nextInt(lastMoviesCubit.genres.length);
    listCubit.getLastMovies(genreIndex: randomGenre,sorting: "rating");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppResponsive.h(context, 650),
            child: BlocBuilder<HomeTabCubit, HomeTabState>(
              bloc: lastMoviesCubit,
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
                          onPageChanged: (int value) {},
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
              Text(
                lastMoviesCubit.genres[randomGenre],
                style: AppStyles.reg20white,
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  if (widget.onNavigateToBrowse != null) {
                    widget.onNavigateToBrowse!(randomGenre);
                  }
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
          BlocBuilder<HomeTabCubit, HomeTabState>(
            bloc: listCubit,
            builder: (context, state) {
              if (state is HomeSuccessState) {
                return MovieListView(recommendedMovies: state.movies);
              } else if (state is HomeErrorState) {
                return Center(
                  child: Text(
                    state.error.message,
                    style: AppStyles.reg16white,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Skeletonizer(
                child: MovieListView(
                  recommendedMovies: List.generate(
                    5,
                    (_) => MovieModel.empty(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
