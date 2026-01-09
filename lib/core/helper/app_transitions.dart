import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppTransitions {
  static CustomTransitionPage fade({
    required Widget child,
    required LocalKey key,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: key,
      transitionDuration: duration,
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(opacity: curved, child: child);
      },
    );
  }

  static CustomTransitionPage fadeScale({
    required Widget child,
    required LocalKey key,
  }) {
    return CustomTransitionPage(
      key: key,
      transitionDuration: const Duration(milliseconds: 350),
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween(begin: 0.97, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  static CustomTransitionPage slideX({
    required Widget child,
    required LocalKey key,
  }) {
    return CustomTransitionPage(
      key: key,
      transitionDuration: const Duration(milliseconds: 350),
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        );
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  static Page cupertino({required Widget child, LocalKey? key}) {
    return CupertinoPage(key: key, child: child);
  }
}
