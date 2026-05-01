import 'package:flutter/material.dart';

/// Wraps the app so a full restart can be triggered (e.g. after logout
/// to wipe DI singletons + BLoC state). Usage:
///
/// ```dart
/// Phoenix.rebirth(context);
/// ```
class Phoenix extends StatefulWidget {
  final Widget child;
  const Phoenix({super.key, required this.child});

  static void rebirth(BuildContext context) {
    context.findAncestorStateOfType<_PhoenixState>()?.restart();
  }

  @override
  State<Phoenix> createState() => _PhoenixState();
}

class _PhoenixState extends State<Phoenix> {
  Key _key = UniqueKey();
  void restart() => setState(() => _key = UniqueKey());

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: _key, child: widget.child);
}
