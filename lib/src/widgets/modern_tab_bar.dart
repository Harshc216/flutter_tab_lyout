import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../models/tab_item.dart';
import '../themes/tab_theme.dart';
import '../utils/constants.dart';
import 'animated_indicator.dart';
import 'modern_tab_item.dart';

/// Displays a horizontal tab bar.
class ModernTabBar extends StatelessWidget {
  /// Creates a modern tab bar.
  const ModernTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    required this.theme,
  });

  /// List of tabs.
  final List<TabItem> tabs;

  /// Tab controller.
  final ModernTabController controller;

  /// Theme.
  final TabThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final double tabWidth =
                constraints.maxWidth / tabs.length;

            return Container(
              height: 60,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: theme.borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor,
                    blurRadius: theme.elevation * 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedIndicator(
                    left: controller.selectedIndex * tabWidth,
                    width: tabWidth,
                    theme: theme,
                  ),
                  Row(
                    children: List.generate(
                      tabs.length,
                          (index) => Expanded(
                        child: ModernTabItem(
                          index: index,
                          item: tabs[index],
                          controller: controller,
                          theme: theme,
                          onTap: () => controller.select(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}