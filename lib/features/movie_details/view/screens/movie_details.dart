import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/movie_details/view/widgets/cast.dart';
import 'package:movies_app/features/movie_details/view/widgets/movie_actions_row.dart';
import 'package:movies_app/features/movie_details/view/widgets/movie_details_header.dart';
import 'package:movies_app/features/movie_details/view/widgets/screenShots.dart';
import 'package:movies_app/features/movie_details/view/widgets/similar_movies_section.dart';
import 'package:smart_empty_state/smart_empty_state.dart';

import '../../../../core/network/api_service.dart';
import '../../view_model/movie_details_cubit.dart';
import '../../view_model/movie_details_state.dart';

class MovieDetails extends StatelessWidget {
   MovieDetails({
    super.key,
    required this.movieId,
  });

  final int movieId;

  final SmartEmptyStateTheme emptyStateTheme =
  SmartEmptyStateTheme(
    iconColor: AppColors.primary,
    titleStyle: AppStyles.transparent,
    messageStyle: AppStyles.semi20primary,
  );

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MovieDetailsCubit(
        MovieService(DioClient()),
      )..getMovieDetails(movieId),
      child: Scaffold(
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
              size: 30,
            ),
          ),
          actions: const [
            Icon(
              Icons.bookmark,
              color: AppColors.white,
              size: 30,
            ),
          ],
          elevation: 0,
        ),

        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            final cubit = context.read<MovieDetailsCubit>();

            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MovieDetailsError) {
              return _buildErrorState(
                error: state.error,
                onRetry: () {
                  cubit.getMovieDetails(movieId);
                },
              );
            }

            if (state is MovieDetailsSuccess) {
              final movie = state.movieDetails;
              final suggestions = state.suggestions;

              return SingleChildScrollView(
                child: Column(
                  spacing: AppResponsive.h(context, 20),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailsHeader(
                      movie: movie,
                    ),

                    MovieActionsRow(
                      movie: movie,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppResponsive.h(context, 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(
                            AppStrings.screenshots,
                            style: AppStyles.bold20white,
                          ),
                        ),
                        ScreenShots(
                          itemCount: 3,
                          images: [
                            movie.mediumScreenshotImage1,
                            movie.mediumScreenshotImage2,
                            movie.mediumScreenshotImage3,
                          ],
                        ),
                      ],
                    ),

                    SimilarMoviesSection(
                      suggestions: suggestions,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppResponsive.h(context, 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(
                            AppStrings.summary,
                            style: AppStyles.bold20white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(
                            movie.description,
                            style: AppStyles.reg16white,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppResponsive.h(context, 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(
                            AppStrings.cast,
                            style: AppStyles.bold20white,
                          ),
                        ),
                        Column(
                          spacing: AppResponsive.h(context, 10),
                          children: movie.cast.map((cast) {
                            return CastWidget(
                              image: cast.image,
                              castName: cast.name,
                              characterName: cast.characterName,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppResponsive.h(context, 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(
                            AppStrings.genres,
                            style: AppStyles.bold20white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 15),
                          ),
                          child: Wrap(
                            spacing: AppResponsive.w(context, 10),
                            runSpacing: AppResponsive.h(context, 10),
                            children: movie.genres.map((genre) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.gray,
                                  foregroundColor: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    AppResponsive.w(context, 15),
                                    vertical:
                                    AppResponsive.h(context, 10),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(genre),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: AppResponsive.h(context, 50),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}