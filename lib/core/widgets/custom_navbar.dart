import 'package:flutter/material.dart';

import '../utils/app_responsive.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  final List<BottomNavigationBarItem> items;
  final Function(int) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(context, 10),
          vertical: AppResponsive.h(context, 30)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onTap,
          items: items,

        ),
      ),
    );
  }
}
