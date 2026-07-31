import 'package:flutter/material.dart';

/// Model representing a single tab.
class TabItem {
  /// Creates a tab item.
  const TabItem({
    required this.title,
    this.icon,
    this.badge,
    this.enabled = true,
  });

  /// Title displayed on the tab.
  final String title;

  /// Optional icon displayed before the title.
  final IconData? icon;

  /// Optional badge text.
  ///
  /// Example:
  /// "5"
  /// "10"
  /// "99+"
  final String? badge;

  /// Whether this tab can be selected.
  final bool enabled;

  /// Creates a copy of this tab with updated values.
  TabItem copyWith({
    String? title,
    IconData? icon,
    String? badge,
    bool? enabled,
  }) {
    return TabItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      badge: badge ?? this.badge,
      enabled: enabled ?? this.enabled,
    );
  }
}