import 'package:flutter/material.dart';

import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/widgets/movie_card.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key, required this.recommendedMovies});
  final List<String> recommendedMovies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppResponsive.h(context, 226),
      child: ListView.separated(
        itemCount: recommendedMovies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            MovieCard(path: recommendedMovies[index], rating: '7.7',
            ),
        separatorBuilder: (context, index) =>
            SizedBox(width: AppResponsive.w(context, 16)),
      ),
    );
  }
}
