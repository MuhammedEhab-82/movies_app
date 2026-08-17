import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/rating_widget.dart';

class MovieCard extends StatelessWidget {
  final String path;
  final bool isRecommended;
  final String rating;
  final Widget icon;

  const MovieCard({
    super.key,
    required this.path,
    this.isRecommended = false,
    required this.rating,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isRecommended
          ? AppResponsive.w(context, 234)
          : AppResponsive.w(context, 189),
      height: isRecommended
          ? AppResponsive.h(context, 351)
          : AppResponsive.h(context, 270),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                  path, height: double.infinity, fit: BoxFit.cover)),
          RatingWidget(rating: rating, icon: icon),
        ],
      ),
    );
  }
}
