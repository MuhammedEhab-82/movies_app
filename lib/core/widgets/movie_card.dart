import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/rating_widget.dart';

import '../utils/app_routes.dart';

class MovieCard extends StatelessWidget {
  final String path;
  final bool isRecommended;
  final String rating;
  final int movieId;

  const MovieCard({
    super.key,
    required this.path,
    this.isRecommended = false,
    required this.rating,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = path.startsWith('http');
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetails,
          arguments: movieId,
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image:
                (isNetworkImage ? NetworkImage(path) : AssetImage(path))
                    as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        width: isRecommended
            ? AppResponsive.w(context, 234)
            : AppResponsive.w(context, 189),
        height: isRecommended
            ? AppResponsive.h(context, 351)
            : AppResponsive.h(context, 270),
        child: RatingWidget(
          rating: rating,
          icon: Icon(Icons.star, color: AppColors.primary),
        ),
      ),
    );
  }
}
