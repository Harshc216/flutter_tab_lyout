import 'package:flutter/material.dart';

/// Paints the indicator below the selected tab.
class IndicatorPainter extends CustomPainter {
  /// Creates an indicator painter.
  IndicatorPainter({
    required this.color,
    required this.radius,
  });

  /// Indicator color.
  final Color color;

  /// Corner radius.
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final RRect indicator = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
      Radius.circular(radius),
    );

    canvas.drawRRect(indicator, paint);
  }

  @override
  bool shouldRepaint(covariant IndicatorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius;
  }
}