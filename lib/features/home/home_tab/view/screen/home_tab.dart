import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_empty_state/smart_empty_state.dart';

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
import 'package:movies_app/features/home/home_tab/view_model/home_tab_cubit.dart';
import 'package:movies_app/features/home/home_tab/view_model/home_tab_state.dart';

import '../../../../../core/errors/api_error.dart';
import '../../../browse_tab/model/movie_model.dart';

class HomeTab extends StatefulWidget {
  final void Function(int genreIndex)? onNavigateToBrowse;

  const HomeTab({
    super.key,
    this.onNavigateToBrowse,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final lastMoviesCubit = HomeTabCubit(MovieService(DioClient()));
  final listCubit = HomeTabCubit(MovieService(DioClient()));

  late int randomGenre;

  // نفس الـ style لكل الـ Empty States
  final SmartEmptyStateTheme emptyStateTheme = SmartEmptyStateTheme(
    iconColor: AppColors.primary,
    titleStyle: AppStyles.transparent,
    messageStyle: AppStyles.semi20primary,
  );

  @override
  void initState() {
    super.initState();

    final random = Random();
    randomGenre = random.nextInt(lastMoviesCubit.genres.length);

    lastMoviesCubit.getLastMovies();

    listCubit.getLastMovies(
      genreIndex: randomGenre,
      sorting: "rating",
    );
  }

  EmptyStateType _getEmptyStateType(String message) {
    final errorMessage = message.toLowerCase();

    if (errorMessage.contains('internet') ||
        errorMessage.contains('network') ||
        errorMessage.contains('connection')) {
      return EmptyStateType.noInternet;
    }

    if (errorMessage.contains('unauthorized')) {
      return EmptyStateType.permissionDenied;
    }

    return EmptyStateType.error;
  }

  Widget _buildErrorState({
    required ApiError error,
    required VoidCallback onRetry,
  }) {
    return SmartEmptyState(
      type: _getEmptyStateType(error.message),
      theme: emptyStateTheme,
      options: EmptyStateOptions(
        message: error.message,
        actionText: 'Try Again',
      ),
      onAction: onRetry,
    );
  }

  Widget _buildNoDataState({
    required String message,
    required VoidCallback onRetry,
  }) {
    return SmartEmptyState(
      type: EmptyStateType.noData,
      theme: emptyStateTheme,
      options: EmptyStateOptions(
        title: 'No Movies',
        message: message,
        actionText: 'Try Again',
      ),
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabCubit, HomeTabState>(
      bloc: lastMoviesCubit,
      builder: (context, state) {
        if (state is HomeErrorState) {
          return _buildErrorState(
            error: state.error,
            onRetry: () {
              lastMoviesCubit.getLastMovies();
            },
          );
        }

        if (state is HomeSuccessState && state.movies.isEmpty) {
          return _buildNoDataState(
            message: 'No movies available right now.',
            onRetry: () {
              lastMoviesCubit.getLastMovies();
            },
          );
        }

        if (state is HomeLoadingState) {
          return _buildLoading();
        }

        if (state is HomeSuccessState) {
          return _buildHomeContent(state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHomeContent(HomeSuccessState latestMoviesState) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppResponsive.h(context, 650),
              child: LatestMovies(
                state: latestMoviesState,
              ),
            ),

            Row(
              children: [
                Text(
                  lastMoviesCubit.genres[randomGenre],
                  style: AppStyles.reg20white,
                ),

                const Spacer(),

                TextButton(
                  onPressed: () {
                    widget.onNavigateToBrowse?.call(randomGenre);
                  },
                  child: Row(
                    children: [
                      Text(
                        AppStrings.seeMore,
                        style: AppStyles.reg16primary,
                      ),
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
                  if (state.movies.isEmpty) {
                    return _buildNoDataState(
                      message:
                      'No movies found in ${listCubit.genres[randomGenre]}.',
                      onRetry: () {
                        listCubit.getLastMovies(
                          genreIndex: randomGenre,
                          sorting: "rating",
                        );
                      },
                    );
                  }

                  return MovieListView(
                    recommendedMovies: state.movies,
                  );
                }

                if (state is HomeErrorState) {
                  return _buildErrorState(
                    error: state.error,
                    onRetry: () {
                      listCubit.getLastMovies(
                        genreIndex: randomGenre,
                        sorting: "rating",
                      );
                    },
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
      ),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppResponsive.h(context, 650),
            child: Column(
              children: [
                Image.asset(AppImages.AvailableNow),

                Skeletonizer(
                  child: CustomSlider(
                    state: HomeSuccessState(
                      movies: List.generate(
                        5,
                            (_) => MovieModel.empty(),
                      ),
                    ),
                    pageIndex: 0,
                    onPageChanged: (int value) {},
                  ),
                ),

                Image.asset(AppImages.WatchNow),
              ],
            ),
          ),

          Row(
            children: [
              Text(
                lastMoviesCubit.genres[randomGenre],
                style: AppStyles.reg20white,
              ),

              const Spacer(),

              TextButton(
                onPressed: () {
                  widget.onNavigateToBrowse?.call(randomGenre);
                },
                child: Row(
                  children: [
                    Text(
                      AppStrings.seeMore,
                      style: AppStyles.reg16primary,
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Skeletonizer(
            child: MovieListView(
              recommendedMovies: List.generate(
                5,
                    (_) => MovieModel.empty(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}