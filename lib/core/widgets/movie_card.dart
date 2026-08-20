import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/rating_widget.dart';

class MovieCard extends StatelessWidget {
  final String path;
  final bool isRecommended;
  final String rating;

  const MovieCard({
    super.key,
    required this.path,
    this.isRecommended = false,
    required this.rating,
    required Icon icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
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
    );
  }
}
