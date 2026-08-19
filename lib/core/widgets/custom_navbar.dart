import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/home/Browse_tab/view/screens/BrowseTab.dart';
import '../../features/home/home_tab/view/screen/home_tab.dart';
import '../../features/home/profile_tab/view/screens/profile_tab.dart';
import '../../features/home/search_tab/view/screens/SearchTab.dart';
import '../utils/app_assets.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          buildBottomNavigationBar(
            icon: Icon(Icons.home),
            label: 'home',
            index: 0,
          ),
          buildBottomNavigationBar(
            icon: Icon(Icons.search),
            label: 'search',
            index: 1,
          ),
          buildBottomNavigationBar(
            icon: ImageIcon(AssetImage(AppIcons.Explore)),
            label: 'browse',
            index: 2,
          ),
          buildBottomNavigationBar(
            icon: Icon(Icons.person),
            label: 'profile',
            index: 3,
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );

  }

  BottomNavigationBarItem buildBottomNavigationBar({
    required Widget icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
