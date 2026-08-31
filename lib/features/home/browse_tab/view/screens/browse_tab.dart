import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/browse_movies_grid.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/genre_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_cubit.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';
class BrowseTab extends StatelessWidget {
  final int initialGenreIndex;
  const BrowseTab({super.key, this.initialGenreIndex = 0});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BrowseTabCubit(MovieService(DioClient()))..getMoviesByGenre(initialGenreIndex),
      child: BlocBuilder<BrowseTabCubit, BrowseTabState>(
        builder: (context, state) {
          final cubit = context.read<BrowseTabCubit>();
          return DefaultTabController(initialIndex: initialGenreIndex,
            length: cubit.genres.length,
            child: Scaffold(
              appBar: AppBar(bottom: const GenreTabBar()),
              body: _buildBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BrowseTabState state) {
    if (state is BrowseTabLoading) {
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

    if (state is BrowseTabError) {
      return Center(
        child: Text(
          state.error.message,
          style: AppStyles.reg16white,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state is BrowseTabSuccess) {
      if (state.movies.isEmpty) {
        return const Center(child: Text('No movie data found'));
      }
      return BrowseMoviesGrid(movies: state.movies);
    }

    return const SizedBox.shrink();
  }
}
