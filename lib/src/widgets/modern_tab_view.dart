import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';

/// Displays the page for the selected tab.
class ModernTabView extends StatelessWidget {
  /// Creates a modern tab view.
  const ModernTabView({
    super.key,
    required this.controller,
    required this.children,
  });

  /// Tab controller.
  final ModernTabController controller;

  /// Pages.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            key: ValueKey(controller.selectedIndex),
            width: double.infinity,
            child: children[controller.selectedIndex],
          ),
        );
      },
    );
  }
}