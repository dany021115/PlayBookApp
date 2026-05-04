import 'package:flutter/material.dart';
import 'package:playbook/app/shared/widgets/main_shell.dart' show NavTab;
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Fixed left sidebar for desktop layouts.
///
/// Mirrors Pencil `utJHR / Sidebar Nav` — 240 wide, surface fill, right
/// 1px border. Brand row up top + vertical nav list with 44h items
/// (radius 10, padding [0, 12, 0, 14], gap 12). Active item paints a
/// primary 13% bg with primary icon + label.
class AppSidebarNav extends StatelessWidget {
  final List<NavTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppSidebarNav({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 240,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16, vertical: AppSpacing.s24),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        border: Border(
          right: BorderSide(color: colors.outline, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'PlayBook',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s24),
          for (int i = 0; i < tabs.length; i++) ...[
            if (i > 0) const SizedBox(height: 6),
            _SidebarItem(
              tab: tabs[i],
              active: i == currentIndex,
              onTap: () => onTap(i),
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final NavTab tab;
  final bool active;
  final VoidCallback onTap;
  const _SidebarItem({
    required this.tab,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: active,
      label: tab.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 44,
          padding: const EdgeInsets.fromLTRB(14, 0, 12, 0),
          decoration: BoxDecoration(
            color: active
                ? AppColor.primary.withValues(alpha: 0.13)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                tab.icon,
                size: 18,
                color: active ? AppColor.primary : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                tab.label,
                style: TextStyle(
                  color:
                      active ? AppColor.primary : colors.onSurfaceVariant,
                  fontSize: 14,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
