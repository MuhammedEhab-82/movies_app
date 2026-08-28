import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_tab_bar.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/movie_card.dart';

class BrowseTab extends StatefulWidget {
  BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {

  final MovieService movieService = MovieService(
    DioClient(),
  );

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
        body: FutureBuilder<List<MovieModel>>(
            future: movieService.getAllMovies(genre: tabsList[selectedIndex]),
            builder: (context, snapshot) {
              // 1. Loading
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // 2. Error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: AppStyles.reg16white,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // 3. No data
              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'No movie data found',
                  ),
                );
              }

              // 4. Get the movie model
              final movies = snapshot.data!;

              return Padding(
                padding: EdgeInsets.all(AppResponsive.w(context, 16)),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      path: movies[index].image,
                      rating: movies[index].rating.toString(),
                      movieId: movies[index].id,

                    );
                  },
                ),
              );
            }
        ),
      ),
    );
  }
}
