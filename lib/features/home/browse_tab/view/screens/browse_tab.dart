import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/browse_movies_grid.dart';
import 'package:movies_app/features/home/browse_tab/view/widgets/genre_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_cubit.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_state.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      BrowseTabCubit(MovieService(DioClient()))
        ..getMoviesByGenre(0),
      child: BlocBuilder<BrowseTabCubit, BrowseTabState>(
        builder: (context, state) {
          final cubit = context.read<BrowseTabCubit>();
          return DefaultTabController(
            length: cubit.genres.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: const GenreTabBar(),
              ),
              body: _buildBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BrowseTabState state) {
    if (state is BrowseTabLoading) {
      return const Center(child: CircularProgressIndicator());
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
        return const Center(
          child: Text('No movie data found'),
        );
      }
      return BrowseMoviesGrid(movies: state.movies);
    }

    return const SizedBox.shrink();
  }
}
