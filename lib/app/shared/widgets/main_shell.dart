import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/shared/widgets/app_sidebar_nav.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// One nav entry shared between the mobile pill nav and the desktop sidebar.
/// Made public so [AppSidebarNav] in the shared folder can consume the same
/// list without duplicating the model.
class NavTab {
  final IconData icon;
  final String label;
  final String path;
  const NavTab({
    required this.icon,
    required this.label,
    required this.path,
  });
}

/// App shell.
///
/// Mobile / tablet — Pencil `qOUhL`: floating pill nav at the bottom.
/// Desktop — Pencil `utJHR`: fixed left sidebar 240 wide, body fills the
/// remainder.
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = <NavTab>[
    NavTab(icon: Icons.home_outlined, label: 'Inicio', path: '/home/matches'),
    NavTab(
        icon: Icons.lightbulb_outline,
        label: 'Picks',
        path: '/home/predictions'),
    NavTab(
        icon: Icons.bookmark_border,
        label: 'Guardados',
        path: '/home/follows'),
    NavTab(icon: Icons.person_outline, label: 'Perfil', path: '/home/profile'),
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
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
    final currentIndex = _currentIndex(context);

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            AppSidebarNav(
              tabs: _tabs,
              currentIndex: currentIndex,
              onTap: (i) => _onTap(context, i),
            ),
            Expanded(child: child),
          ],
        ),
      );
    }

    // Mobile + tablet (anything below desktop breakpoint) → floating pill
    // nav at the bottom, matching the mobile/tablet pencil specs.
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(
            AppSpacing.s16, 0, AppSpacing.s16, AppSpacing.s12),
        child: _PillNavBar(
          tabs: _tabs,
          currentIndex: currentIndex,
          onTap: (i) => _onTap(context, i),
        ),
      ),
    );
  }
}

class _PillNavBar extends StatelessWidget {
  final List<NavTab> tabs;
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
        color: colors.surfaceContainer,
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
  final NavTab tab;
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
                tab.label.toUpperCase(),
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
