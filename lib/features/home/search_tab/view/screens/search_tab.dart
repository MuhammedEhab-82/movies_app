import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/features/home/search_tab/cubit/view_model/search_states.dart';
import 'package:movies_app/features/home/search_tab/cubit/view_model/search_tab_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_empty_state/smart_empty_state.dart';

import '../../../../../core/network/api_service.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/empty_state_utils.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../browse_tab/model/movie_model.dart';
import '../../../browse_tab/view/widgets/browse_movies_grid.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

final MovieService movieService = MovieService(DioClient());

class _SearchTabState extends State<SearchTab> {
  final SearchTabViewModel viewModel =
  SearchTabViewModel(movieService: movieService);

  final TextEditingController searchController = TextEditingController();




  Widget _buildBody(SearchStates state) {
    if (state is SearchInitialState) {
      return Center(
        child: Image.asset(AppImages.Empty),
      );
    }

    if (state is SearchLoadingState) {
      return Center(
        child: Skeletonizer(
          child: BrowseMoviesGrid(
            movies: [
              MovieModel.empty(),
              MovieModel.empty(),
              MovieModel.empty(),
              MovieModel.empty(),
            ],
          ),
        ),
      );
    }

    if (state is SearchSuccessState) {
      if (state.movies.isEmpty) {
        return SmartEmptyState(
          type: EmptyStateType.searchNotFound,
          theme: EmptyStateUtils.emptyStateTheme,
          options: EmptyStateOptions(
            title: AppStrings.noMoviesFound,
            message: AppStrings.noMoviesFoundMessage,
            actionText: AppStrings.tryAgain,
          ),
          onAction: () {
            if (searchController.text.trim().isNotEmpty) {
              viewModel.searchMovies(
                searchController.text.trim(),
              );
            }
          },
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
            path: movie.image,
            rating: movie.rating.toString(),
            movieId: movie.id,
          );
        },
      );
    }

    // Error
    if (state is SearchErrorState) {
      return SmartEmptyState(
        type: EmptyStateUtils.getEmptyStateType(
          state.error.message,
        ),
        theme: EmptyStateUtils.emptyStateTheme,
        options: EmptyStateOptions(
          title: AppStrings.error,
          message: state.error.message ,
          actionText: AppStrings.tryAgain,
        ),
        onAction: () {
          if (searchController.text.trim().isNotEmpty) {
            viewModel.searchMovies(
              searchController.text.trim(),
            );
          }
        },
      );
    }

    return const SizedBox.shrink();
  }

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

  @override
  void dispose() {
    searchController.dispose();
    viewModel.close();
    super.dispose();
  }
}