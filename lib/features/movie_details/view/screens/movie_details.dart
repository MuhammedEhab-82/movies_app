import 'package:flutter/material.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/recommend_bg.dart';
import 'package:movies_app/features/movie_details/model/movie_suggestion_model.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../model/movie_details_model.dart';
import '../widgets/cast.dart';
import '../widgets/screenShots.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key, required this.movieId});

  final int movieId;

  final MovieService movieService = MovieService(DioClient());

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

      body: FutureBuilder<MovieDetailsModel>(
        future: movieService.getMovieDetails(movieId),

        builder: (context, snapshot) {
          // 1. Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: AppStyles.reg16white,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text(AppStrings.noMoviesFound));
          }

          final movie = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              spacing: AppResponsive.h(context, 20),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: AppResponsive.h(context, 700),

                      child: RecommendBg(
                        recommendedMovie: movie.backgroundImage,
                      ),
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
                          movie.title,
                          style: AppStyles.bold24white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Year
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

                    // Watch Button
                    Positioned(
                      bottom: AppResponsive.h(context, 0),
                      left: AppResponsive.w(context, 10),
                      right: AppResponsive.w(context, 10),

                      child: CustomButton(
                        text: AppStrings.watch,

                        onPressed: () {
                          // TODO:
                          // navigate to watch movie screen
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
                      text: " ${movie.likeCount} ",

                      onPressed: () {},

                      icon: AppIcons.Favourite,

                      color: AppColors.gray,
                      textColor: AppColors.white,
                    ),

                    CustomButton(
                      text: " ${movie.runtime} ",

                      onPressed: () {},

                      icon: AppIcons.Watch,

                      color: AppColors.gray,
                      textColor: AppColors.white,
                    ),

                    CustomButton(
                      text: " ${movie.rating} ",

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

                // =========================
                // Similar Movies
                // =========================
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 20),
                  ),

                  child: Text(AppStrings.similar, style: AppStyles.bold20white),
                ),
                FutureBuilder<List<MovieSuggestionModel>>(
                  future: movieService.getMovieSuggestions(movieId),
                  builder: (context, suggestionSnapshot) {
                    // 1. Loading state for suggestions
                    if (suggestionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // 2. Error or empty state
                    if (suggestionSnapshot.hasError ||
                        !suggestionSnapshot.hasData ||
                        suggestionSnapshot.data!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppResponsive.w(context, 20),
                        ),
                        child: Text(
                          AppStrings.noSimilarMoviesFound,
                          style: AppStyles.reg16white,
                        ),
                      );
                    }

                    final suggestions = suggestionSnapshot.data!;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppResponsive.w(context, 20),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: suggestions.length > 4
                          ? 4
                          : suggestions.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          path: suggestions[index].image,
                          rating: suggestions[index].rating.toString(),
                          movieId: suggestions[index].id,
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: AppResponsive.h(context, 30)),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 20),
                  ),

                  child: Text(AppStrings.summary, style: AppStyles.bold20white),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 20),
                  ),

                  child: Text(movie.description, style: AppStyles.reg16white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 20),
                  ),

                  child: Text(AppStrings.cast, style: AppStyles.bold20white),
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

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 20),
                  ),

                  child: Text(AppStrings.genres, style: AppStyles.bold20white),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 15),
                  ),

                  child: Wrap(
                    spacing: AppResponsive.w(context, 10),

                    runSpacing: AppResponsive.h(context, 10),

                    children: movie.genres.map((genre) {
                      return CustomButton(
                        text: genre,

                        onPressed: () {
                          // TODO:
                          // go to genre movies
                        },

                        color: AppColors.gray,
                        textColor: AppColors.white,
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: AppResponsive.h(context, 50)),
              ],
            ),
          );
        },
      ),
    );
  }
}
