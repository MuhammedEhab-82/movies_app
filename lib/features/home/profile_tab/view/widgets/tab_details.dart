import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/home/profile_tab/cubit/profile_tab_movies_cubit.dart';
import 'package:movies_app/features/home/profile_tab/cubit/profile_tab_movies_state.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

class TabDetails extends StatelessWidget {
  final List<String>? movie;

  const TabDetails({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    final items = movie ?? [];

    return BlocProvider(
      create: (context) =>
          ProfileTabMoviesCubit(MovieService(DioClient()))..loadMovies(items),
      child: BlocBuilder<ProfileTabMoviesCubit, ProfileTabMoviesState>(
        builder: (context, state) {
          if (state is ProfileTabMoviesLoading) {
            // skeleton grid while loading
            return Container(
              color: AppColors.background,
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 16),
              ),
              child: Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: AppResponsive.h(context, 24),
                  ),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppResponsive.w(context, 10),
                    mainAxisSpacing: AppResponsive.h(context, 10),
                    mainAxisExtent: AppResponsive.h(context, 180),
                  ),
                  itemBuilder: (context, index) {
                    final placeholders = List.generate(9, (_) => MovieModel.empty());
                    final p = placeholders[index % placeholders.length];
                    return MovieCard(
                      path: p.image,
                      rating: p.rating.toString(),
                      movieId: p.id,
                      title: p.image == AppIcons.imagePlaceholder? p.title : null,
                    );
                  },

                ),
              ),
            );
          }

          if (state is ProfileTabMoviesLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return Container(
                color: AppColors.background,
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.w(context, 16),
                ),
                            child: Image.asset(AppImages.empty),
              );
            }

            return Container(
              color: AppColors.background,
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 16),
              ),
              child: Column(
                children:[ GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: AppResponsive.h(context, 24),
                  ),
                  itemCount: movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppResponsive.w(context, 10),
                    mainAxisSpacing: AppResponsive.h(context, 10),
                    mainAxisExtent: AppResponsive.h(context, 180),
                  ),
                  itemBuilder: (context, index) {
                    final m = movies[index];
                    return MovieCard(
                      path: m.image,
                      rating: m.rating.toString(),
                      movieId: m.id,
                      title: m.image == AppIcons.imagePlaceholder ? m.title : null,
                    );
                  },
                ),
                SizedBox(height: AppResponsive.h(context, 350))
                ]
              ),
            );
          }

          if (state is ProfileTabMoviesError) {
            return Container(
              color: AppColors.background,
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 16),
              ),
              child: Center(child: Text('Error: ${state.message}')),
            );
          }

          return Container(
            color: AppColors.background,
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.w(context, 16),
            ),
                      child: Image.asset(AppImages.empty),
          );
        },
      ),
    );
  }
}
