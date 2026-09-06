import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_responsive.dart';

class ScreenShots extends StatelessWidget {
  const ScreenShots({
    super.key,
    required this.itemCount,
    required this.images,
    this.borderRadius = 16,
  });

  final int itemCount;
  final List<String> images;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppResponsive.w(context, 10),
        right: AppResponsive.w(context, 10),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsetsGeometry.all(0),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(
              images[index],
              height: AppResponsive.h(context, 167),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: AppResponsive.h(context, 10));
        },
        itemCount: itemCount,
      ),
    );
  }
}
