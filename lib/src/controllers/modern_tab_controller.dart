import 'package:flutter/foundation.dart';

/// Controls the selected tab and notifies listeners when it changes.
class ModernTabController extends ChangeNotifier {
  /// Creates a tab controller.
  ModernTabController({
    this.initialIndex = 0,
  }) : _selectedIndex = initialIndex;

  /// Initial selected tab.
  final int initialIndex;

  int _selectedIndex;

  /// Current selected tab index.
  int get selectedIndex => _selectedIndex;

  /// Changes the selected tab.
  void select(int index) {
    if (_selectedIndex == index) {
      return;
    }

    _selectedIndex = index;
    notifyListeners();
  }

  /// Moves to the next tab.
  void next(int totalTabs) {
    if (_selectedIndex >= totalTabs - 1) {
      return;
    }

    _selectedIndex++;
    notifyListeners();
  }

  /// Moves to the previous tab.
  void previous() {
    if (_selectedIndex <= 0) {
      return;
    }

    _selectedIndex--;
    notifyListeners();
  }

  /// Alias for selecting a tab.
  void animateTo(int index) {
    select(index);
  }

  /// Returns true if this tab is selected.
  bool isSelected(int index) {
    return _selectedIndex == index;
  }
}