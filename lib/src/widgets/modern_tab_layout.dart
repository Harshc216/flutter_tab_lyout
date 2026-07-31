import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../enums/tab_position.dart';
import '../enums/tab_style.dart';
import '../enums/tab_animation.dart';
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
    this.style = TabStyle.material,
    this.animation = TabAnimation.slide,
    this.isScrollable = false,
    this.equalWidths = true,
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

  /// Style of the tab bar.
  final TabStyle style;

  /// Transition animation style.
  final TabAnimation animation;

  /// Whether the tab bar is scrollable.
  final bool isScrollable;

  /// Whether tabs should have equal widths.
  final bool equalWidths;

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
      style: style,
      isScrollable: isScrollable,
      equalWidths: equalWidths,
    );

    final tabView = Expanded(
      child: ModernTabView(
        controller: controller,
        animation: animation,
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