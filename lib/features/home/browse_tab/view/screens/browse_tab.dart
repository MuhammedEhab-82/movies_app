import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/errors/api_error.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/empty_state_utils.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/browse_movies_grid.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/genre_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_cubit.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_empty_state/smart_empty_state.dart';

class BrowseTab extends StatelessWidget {
  final int initialGenreIndex;

  const BrowseTab({
    super.key,
    this.initialGenreIndex = 0,
  });

  Widget _buildErrorState({
    required ApiError error,
    required VoidCallback onRetry,
  }) {
    return SmartEmptyState(
      type: EmptyStateUtils.getEmptyStateType(error.message),
      theme: EmptyStateUtils.emptyStateTheme,
      options: EmptyStateOptions(
        message: error.message,
        actionText:AppStrings.tryAgain,
      ),
      onAction: onRetry,
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseTabCubit(
        MovieService(DioClient()),
      )..getMoviesByGenre(initialGenreIndex),
      child: BlocBuilder<BrowseTabCubit, BrowseTabState>(
        builder: (context, state) {
          final cubit = context.read<BrowseTabCubit>();

          return DefaultTabController(
            initialIndex: initialGenreIndex,
            length: cubit.genres.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: const GenreTabBar(),
              ),
              body: _buildBody(
                context,
                state,
                cubit,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      BrowseTabState state,
      BrowseTabCubit cubit,
      ) {
    if (state is BrowseTabLoading) {
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

    if (state is BrowseTabError) {
      return _buildErrorState(
        error: state.error,
        onRetry: () {
          cubit.getMoviesByGenre(initialGenreIndex);
        },
      );
    }

    if (state is BrowseTabSuccess) {
      if (state.movies.isEmpty) {
        return EmptyStateUtils.buildNoDataState(
          onRetry: () {
            cubit.getMoviesByGenre(initialGenreIndex);
          },
        );
      }

      return BrowseMoviesGrid(
        movies: state.movies,
      );
    }

    return const SizedBox.shrink();
  }
}