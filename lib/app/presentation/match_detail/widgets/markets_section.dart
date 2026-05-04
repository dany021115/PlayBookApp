import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/app/presentation/match_detail/widgets/market_odd_cell.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Cuotas en vivo" card with N market groups + extra-markets link.
///
/// Mirrors Pencil `uC52U / mkSec`.
class MarketsSection extends StatelessWidget {
  final List<MockMarketGroup> markets;
  final int bookmakerCount;
  final int extraCount;
  final VoidCallback? onSeeMore;

  const MarketsSection({
    super.key,
    required this.markets,
    required this.bookmakerCount,
    required this.extraCount,
    this.onSeeMore,
  });

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
          _Header(bookmakerCount: bookmakerCount),
          for (final group in markets) ...[
            const SizedBox(height: AppSpacing.s12),
            Text(
              group.label,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            _OddsRow(odds: group.odds),
          ],
          const SizedBox(height: AppSpacing.s12),
          GestureDetector(
            onTap: onSeeMore,
            child: Text(
              '+$extraCount mercados más →',
              style: const TextStyle(
                color: AppColor.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int bookmakerCount;
  const _Header({required this.bookmakerCount});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColor.danger,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Cuotas en vivo',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          '$bookmakerCount casas',
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _OddsRow extends StatelessWidget {
  final List<MockOdd> odds;
  const _OddsRow({required this.odds});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < odds.length; i++) ...[
          Expanded(child: MarketOddCell(odd: odds[i])),
          if (i < odds.length - 1) const SizedBox(width: 6),
        ],
      ],
    );
  }
}
