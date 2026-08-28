import 'package:flutter/material.dart';

import '../../../../core/utils/app_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../model/movie_suggestion_model.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<MovieSuggestionModel> suggestions;

  const SimilarMoviesSection({super.key, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppResponsive.h(context, 10),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.w(context, 20),
          ),
          child: Text(AppStrings.similar, style: AppStyles.bold20white),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.w(context, 20),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemCount: suggestions.length > 4 ? 4 : suggestions.length,
          itemBuilder: (context, index) {
            return MovieCard(
              path: suggestions[index].image,
              rating: suggestions[index].rating.toString(),
              movieId: suggestions[index].id,
            );
          },
        ),
      ],
    );
  }
}
