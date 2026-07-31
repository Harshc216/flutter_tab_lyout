import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../enums/tab_position.dart';
import '../models/tab_item.dart';
import '../themes/tab_theme.dart';
import 'modern_tab_bar.dart';
import 'modern_tab_view.dart';

/// Main widget that combines the tab bar and tab view.
class ModernTabLayout extends StatelessWidget {
  /// Creates a modern tab layout.
  const ModernTabLayout({
    super.key,
    required this.tabs,
    required this.children,
    required this.controller,
    this.theme = const TabThemeData(),
    this.position = TabPosition.top,
  });

  /// List of tabs.
  final List<TabItem> tabs;

  /// Pages.
  final List<Widget> children;

  /// Controller.
  final ModernTabController controller;

  /// Theme.
  final TabThemeData theme;

  /// Position of the tab bar.
  final TabPosition position;

  @override
  Widget build(BuildContext context) {
    assert(
    tabs.length == children.length,
    'Tabs and children count must be equal.',
    );

    final tabBar = ModernTabBar(
      tabs: tabs,
      controller: controller,
      theme: theme,
    );

    final tabView = Expanded(
      child: ModernTabView(
        controller: controller,
        children: children,
      ),
    );

    switch (position) {
      case TabPosition.top:
        return Column(
          children: [
            tabBar,
            tabView,
          ],
        );

      case TabPosition.bottom:
        return Column(
          children: [
            tabView,
            tabBar,
          ],
        );

      case TabPosition.left:
        return Row(
          children: [
            SizedBox(
              width: 120,
              child: tabBar,
            ),
            tabView,
          ],
        );

      case TabPosition.right:
        return Row(
          children: [
            tabView,
            SizedBox(
              width: 120,
              child: tabBar,
            ),
          ],
        );
    }
  }
}