import 'package:flutter/material.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/custom_slider.dart';
import 'package:movies_app/features/home/home_tab/view/widgets/recommend_bg.dart';

import '../../../../../core/utils/app_assets.dart';

import '../../view_model/home_tab_state.dart';

class LatestMovies extends StatefulWidget {
  final HomeSuccessState state;
  const LatestMovies({super.key, required this.state,});

  @override
  State<LatestMovies> createState() => _LatestMoviesState();
}

class _LatestMoviesState extends State<LatestMovies> {
  late int pageIndex;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageIndex=0;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RecommendBg(
          recommendedMovie: widget.state.movies[pageIndex].image,
        ),
        Column(
          children: [
            Image.asset(AppImages.AvailableNow),
            CustomSlider(state: widget.state, pageIndex: pageIndex),
            Image.asset(AppImages.WatchNow),
          ],
        ),
      ],
    );
  }
}
