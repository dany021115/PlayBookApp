import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:go_router/go_router.dart';

class PageTransitions {
  static CustomTransitionPage fadeTransition({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static CustomTransitionPage customTransition({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 300),
    Offset? begin = const Offset(0.0, 1.0),
    Offset? end = Offset.zero,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static CustomTransitionPage scaleTransition({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  static Page<void> platformTransition({
    required Widget child,
    required GoRouterState state,
  }) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPage(key: state.pageKey, child: child);
    }
    return fadeTransition(child: child, state: state);
  }
}
