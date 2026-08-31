import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/custom_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/view_model/browse_tab_cubit.dart';

import '../../view_model/browse_tab_state.dart';
class GenreTabBar extends StatelessWidget implements PreferredSizeWidget {
  const GenreTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseTabCubit, BrowseTabState>(
      builder: (context, state) {
        final cubit = context.read<BrowseTabCubit>();

        return TabBar(
          isScrollable: true,
          dividerColor: AppColors.transparent,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.transparent,
          labelPadding: EdgeInsets.all(
            AppResponsive.w(context, 10),
          ),
          onTap: (index) {
            cubit.getMoviesByGenre(index);
          },
          tabs: cubit.genres.map((genre) {
            final index = cubit.genres.indexOf(genre);

            return CustomTabBar(
              isSelected: cubit.selectedIndex == index,
              txt: genre,
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}