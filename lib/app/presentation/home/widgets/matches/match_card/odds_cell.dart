import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_value.dart';
import 'package:playbook/device/theme/color.dart';

/// Single odds cell (one of three in a 1/X/2 row).
///
/// Mirrors Pencil `c1o1` / `c1ox` / `c1o2` and the compact variants
/// `c2o1` / `c2ox` / `c2o2`.
class OddsCell extends StatelessWidget {
  final OddsValue value;
  const OddsCell({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Color deltaColor() {
      if (value.up == null) return colors.onSurfaceVariant;
      return value.up! ? AppColor.success : AppColor.danger;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // Pencil OddsCell fill = `$bg/canvas` (darker than the card surface),
        // so it visually pops down inside the card.
        color: value.selected ? AppColor.primary : colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: value.selected
            ? null
            : Border.all(color: colors.outline, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: value.isCompact
            ? [
                Text(
                  value.label,
                  style: TextStyle(
                    color: value.selected
                        ? AppColor.onPrimary
                        : colors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ]
            : [
                Text(
                  value.label,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.price,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.delta,
                  style: TextStyle(
                    color: deltaColor(),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
      ),
    );
  }
}
