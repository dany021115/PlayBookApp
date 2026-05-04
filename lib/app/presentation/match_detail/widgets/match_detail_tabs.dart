import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Horizontal alignment / distribution of the tabs row.
///
/// * [stretch] — every tab gets equal width via `Expanded` (default,
///   matches Pencil `UtdzO / mdTabs`).
/// * [start] / [center] / [end] — tabs are sized to their content and
///   aligned at the start, center, or end of the row.
enum MatchDetailTabsAlignment { stretch, start, center, end }

/// Underline tabs row for the detail screen.
///
/// Mirrors Pencil `UtdzO / mdTabs`.
class MatchDetailTabs extends StatelessWidget {
  final int activeIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;
  final MatchDetailTabsAlignment alignment;

  const MatchDetailTabs({
    super.key,
    required this.activeIndex,
    required this.labels,
    required this.onChanged,
    this.alignment = MatchDetailTabsAlignment.stretch,
  });

  static const defaultLabels = [
    'Resumen',
    'Cuotas',
    'Alineación',
    'H2H',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.outline, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Row(
        mainAxisAlignment: _mainAxis,
        children: _buildChildren(),
      ),
    );
  }

  MainAxisAlignment get _mainAxis {
    switch (alignment) {
      case MatchDetailTabsAlignment.stretch:
      case MatchDetailTabsAlignment.start:
        return MainAxisAlignment.start;
      case MatchDetailTabsAlignment.center:
        return MainAxisAlignment.center;
      case MatchDetailTabsAlignment.end:
        return MainAxisAlignment.end;
    }
  }

  List<Widget> _buildChildren() {
    final children = <Widget>[];
    for (int i = 0; i < labels.length; i++) {
      final tab = _Tab(
        label: labels[i],
        active: i == activeIndex,
        onTap: () => onChanged(i),
      );
      // `stretch` distributes width evenly. The other modes size to content
      // and add a 24px gap between tabs (Pencil default for sport tabs).
      if (alignment == MatchDetailTabsAlignment.stretch) {
        children.add(Expanded(child: tab));
      } else {
        if (i > 0) children.add(const SizedBox(width: AppSpacing.s24));
        children.add(tab);
      }
    }
    return children;
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Tab({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // Stack lets the active 3×32 indicator sit flush with the bottom of the
    // tab row, overlapping the container's 1px outline border. Inactive tabs
    // paint a transparent indicator of the same size so the heights stay
    // identical and nothing shifts when switching.
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: active ? AppColor.primary : colors.onSurfaceVariant,
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                  height: 1.2,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: active ? AppColor.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
