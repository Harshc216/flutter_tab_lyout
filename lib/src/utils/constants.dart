import 'package:flutter/material.dart';

/// Common values used throughout the tab layout library.
class TabConstants {
  const TabConstants._();

  /// Default animation duration.
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Default border radius.
  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  /// Default padding.
  static const EdgeInsets padding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10,
  );

  /// Space between icon and title.
  static const double iconSpacing = 8;

  /// Default icon size.
  static const double iconSize = 20;

  /// Default font size.
  static const double fontSize = 14;

  /// Default badge size.
  static const double badgeSize = 18;

  /// Default indicator height.
  static const double indicatorHeight = 4;

  /// Default tab height.
  static const double tabHeight = 48;

  /// Default elevation.
  static const double elevation = 2;
}