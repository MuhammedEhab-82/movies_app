import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/movie_card.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_responsive.dart';

class TabDetails extends StatelessWidget {
  final List<String>? movie;

  const TabDetails({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(context, 16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: AppResponsive.h(context, 24)),
        itemCount: movie!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppResponsive.w(context, 10),
          mainAxisSpacing: AppResponsive.h(context, 10),
          mainAxisExtent: AppResponsive.h(context, 180),
        ),
        itemBuilder: (context, index) {
          return MovieCard(path: movie![index], rating: '5.0', movieId: 78168,
          );
        },
      ),
    );
  }
}
