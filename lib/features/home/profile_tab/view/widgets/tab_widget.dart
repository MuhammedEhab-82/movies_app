import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class TabWidget extends StatelessWidget {
  final String icon;
  final String name;

  const TabWidget({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset(icon),
          Text(name, style: AppStyles.reg20white),
        ],
      ),
    );
  }
}
