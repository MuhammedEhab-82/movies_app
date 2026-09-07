import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/rating_widget.dart';

import '../utils/app_routes.dart';
import '../../features/home/profile_tab/cubit/profile_view_model.dart';

class MovieCard extends StatelessWidget {
  final String path;
  final bool isRecommended;
  final String rating;
  final int movieId;
  final String? title;

  const MovieCard({
    super.key,
    required this.path,
    this.isRecommended = false,
    required this.rating,
    required this.movieId,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOfflineCard = path == AppIcons.imagePlaceholder;
    final bool isNetworkImage = path.startsWith('http');
    final imageWidget = isOfflineCard
        ? Image.asset(
            AppIcons.imagePlaceholder,
            fit: BoxFit.contain,
            width: AppResponsive.w(context, 70),
            height: AppResponsive.h(context, 70),
          )
        : Image(
            image: isNetworkImage ? NetworkImage(path) : AssetImage(path),
            fit: BoxFit.cover,
          );

    return InkWell(
      onTap: isOfflineCard
          ? null
          : () {
              if (movieId > -1) {
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid != null) {
                  try {
                    context.read<ProfileViewModel>().addToHistory(uid, movieId);
                  } catch (e) {
                    // ignore history logging failures to keep the UI responsive.
                  }
                }

                Navigator.pushNamed(
                  context,
                  AppRoutes.movieDetails,
                  arguments: movieId,
                );
              }
            },
      child: Container(
        width: isRecommended
            ? AppResponsive.w(context, 234)
            : AppResponsive.w(context, 189),
        height: isRecommended
            ? AppResponsive.h(context, 351)
            : AppResponsive.h(context, 270),
        padding: EdgeInsets.all(AppResponsive.w(context, 8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
          image: isOfflineCard
              ? null
              : DecorationImage(
                  image:
                      (isNetworkImage ? NetworkImage(path) : AssetImage(path))
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
        ),
        child: isOfflineCard
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageWidget,
                  SizedBox(height: AppResponsive.h(context, 8)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.w(context, 6),
                    ),
                    child: Text(
                      title ?? 'Movie',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyles.reg14white,
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.topLeft,
                child: RatingWidget(
                  rating: rating,
                  icon: Icon(Icons.star, color: AppColors.primary),
                ),
              ),
      ),
    );
  }
}
