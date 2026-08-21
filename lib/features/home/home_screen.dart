import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/home/profile_tab/view/screens/profile_tab.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_responsive.dart';
import '../../core/widgets/custom_navbar.dart';
import 'Browse_tab/view/screens/browse_tab.dart';
import 'home_tab/view/screen/home_tab.dart';
import 'search_tab/view/screens/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          tabs[selectedIndex],

          Positioned(
            left: AppResponsive.w(context, 10),
            right: AppResponsive.w(context, 10),
            bottom: AppResponsive.h(context, 20),
            child: CustomNavBar(
              selectedIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                navigationBarItem(
                  AppIcons.Home,
                ),
                navigationBarItem(
                  AppIcons.Search,
                ),
                navigationBarItem(
                  AppIcons.Explore,
                ),
                navigationBarItem(
                 AppIcons.Profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem navigationBarItem(String icon) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: AppColors.white),
      activeIcon: Image.asset(AppIcons.Profile, color: AppColors.primary),
      label: '',
    );
  }
}
