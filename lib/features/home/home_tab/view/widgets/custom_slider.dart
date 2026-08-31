import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/widgets/movie_card.dart';
import '../../view_model/home_tab_state.dart';

class CustomSlider extends StatefulWidget {
   CustomSlider({super.key, required this.state, required this.pageIndex});
  final HomeSuccessState state;
   int pageIndex;
  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          widget.pageIndex = index;
          setState(() {});
        },
        initialPage:widget.pageIndex,
        disableCenter: true,
        enlargeCenterPage: true,
        viewportFraction:
            AppResponsive.w(context, 234) / AppResponsive.designWidth,
        height: AppResponsive.h(context, 400),
      ),
      items: widget.state.movies.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return MovieCard(
              path: i.image,
              rating: i.rating.toString(),
              isRecommended: true,
              movieId: 78168,
            );
          },
        );
      }).toList(),
    );
  }
}
