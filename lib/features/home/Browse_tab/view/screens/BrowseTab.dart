import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/Custom_Tab_Bar.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/movie_card.dart';

class BrowseTab extends StatefulWidget {
  BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String> images = [
    AppImages.MoviePoster1,
    AppImages.MoviePoster2,
    AppImages.MoviePoster3,
    AppImages.MoviePoster4,
    AppImages.MoviePoster5,
    AppImages.MoviePoster6,
  ];

  int selectedIndex = 0;

  List<String> tabsList = ["Action", "Drama", "Comedy", "Horror"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsList.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            dividerColor: AppColors.transparent,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.transparent,
            labelPadding: EdgeInsetsGeometry.all(AppResponsive.w(context, 10)),
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs: tabsList.map((tabs) {
              return CustomTabBar(
                isSelected: selectedIndex == tabsList.indexOf(tabs),
                txt: tabs,
              );
            }).toList(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppResponsive.w(context, 16)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.6,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return MovieCard(
                path: images[index],
                rating: '8.5',
              );
            },
          ),
        ),
      ),
    );
  }
}
