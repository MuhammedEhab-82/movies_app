import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/widgets/movie_card.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class SearchTab extends StatefulWidget {
  SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<String> images = [
    AppImages.MoviePoster1,
    AppImages.MoviePoster2,
    AppImages.MoviePoster3,
    AppImages.MoviePoster4,
    AppImages.MoviePoster5,
    AppImages.MoviePoster6,
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.w(context, 16)),
          child: Column(
            spacing: AppResponsive.h(context, 10),
            children: [
              CustomTextField(
                hintText: AppStrings.search,
                prefixIcon:AppIcons.Search,
                controller: searchController,
                onChanged: (value) {
                  setState(() {

                  });
                },
              ),
              Expanded(
                child: searchController.text.isEmpty ?
                Center(
                  child: Image.asset(AppImages.Empty),
                )
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.6
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
            ],
          ),
        ),
      ),
    );
  }
}
