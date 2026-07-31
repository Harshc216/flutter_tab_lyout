import 'package:flutter/material.dart';

import '../controllers/modern_tab_controller.dart';
import '../enums/tab_animation.dart';

/// Displays the page for the selected tab with smooth gesture swiping and transitions.
class ModernTabView extends StatefulWidget {
  /// Creates a modern tab view.
  const ModernTabView({
    super.key,
    required this.controller,
    required this.children,
    this.animation = TabAnimation.slide,
    this.physics,
  });

  /// Tab controller.
  final ModernTabController controller;

  /// Pages.
  final List<Widget> children;

  /// Transition animation style.
  final TabAnimation animation;

  /// Physics for the page view scroll.
  final ScrollPhysics? physics;

  @override
  State<ModernTabView> createState() => _ModernTabViewState();
}

class _ModernTabViewState extends State<ModernTabView> {
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.controller.selectedIndex.toDouble();
    widget.controller.pageController.addListener(_onPageScroll);
  }

  @override
  void didUpdateWidget(covariant ModernTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.pageController.removeListener(_onPageScroll);
      widget.controller.pageController.addListener(_onPageScroll);
      _currentPage = widget.controller.selectedIndex.toDouble();
    }
  }

  @override
  void dispose() {
    widget.controller.pageController.removeListener(_onPageScroll);
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.pageController,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      itemCount: widget.children.length,
      onPageChanged: (index) {
        widget.controller.select(index, fromPageView: true);
      },
      itemBuilder: (context, index) {
        final double delta = index - _currentPage;

        return _buildAnimatedPage(widget.children[index], delta);
      },
    );
  }

  Widget _buildAnimatedPage(Widget child, double delta) {
    // If the page is completely offscreen, hide it to save rendering resources
    if (delta.abs() >= 1.0) {
      return Visibility(
        visible: false,
        maintainState: true,
        child: child,
      );
    }

    final double progress = (1.0 - delta.abs()).clamp(0.0, 1.0);

    switch (widget.animation) {
      case TabAnimation.none:
        return child;

      case TabAnimation.fade:
        return Opacity(
          opacity: progress,
          child: child,
        );

      case TabAnimation.scale:
        return Transform.scale(
          scale: 0.85 + 0.15 * progress,
          child: child,
        );

      case TabAnimation.slide:
        // PageView already has natural sliding.
        return child;

      case TabAnimation.slideFade:
        // Combines slide offset with opacity fade
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(delta * 80, 0), // Subtle parallax slide
            child: child,
          ),
        );
    }
  }
}