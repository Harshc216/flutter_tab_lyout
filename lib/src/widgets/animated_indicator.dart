import 'package:flutter/material.dart';

import '../enums/tab_style.dart';
import '../themes/tab_theme.dart';
import '../painters/indicator_painter.dart';

/// Indicator shown below or behind the selected tab.
class AnimatedIndicator extends StatelessWidget {
  /// Creates an indicator.
  const AnimatedIndicator({
    super.key,
    required this.theme,
    required this.style,
  });

  /// Current theme.
  final TabThemeData theme;

  /// The tab style.
  final TabStyle style;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(
        color: theme.indicatorColor,
        style: style,
        borderRadius: theme.borderRadius,
        shadowColor: theme.shadowColor,
      ),
    );
  }
}