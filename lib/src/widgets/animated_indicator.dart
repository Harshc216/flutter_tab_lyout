import 'package:flutter/material.dart';

import '../themes/tab_theme.dart';
import '../utils/constants.dart';

/// Animated indicator shown below or behind the selected tab.
class AnimatedIndicator extends StatelessWidget {
  /// Creates an animated indicator.
  const AnimatedIndicator({
    super.key,
    required this.left,
    required this.width,
    required this.theme,
  });

  /// Left position of the indicator.
  final double left;

  /// Width of the indicator.
  final double width;

  /// Current theme.
  final TabThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: TabConstants.animationDuration,
      curve: Curves.easeInOut,
      left: left,
      bottom: 0,
      child: AnimatedContainer(
        duration: TabConstants.animationDuration,
        width: width,
        height: TabConstants.indicatorHeight,
        decoration: BoxDecoration(
          color: theme.indicatorColor,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}