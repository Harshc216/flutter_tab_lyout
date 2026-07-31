import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../models/tab_item.dart';
import '../themes/tab_theme.dart';
import '../utils/constants.dart';

/// A single tab widget used inside the ModernTabBar.
class ModernTabItem extends StatelessWidget {
  /// Creates a modern tab item.
  const ModernTabItem({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.theme,
    this.onTap,
  });

  /// Tab index.
  final int index;

  /// Tab model.
  final TabItem item;

  /// Tab controller.
  final ModernTabController controller;

  /// Theme.
  final TabThemeData theme;

  /// Called when the tab is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = controller.isSelected(index);

    return InkWell(
      borderRadius: theme.borderRadius,
      onTap: item.enabled ? onTap : null,
      child: AnimatedContainer(
        duration: TabConstants.animationDuration,
        height: TabConstants.tabHeight,
        padding: TabConstants.padding,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.selectedColor
              : theme.backgroundColor,
          borderRadius: theme.borderRadius,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: theme.elevation * 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(
                item.icon,
                size: TabConstants.iconSize,
                color: isSelected
                    ? theme.selectedTextStyle.color
                    : theme.unselectedTextStyle.color,
              ),
              const SizedBox(
                width: TabConstants.iconSpacing,
              ),
            ],

            Text(
              item.title,
              style: isSelected
                  ? theme.selectedTextStyle
                  : theme.unselectedTextStyle,
            ),

            if (item.badge != null) ...[
              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: theme.badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}