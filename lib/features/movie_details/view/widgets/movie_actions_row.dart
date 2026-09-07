import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../model/movie_details_model.dart';

class MovieActionsRow extends StatelessWidget {
  final MovieDetailsModel movie;
  final VoidCallback onWatchlistPressed;

  const MovieActionsRow({
    super.key,
    required this.movie,
    required this.onWatchlistPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          text: " ${movie.likeCount} ",
          onPressed: onWatchlistPressed,
          icon: AppIcons.Favourite,
          color: AppColors.gray,
          textColor: AppColors.white,
        ),
        CustomButton(
          text: " ${movie.runtime} ",
          onPressed: () {},
          icon: AppIcons.Watch,
          color: AppColors.gray,
          textColor: AppColors.white,
        ),
        CustomButton(
          text: " ${movie.rating} ",
          onPressed: () {},
          icon: AppIcons.Star,
          color: AppColors.gray,
          textColor: AppColors.white,
        ),
      ],
    );
  }
}