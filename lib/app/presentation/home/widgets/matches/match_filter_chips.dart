import 'package:flutter/material.dart';
import 'package:playbook/app/shared/widgets/pill_chip.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Horizontal filter chips: live count + Hoy / Mañana / Top ligas.
///
/// Mirrors Pencil `chips`.
class MatchFilterChips extends StatelessWidget {
  final int activeIndex;
  final int liveCount;
  final ValueChanged<int> onChanged;

  const MatchFilterChips({
    super.key,
    required this.activeIndex,
    required this.liveCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.s24, 0, AppSpacing.s24, AppSpacing.s16),
        children: [
          PillChip(
            label: 'EN VIVO · $liveCount',
            active: activeIndex == 0,
            activeColor: AppColor.danger,
            onTap: () => onChanged(0),
            leading: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: activeIndex == 0
                    ? AppColor.onPrimary
                    : AppColor.danger,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          PillChip(
              label: 'Hoy',
              active: activeIndex == 1,
              onTap: () => onChanged(1)),
          const SizedBox(width: 8),
          PillChip(
              label: 'Mañana',
              active: activeIndex == 2,
              onTap: () => onChanged(2)),
          const SizedBox(width: 8),
          PillChip(
              label: 'Top ligas',
              active: activeIndex == 3,
              onTap: () => onChanged(3)),
        ],
      ),
    );
  }
}
