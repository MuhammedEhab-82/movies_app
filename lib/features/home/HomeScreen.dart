import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_navbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomNavBar();
  }
}
