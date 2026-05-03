import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

/// App shell with the floating pill nav from Pencil `qOUhL` (Bottom Nav).
///
/// Container: 62 high, surface bg, 36 radius, 1px border, padding 4.
/// Each tab is a pill (radius 26) with vertical icon + 10/600 caps label,
/// gap 4. Active tab fills primary, inactive uses muted icon/label.
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = <_Tab>[
    _Tab(icon: Icons.home_outlined, label: 'INICIO', path: '/home/matches'),
    _Tab(
        icon: Icons.lightbulb_outline,
        label: 'TIPS',
        path: '/home/predictions'),
    _Tab(
        icon: Icons.bookmark_border,
        label: 'GUARDADOS',
        path: '/home/follows'),
    _Tab(icon: Icons.person_outline, label: 'PERFIL', path: '/home/profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final i = _tabs.indexWhere((t) => location.startsWith(t.path));
    return i < 0 ? 0 : i;
  }

  void _onTap(BuildContext context, int index) =>
      context.go(_tabs[index].path);

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(
            AppSpacing.s16, 0, AppSpacing.s16, AppSpacing.s12),
        child: _PillNavBar(
          tabs: _tabs,
          currentIndex: index,
          onTap: (i) => _onTap(context, i),
        ),
      ),
    );
  }
}

class _PillNavBar extends StatelessWidget {
  final List<_Tab> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _PillNavBar({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: 62,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: colors.outline, width: 1),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: _PillTab(
                tab: tabs[i],
                active: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _PillTab extends StatelessWidget {
  final _Tab tab;
  final bool active;
  final VoidCallback onTap;

  const _PillTab({
    required this.tab,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final fg = active ? AppColor.onPrimary : AppColor.muted;
    return Semantics(
      button: true,
      selected: active,
      label: tab.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: active
              ? BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(26),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tab.icon, size: 18, color: fg),
              const SizedBox(height: 4),
              Text(
                tab.label,
                style: styles.caption?.copyWith(
                  color: fg,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
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
