import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  final String icon;

  const NavBarIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      color: IconTheme.of(context).color,
    );
  }
}