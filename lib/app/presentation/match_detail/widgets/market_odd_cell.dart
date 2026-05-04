import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/device/theme/color.dart';

/// Odds cell for the detail-screen markets section.
///
/// Different from `OddsCell` (in inicio): label is bigger, optional
/// `bookmaker hint` line under price (e.g. "↑ Bet365" / "= Pinnacle").
/// Mirrors Pencil `mh1` / `mhx` / `mh2` / `mo` / `mu` / `btsY` / `btsN`.
class MarketOddCell extends StatelessWidget {
  final MockOdd odd;
  const MarketOddCell({super.key, required this.odd});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final selected = odd.selected;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColor.primary : colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: selected ? null : Border.all(color: colors.outline, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            odd.label,
            style: TextStyle(
              color: selected
                  ? AppColor.onPrimary.withValues(alpha: 0.8)
                  : colors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            odd.price,
            style: TextStyle(
              color: selected ? AppColor.onPrimary : colors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (odd.hint != null) ...[
            const SizedBox(height: 2),
            Text(
              odd.hint!,
              style: TextStyle(
                color: _hintColor(odd.hintUp, colors),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _hintColor(bool? up, ColorScheme colors) {
    if (up == null) return colors.onSurfaceVariant;
    return up ? AppColor.success : AppColor.danger;
  }
}
