import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class ProfileAvatarSlider extends StatelessWidget {
  const ProfileAvatarSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        viewportFraction: 0.5,
        enlargeFactor: 0.4,
      ),
      items: [1,2,3,4,5,6,7,8,9].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(0),
                child: Image.asset("assets/images/ProfileAvatars/2x/Profile0$i.png")
            );
          },
        );
      }).toList());
  }
}
