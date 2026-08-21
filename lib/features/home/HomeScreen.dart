import 'package:flutter/material.dart';

import '../../core/utils/app_responsive.dart';
import '../../core/widgets/custom_navbar.dart';
import 'Browse_tab/view/screens/BrowseTab.dart';
import 'home_tab/view/screens/homeTab.dart';
import 'profile_tab/view/screens/ProfileTab.dart';
import 'search_tab/view/screens/SearchTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

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
                BottomNavigationBarItem(
            icon: Icon(Icons.home),
                  label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ), BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/icons/Explore.png'),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}