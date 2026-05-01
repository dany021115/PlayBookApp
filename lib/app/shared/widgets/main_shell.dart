import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/device/router/manager.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = [
    _Tab(icon: Icons.sports_soccer, label: 'Matches', path: '/home/matches'),
    _Tab(icon: Icons.insights_outlined, label: 'Predictions', path: '/home/predictions'),
    _Tab(icon: Icons.bookmark_border, label: 'Follows', path: '/home/follows'),
    _Tab(icon: Icons.person_outline, label: 'Profile', path: '/home/profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final i = _tabs.indexWhere((t) => location.startsWith(t.path));
    return i < 0 ? 0 : i;
  }

  void _onTap(BuildContext context, int index) {
    final path = _tabs[index].path;
    final route = RouterManager.getRouteFromPath(path);
    if (route != null) {
      RouterManager.go(route, context: context);
    } else {
      context.go(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (i) => _onTap(context, i),
        items: [
          for (final t in _tabs)
            BottomNavigationBarItem(icon: Icon(t.icon), label: t.label),
        ],
      ),
    );
  }
}

class _Tab {
  final IconData icon;
  final String label;
  final String path;
  const _Tab({required this.icon, required this.label, required this.path});
}

