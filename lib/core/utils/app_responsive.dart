import 'package:flutter/widgets.dart';

class AppResponsive {

  static const double designWidth = 430;
  static const double designHeight = 932;

  static double w(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    return size * (width / designWidth);
  }

  static double h(BuildContext context, double size) {
    final height = MediaQuery.of(context).size.height;
    return size * (height / designHeight);
  }

}