import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/custom_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_cubit.dart';

class GenreTabBar extends StatelessWidget implements PreferredSizeWidget {
  const GenreTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrowseTabCubit>();
    return TabBar(
      isScrollable: true,
      dividerColor: AppColors.transparent,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.transparent,
      labelPadding: EdgeInsets.all(AppResponsive.w(context, 10)),
      onTap: (index) {
        cubit.getMoviesByGenre(index);
      },
      tabs: cubit.genres.map((genre) {
        return CustomTabBar(
          isSelected: cubit.selectedIndex == cubit.genres.indexOf(genre),
          txt: genre,
        );
      }).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
