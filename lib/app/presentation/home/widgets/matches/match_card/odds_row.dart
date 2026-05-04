import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_cell.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_value.dart';

/// Row of N odds cells (typically 1/X/2). Cells expand evenly with 6px gaps.
class OddsRow extends StatelessWidget {
  final List<OddsValue> values;
  const OddsRow({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < values.length; i++) ...[
          Expanded(child: OddsCell(value: values[i])),
          if (i < values.length - 1) const SizedBox(width: 6),
        ],
      ],
    );
  }
}
