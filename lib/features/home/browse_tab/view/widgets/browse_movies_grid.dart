import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

class BrowseMoviesGrid extends StatelessWidget {
  final List<MovieModel> movies;

  const BrowseMoviesGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppResponsive.w(context, 16)),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            path: movies[index].image,
            rating: movies[index].rating.toString(),
            movieId: movies[index].id,
          );
        },
      ),
    );
  }
}
