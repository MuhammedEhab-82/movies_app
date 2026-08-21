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
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(viewPadding: EdgeInsets.zero, padding: EdgeInsets.zero),
      child: SizedBox(
        height: AppResponsive.h(context, 70),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            currentIndex: selectedIndex,
            onTap: onTap,
            items: items,
          ),
        ),
      ),
    );
  }
}
