import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import '../../../../core/network/api_service.dart';
import 'package:movies_app/core/utils/fire_base_utils.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import '../../../home/profile_tab/cubit/profile_view_model.dart';
import '../../../home/profile_tab/cubit/profile_states.dart';
import '../../view_model/movie_details_cubit.dart';
import '../../view_model/movie_details_state.dart';
import '../widgets/cast.dart';
import '../widgets/movie_actions_row.dart';
import '../widgets/movie_details_header.dart';
import '../widgets/screenShots.dart';
import '../widgets/similar_movies_section.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
    BlocProvider(
    create: (context) =>
    MovieDetailsCubit(MovieService(DioClient()))
      ..getMovieDetails(movieId),
    ),
    BlocProvider(
    create: (context) => ProfileViewModel()
      ..loadUser(FirebaseAuth.instance.currentUser!.uid),
    ),
    ],
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
          actions: [
            BlocBuilder<ProfileViewModel, ProfileStates>(
              builder: (context, state) {
                bool isInWatchlist = false;
                if (state is ProfileUserLoadedState) {
                  isInWatchlist = state.user.watchlist.contains(movieId.toString());
                }
                return IconButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser!.uid;

                    await context.read<ProfileViewModel>().toggleMovie(
                      userId,
                      movieId,
                    );

                    // Update global UserCubit so profile tab/listeners refresh immediately
                    try {
                      final updatedUser = await FireBaseUtils.getUserFromFirestore(userId);
                      if (updatedUser != null) {
                        // Safely update UserCubit if available
                        try {
                          context.read<UserCubit>().updateUser(updatedUser);
                        } catch (_) {}
                      }
                    } catch (_) {}
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: isInWatchlist ? AppColors.primary : AppColors.white,
                    size: 30,
                  ),
                );
              },
            ),
          ],
          elevation: 0,
        ),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Text(
                  state.error.message,
                  style: AppStyles.reg16white,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is MovieDetailsSuccess) {
              final movie = state.movieDetails;
              final suggestions = state.suggestions;

              final uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid != null) {
                // record history for opened movie
                context.read<ProfileViewModel>().addToHistory(uid, movieId);
              }

              return SingleChildScrollView(
                child: Column(
                  spacing: AppResponsive.h(context, 20),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailsHeader(movie: movie),
                    MovieActionsRow(movie: movie, onWatchlistPressed: () {},),

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

                    SimilarMoviesSection(suggestions: suggestions),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppResponsive.h(context, 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child:
                          Text(AppStrings.summary,
                              style: AppStyles.bold20white),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppResponsive.w(context, 20),
                          ),
                          child: Text(movie.description,
                              style: AppStyles.reg16white),
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
                          child: Text(AppStrings.cast,
                              style: AppStyles.bold20white),
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
                          child:
                          Text(AppStrings.genres, style: AppStyles.bold20white),
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
                                    horizontal: AppResponsive.w(context, 15),
                                    vertical: AppResponsive.h(context, 10),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                    SizedBox(height: AppResponsive.h(context, 50)),
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
