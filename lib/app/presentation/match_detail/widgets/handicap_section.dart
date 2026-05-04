import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/app/presentation/match_detail/widgets/market_odd_cell.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Hándicap asiático" card — 3 odds (home -1.5 / draw -1.5 / away +1.5).
///
/// Mirrors Pencil `Q0YzF / hcap`.
class HandicapSection extends StatelessWidget {
  final List<MockOdd> handicap;
  const HandicapSection({super.key, required this.handicap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: AppRadius.sheetBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hándicap asiático',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Row(
            children: [
              for (int i = 0; i < handicap.length; i++) ...[
                Expanded(child: MarketOddCell(odd: handicap[i])),
                if (i < handicap.length - 1) const SizedBox(width: 6),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
