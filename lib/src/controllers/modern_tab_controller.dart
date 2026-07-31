import 'package:flutter/material.dart';

/// Controls the selected tab and notifies listeners when it changes.
class ModernTabController extends ChangeNotifier {
  /// Creates a tab controller.
  ModernTabController({
    required this.length,
    this.initialIndex = 0,
  })  : assert(length > 0, 'Length must be greater than zero.'),
        assert(initialIndex >= 0 && initialIndex < length, 'Initial index must be within bounds.'),
        _selectedIndex = initialIndex {
    _pageController = PageController(initialPage: initialIndex);
  }

  /// Total number of tabs.
  final int length;

  /// Initial selected tab.
  final int initialIndex;

  int _selectedIndex;
  late final PageController _pageController;

  /// Page controller synchronized with tab state.
  PageController get pageController => _pageController;

  /// Current selected tab index.
  int get selectedIndex => _selectedIndex;

  /// Changes the selected tab.
  void select(int index, {bool fromPageView = false}) {
    if (index < 0 || index >= length) return;
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();

    if (!fromPageView && _pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Moves to the next tab.
  void next() {
    if (_selectedIndex >= length - 1) return;
    select(_selectedIndex + 1);
  }

  /// Moves to the previous tab.
  void previous() {
    if (_selectedIndex <= 0) return;
    select(_selectedIndex - 1);
  }

  /// Animates the controller to the target index.
  void animateTo(int index, {Duration? duration, Curve? curve}) {
    if (index < 0 || index >= length) return;
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: duration ?? const Duration(milliseconds: 300),
        curve: curve ?? Curves.easeInOut,
      );
    }
  }

  /// Instantly jumps to the target index.
  void jumpTo(int index) {
    if (index < 0 || index >= length) return;
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();

    if (_pageController.hasClients) {
      _pageController.jumpToPage(index);
    }
  }

  /// Resets the selected index to the initial index.
  void reset() {
    animateTo(initialIndex);
  }

  /// Returns true if this tab is selected.
  bool isSelected(int index) {
    return _selectedIndex == index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}