import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/features/home/search_tab/cubit/view_model/search_states.dart';
import 'package:movies_app/features/home/search_tab/cubit/view_model/search_tab_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../browse_tab/model/movie_model.dart';
import '../../../browse_tab/view/widgets/browse_movies_grid.dart';
import '../../../home_tab/view/screen/home_tab.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  SearchTabViewModel viewModel =
  SearchTabViewModel(movieService: movieService);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<SearchTabViewModel, SearchStates>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(
                  AppResponsive.w(context, 16),
                ),
                child: Column(
                  spacing: AppResponsive.h(context, 10),
                  children: [
                    CustomTextField(
                      hintText: AppStrings.search,
                      prefixIcon: AppIcons.Search,
                      controller: searchController,
                      onChanged: (value) {
                        viewModel.searchMovies(value);
                      },
                    ),

                    Expanded(
                      child: _buildBody(state),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(SearchStates state) {
    if (state is SearchInitialState) {
      return Center(
        child: Image.asset(AppImages.Empty),
      );
    }

    if (state is SearchSuccessState) {
      if (state.movies.isEmpty) {
        return Center(
          child: Text('No Movies Found.',style: AppStyles.semi20primary,),
        );
      }if (state is SearchErrorState) {
        return Center(
            child: Skeletonizer(
              child:  BrowseMoviesGrid(
                movies: [
                  MovieModel.empty(),
                  MovieModel.empty(),
                  MovieModel.empty(),
                  MovieModel.empty(),
                ],
              ),
            )

        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.6,
        ),
        itemCount: state.movies.length,
        itemBuilder: (context, index) {
          final movie = state.movies[index];

          return MovieCard(
            path: movie.mediumCoverImage ?? '',
            rating: movie.rating?.toString() ?? '',
            movieId: movie.id ?? 0,
          );
        },
      );
    }

    if (state is SearchErrorState) {
      return Center(
        child: Text(
          state.error.message ?? 'Something went wrong',
        ),
      );
    }

    return const SizedBox();
  }
}

