import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../models/tab_item.dart';
import '../themes/tab_theme.dart';
import '../enums/tab_style.dart';
import '../utils/constants.dart';
import 'animated_indicator.dart';
import 'modern_tab_item.dart';

/// Displays a horizontal tab bar with responsive sliding indicators.
class ModernTabBar extends StatefulWidget {
  /// Creates a modern tab bar.
  const ModernTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    required this.theme,
    this.isScrollable = false,
    this.equalWidths = true,
    this.style = TabStyle.material,
  });

  /// List of tabs.
  final List<TabItem> tabs;

  /// Tab controller.
  final ModernTabController controller;

  /// Theme.
  final TabThemeData theme;

  /// Whether the tab bar is scrollable.
  final bool isScrollable;

  /// Whether tabs should have equal widths (ignored if [isScrollable] is true).
  final bool equalWidths;

  /// The tab style.
  final TabStyle style;

  @override
  State<ModernTabBar> createState() => _ModernTabBarState();
}

class _ModernTabBarState extends State<ModernTabBar> {
  final List<GlobalKey> _tabKeys = [];
  final GlobalKey _stackKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  List<double> _tabLefts = [];
  List<double> _tabWidths = [];
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.controller.selectedIndex.toDouble();
    _generateKeys();
    widget.controller.pageController.addListener(_onPageScroll);
    widget.controller.addListener(_onSelectedIndexChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTabPositions();
      _scrollToSelectedTab();
    });
  }

  void _generateKeys() {
    _tabKeys.clear();
    for (int i = 0; i < widget.tabs.length; i++) {
      _tabKeys.add(GlobalKey());
    }
  }

  @override
  void didUpdateWidget(covariant ModernTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _generateKeys();
      _tabLefts = [];
      _tabWidths = [];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateTabPositions();
        _scrollToSelectedTab();
      });
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.pageController.removeListener(_onPageScroll);
      oldWidget.controller.removeListener(_onSelectedIndexChange);
      widget.controller.pageController.addListener(_onPageScroll);
      widget.controller.addListener(_onSelectedIndexChange);
      _currentPage = widget.controller.selectedIndex.toDouble();
    }
  }

  @override
  void dispose() {
    widget.controller.pageController.removeListener(_onPageScroll);
    widget.controller.removeListener(_onSelectedIndexChange);
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageScroll() {
    if (widget.controller.pageController.hasClients) {
      try {
        final double? page = widget.controller.pageController.page;
        if (page != null) {
          setState(() {
            _currentPage = page;
          });
        }
      } catch (_) {}
    }
  }

  void _onSelectedIndexChange() {
    _scrollToSelectedTab();
  }

  void _updateTabPositions() {
    if (!mounted) return;

    final RenderBox? stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || !stackBox.hasSize) return;

    final List<double> newLefts = [];
    final List<double> newWidths = [];
    bool hasChanges = false;

    for (int i = 0; i < widget.tabs.length; i++) {
      final RenderBox? box = _tabKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        final position = box.localToGlobal(Offset.zero, ancestor: stackBox);
        newLefts.add(position.dx);
        newWidths.add(box.size.width);
      } else {
        newLefts.add(0);
        newWidths.add(0);
      }
    }

    if (_tabLefts.length != newLefts.length || _tabWidths.length != newWidths.length) {
      hasChanges = true;
    } else {
      for (int i = 0; i < newLefts.length; i++) {
        if ((_tabLefts[i] - newLefts[i]).abs() > 0.5 || (_tabWidths[i] - newWidths[i]).abs() > 0.5) {
          hasChanges = true;
          break;
        }
      }
    }

    if (hasChanges) {
      setState(() {
        _tabLefts = newLefts;
        _tabWidths = newWidths;
      });
    }
  }

  void _scrollToSelectedTab() {
    if (!widget.isScrollable || _tabLefts.isEmpty) return;
    if (!_scrollController.hasClients) return;

    final index = widget.controller.selectedIndex;
    if (index < 0 || index >= _tabLefts.length) return;

    final tabLeft = _tabLefts[index];
    final tabWidth = _tabWidths[index];

    final RenderBox? containerBox = context.findRenderObject() as RenderBox?;
    if (containerBox == null) return;

    final viewportWidth = containerBox.size.width;
    final targetScrollOffset = tabLeft - (viewportWidth / 2) + (tabWidth / 2);

    final maxScroll = _scrollController.position.maxScrollExtent;
    final minScroll = _scrollController.position.minScrollExtent;
    final double clampedOffset = targetScrollOffset.clamp(minScroll, maxScroll);

    _scrollController.animateTo(
      clampedOffset,
      duration: TabConstants.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  double _getIndicatorLeft(BoxConstraints constraints) {
    if (_tabLefts.isEmpty || _tabWidths.isEmpty) {
      if (widget.equalWidths && !widget.isScrollable) {
        final double tabWidth = constraints.maxWidth / widget.tabs.length;
        return _currentPage * tabWidth;
      }
      return 0;
    }

    final int index = _currentPage.floor();
    final double fraction = _currentPage - index;

    if (index >= 0 && index < _tabLefts.length) {
      final double currentLeft = _tabLefts[index];
      if (index + 1 < _tabLefts.length) {
        final double nextLeft = _tabLefts[index + 1];
        return currentLeft + (nextLeft - currentLeft) * fraction;
      }
      return currentLeft;
    }
    return 0;
  }

  double _getIndicatorWidth(BoxConstraints constraints) {
    if (_tabLefts.isEmpty || _tabWidths.isEmpty) {
      if (widget.equalWidths && !widget.isScrollable) {
        return constraints.maxWidth / widget.tabs.length;
      }
      return 0;
    }

    final int index = _currentPage.floor();
    final double fraction = _currentPage - index;

    if (index >= 0 && index < _tabWidths.length) {
      final double currentWidth = _tabWidths[index];
      if (index + 1 < _tabWidths.length) {
        final double nextWidth = _tabWidths[index + 1];
        return currentWidth + (nextWidth - currentWidth) * fraction;
      }
      return currentWidth;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final List<Widget> tabWidgets = List.generate(
              widget.tabs.length,
              (index) {
                Widget tabItem = ModernTabItem(
                  key: _tabKeys[index],
                  index: index,
                  item: widget.tabs[index],
                  controller: widget.controller,
                  theme: widget.theme,
                  style: widget.style,
                  onTap: () => widget.controller.select(index),
                );

                if (widget.equalWidths && !widget.isScrollable) {
                  return Expanded(child: tabItem);
                }
                return tabItem;
              },
            );

            Widget tabContent = Stack(
              key: _stackKey,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: _getIndicatorLeft(constraints),
                  width: _getIndicatorWidth(constraints),
                  top: 0,
                  bottom: 0,
                  child: AnimatedIndicator(
                    theme: widget.theme,
                    style: widget.style,
                  ),
                ),
                Row(
                  mainAxisSize: widget.isScrollable ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: tabWidgets,
                ),
              ],
            );

            // Request layout measurement after rendering completes
            WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabPositions());

            Widget barContainer = Container(
              height: TabConstants.tabHeight + widget.theme.elevation * 2,
              decoration: BoxDecoration(
                color: widget.theme.backgroundColor,
                borderRadius: widget.theme.borderRadius,
                boxShadow: widget.theme.elevation > 0
                    ? [
                        BoxShadow(
                          color: widget.theme.shadowColor,
                          blurRadius: widget.theme.elevation * 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: widget.isScrollable
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: tabContent,
                    )
                  : tabContent,
            );

            return NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (notification) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabPositions());
                return true;
              },
              child: SizeChangedLayoutNotifier(
                child: barContainer,
              ),
            );
          },
        );
      },
    );
  }
}