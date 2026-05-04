import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

class LineupsSection extends StatelessWidget {
  final String formation;
  final String homeName;
  final String awayName;
  final List<String> homeLineup;
  final List<String> awayLineup;
  final int homeBenchExtra;
  final int awayBenchExtra;

  const LineupsSection({
    super.key,
    required this.formation,
    required this.homeName,
    required this.awayName,
    required this.homeLineup,
    required this.awayLineup,
    required this.homeBenchExtra,
    required this.awayBenchExtra,
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
            'Alineaciones confirmadas',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formation,
            style: const TextStyle(
              color: AppColor.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LineupColumn(
                  title: homeName.toUpperCase(),
                  players: homeLineup,
                  extra: homeBenchExtra,
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: _LineupColumn(
                  title: awayName.toUpperCase(),
                  players: awayLineup,
                  extra: awayBenchExtra,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LineupColumn extends StatelessWidget {
  final String title;
  final List<String> players;
  final int extra;
  const _LineupColumn({
    required this.title,
    required this.players,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        for (final p in players) ...[
          Text(
            p,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Text(
          '+$extra más',
          style: const TextStyle(
            color: AppColor.primary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
