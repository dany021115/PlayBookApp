import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Estadísticas en vivo" card.
///
/// Mirrors Pencil `vcDYs / stats`.
class LiveStatsSection extends StatelessWidget {
  final int homePossession;
  final int awayPossession;
  final List<MockStatRow> stats;

  const LiveStatsSection({
    super.key,
    required this.homePossession,
    required this.awayPossession,
    required this.stats,
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
            'Estadísticas en vivo',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          _PossessionRow(home: homePossession, away: awayPossession),
          for (final row in stats) ...[
            const SizedBox(height: 10),
            _StatRow(row: row),
          ],
        ],
      ),
    );
  }
}

class _PossessionRow extends StatelessWidget {
  final int home;
  final int away;
  const _PossessionRow({required this.home, required this.away});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final valueStyle = TextStyle(
      color: colors.onSurface,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$home%', style: valueStyle),
            Text(
              'Posesión',
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('$away%', style: valueStyle),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 6,
          child: Row(
            children: [
              Expanded(
                flex: home,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 0),
              Expanded(
                flex: away,
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final MockStatRow row;
  const _StatRow({required this.row});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final homeStyle = TextStyle(
      color: row.homeHighlight ? AppColor.success : colors.onSurface,
      fontSize: 13,
      fontWeight: FontWeight.w800,
    );
    final awayStyle = TextStyle(
      color: colors.onSurface,
      fontSize: 13,
      fontWeight: FontWeight.w800,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(row.homeValue, style: homeStyle),
        Text(
          row.label,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(row.awayValue, style: awayStyle),
      ],
    );
  }
}
