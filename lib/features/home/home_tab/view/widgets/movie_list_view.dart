import 'package:flutter/material.dart';

import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/widgets/movie_card.dart';
import '../../../browse_tab/model/movie_model.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key, required this.recommendedMovies});
  final List<MovieModel> recommendedMovies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppResponsive.h(context, 226),
      child: ListView.separated(
        itemCount: recommendedMovies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => MovieCard(
          path: recommendedMovies[index].image,
          rating: recommendedMovies[index].rating.toString(),
          movieId: recommendedMovies[index].id,
        ),
        separatorBuilder: (context, index) =>
            SizedBox(width: AppResponsive.w(context, 16)),
      ),
    );
  }
}
