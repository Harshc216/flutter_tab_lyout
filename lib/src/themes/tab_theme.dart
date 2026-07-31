import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Theme configuration for the modern tab layout.
class TabThemeData {
  /// Creates a tab theme.
  const TabThemeData({
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.indicatorColor = Colors.blue,
    this.badgeColor = Colors.red,
    this.shadowColor = Colors.black12,
    this.borderRadius = TabConstants.borderRadius,
    this.elevation = TabConstants.elevation,
    this.selectedTextStyle = const TextStyle(
      fontSize: TabConstants.fontSize,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    this.unselectedTextStyle = const TextStyle(
      fontSize: TabConstants.fontSize,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
  });

  /// Background color of the tab bar.
  final Color backgroundColor;

  /// Selected tab color.
  final Color selectedColor;

  /// Unselected tab color.
  final Color unselectedColor;

  /// Indicator color.
  final Color indicatorColor;

  /// Badge background color.
  final Color badgeColor;

  /// Shadow color.
  final Color shadowColor;

  /// Border radius.
  final BorderRadius borderRadius;

  /// Card elevation.
  final double elevation;

  /// Text style for selected tab.
  final TextStyle selectedTextStyle;

  /// Text style for unselected tab.
  final TextStyle unselectedTextStyle;

  /// Returns a copy with updated values.
  TabThemeData copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    Color? indicatorColor,
    Color? badgeColor,
    Color? shadowColor,
    BorderRadius? borderRadius,
    double? elevation,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
  }) {
    return TabThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      badgeColor: badgeColor ?? this.badgeColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      selectedTextStyle:
      selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle:
      unselectedTextStyle ?? this.unselectedTextStyle,
    );
  }
}