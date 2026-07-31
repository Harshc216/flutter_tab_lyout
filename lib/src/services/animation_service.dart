import 'package:flutter/material.dart';

import '../enums/tab_animation.dart';

/// Provides page transition animations.
class AnimationService {
  const AnimationService._();

  /// Returns an animated widget based on the selected animation.
  static Widget buildAnimation({
    required TabAnimation animation,
    required Widget child,
  }) {
    switch (animation) {
      case TabAnimation.none:
        return child;

      case TabAnimation.fade:
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: child,
        );

      case TabAnimation.scale:
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(
            begin: 0.9,
            end: 1,
          ),
          builder: (context, value, widget) {
            return Transform.scale(
              scale: value,
              child: widget,
            );
          },
          child: child,
        );

      case TabAnimation.slide:
        return TweenAnimationBuilder<Offset>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ),
          builder: (context, value, widget) {
            return Transform.translate(
              offset: Offset(
                value.dx * 100,
                value.dy,
              ),
              child: widget,
            );
          },
          child: child,
        );

      case TabAnimation.slideFade:
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(
            begin: 0,
            end: 1,
          ),
          builder: (context, value, widget) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(
                  (1 - value) * 50,
                  0,
                ),
                child: widget,
              ),
            );
          },
          child: child,
        );
    }
  }
}