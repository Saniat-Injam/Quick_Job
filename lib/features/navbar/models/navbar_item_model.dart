import 'package:flutter/widgets.dart';

class NavbarItem {
  final String iconPath;
  final String label;
  final Widget page;
  final VoidCallback? onTap; // optional custom navigation

  NavbarItem({
    required this.iconPath,
    required this.label,
    required this.page,
    this.onTap,
  });
}
