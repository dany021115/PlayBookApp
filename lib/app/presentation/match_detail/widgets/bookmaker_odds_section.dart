import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Mejores cuotas por casa · 1X2" — bookmaker name + 1X2 odds string.
/// Top row (best=true) painted in `success` color.
///
/// Mirrors Pencil `wJw6V / casas`.
class BookmakerOddsSection extends StatelessWidget {
  final List<MockBookmakerOdds> rows;
  final VoidCallback? onSeeAll;
  const BookmakerOddsSection({
    super.key,
    required this.rows,
    this.onSeeAll,
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
          Text(
            'Mejores cuotas por casa · 1X2',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r.name,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    r.odds,
                    style: TextStyle(
                      color: r.best ? AppColor.success : colors.onSurface,
                      fontSize: 12,
                      fontWeight:
                          r.best ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'Ver todas las casas →',
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
