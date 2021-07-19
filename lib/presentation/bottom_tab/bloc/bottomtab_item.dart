import 'package:flutter/widgets.dart';

class BottomTabItem {
  final Widget page;
  final String title;
  final Widget icon;
  final Widget activeIcon;

  BottomTabItem({
    @required this.page,
    @required this.title,
    @required this.icon,
    @required this.activeIcon,
  });
}
