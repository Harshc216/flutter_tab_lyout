import 'package:flutter/material.dart';
import '../enums/tab_style.dart';

/// Paints the indicator depending on the selected TabStyle.
class IndicatorPainter extends CustomPainter {
  /// Creates an indicator painter.
  IndicatorPainter({
    required this.color,
    required this.style,
    required this.borderRadius,
    required this.shadowColor,
  });

  /// Primary color of the indicator.
  final Color color;

  /// Visual style of the tab.
  final TabStyle style;

  /// Border radius of the indicator.
  final BorderRadius borderRadius;

  /// Shadow color used for the floating style.
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    switch (style) {
      case TabStyle.material:
        // A bold underline at the bottom of the tab cell
        const double height = 4.0;
        final Rect rect = Rect.fromLTWH(0, size.height - height, size.width, height);
        paint.color = color;
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(2)),
          paint,
        );
        break;

      case TabStyle.underline:
        // A thinner underline at the bottom of the tab cell
        const double height = 2.0;
        final Rect rect = Rect.fromLTWH(0, size.height - height, size.width, height);
        paint.color = color;
        canvas.drawRect(rect, paint);
        break;

      case TabStyle.pill:
        // A pill capsule that acts as a background behind the tab item
        final Rect rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
        final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2));
        paint.color = color;
        canvas.drawRRect(rrect, paint);
        break;

      case TabStyle.gradient:
        // Similar to pill, but filled with a beautiful gradient shader
        final Rect rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
        final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2));
        paint.shader = LinearGradient(
          colors: [
            color,
            color.withAlpha((0.7 * 255).round()),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(rect);
        canvas.drawRRect(rrect, paint);
        break;

      case TabStyle.glass:
        // Translucent background with a thin glassy outline
        final Rect rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
        final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2));
        
        // Draw glass fill
        paint.color = Colors.white.withAlpha((0.15 * 255).round());
        canvas.drawRRect(rrect, paint);
        
        // Draw glass border outline
        final Paint borderPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white.withAlpha((0.3 * 255).round())
          ..strokeWidth = 1.0;
        canvas.drawRRect(rrect, borderPaint);
        break;

      case TabStyle.floating:
        // A floating capsule background offset slightly vertically with a soft drop shadow
        final Rect rect = Rect.fromLTWH(8, 8, size.width - 16, size.height - 16);
        final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2));
        
        final Path shadowPath = Path()..addRRect(rrect);
        // Draw shadow
        canvas.drawShadow(
          shadowPath,
          shadowColor.withAlpha((0.3 * 255).round()),
          4.0,
          true,
        );
        
        paint.color = color;
        canvas.drawRRect(rrect, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant IndicatorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.style != style ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.shadowColor != shadowColor;
  }
}