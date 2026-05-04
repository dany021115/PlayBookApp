import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

class SportItem {
  final String emoji;
  final String label;
  const SportItem({required this.emoji, required this.label});
}

/// Underline-style sport tabs (⚽ Fútbol / 🏀 Básquet / ...).
///
/// Mirrors Pencil `sportTabs`.
class SportTabs extends StatelessWidget {
  final int activeIndex;
  final List<SportItem> items;
  final ValueChanged<int> onChanged;

  const SportTabs({
    super.key,
    required this.activeIndex,
    required this.items,
    required this.onChanged,
  });

  static const defaultItems = <SportItem>[
    SportItem(emoji: '⚽', label: 'Fútbol'),
    SportItem(emoji: '🏀', label: 'Básquet'),
    SportItem(emoji: '⚾', label: 'Béisbol'),
    SportItem(emoji: '🎾', label: 'Tenis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24, 0, AppSpacing.s24, AppSpacing.s12),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _SportTab(
              item: items[i],
              active: i == activeIndex,
              onTap: () => onChanged(i),
            ),
            if (i < items.length - 1) const SizedBox(width: AppSpacing.s24),
          ],
        ],
      ),
    );
  }
}

class _SportTab extends StatelessWidget {
  final SportItem item;
  final bool active;
  final VoidCallback onTap;
  const _SportTab({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${item.emoji} ${item.label}',
            style: TextStyle(
              color: active ? colors.onSurface : colors.onSurfaceVariant,
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 24,
            height: 3,
            decoration: BoxDecoration(
              color: active ? AppColor.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
