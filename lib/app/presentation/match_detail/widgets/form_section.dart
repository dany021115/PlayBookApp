import 'package:flutter/material.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Forma últimos 5" card with two team rows of W/D/L squares.
///
/// Mirrors Pencil `KpbH8 / form`.
class FormSection extends StatelessWidget {
  final String home;
  final String away;
  final List<MockFormResult> homeForm;
  final List<MockFormResult> awayForm;

  const FormSection({
    super.key,
    required this.home,
    required this.away,
    required this.homeForm,
    required this.awayForm,
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
            'Forma últimos 5',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          _TeamFormRow(name: home, results: homeForm),
          const SizedBox(height: AppSpacing.s8),
          _TeamFormRow(name: away, results: awayForm),
        ],
      ),
    );
  }
}

class _TeamFormRow extends StatelessWidget {
  final String name;
  final List<MockFormResult> results;
  const _TeamFormRow({required this.name, required this.results});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            for (int i = 0; i < results.length; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              _ResultSquare(result: results[i]),
            ],
          ],
        ),
      ],
    );
  }
}

class _ResultSquare extends StatelessWidget {
  final MockFormResult result;
  const _ResultSquare({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: result.color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
