import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/team_crest.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/typography.dart';

/// Home crest+name | score 24/800 | Away name+crest.
///
/// `homeWinning`:
///   * `true`  → home score green, away muted
///   * `false` → home muted, away green
///   * `null`  → both onSurface
class ScoreRow extends StatelessWidget {
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;

  const ScoreRow({
    super.key,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    this.homeWinning,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyle(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: _Team(name: home, leftAligned: true)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(homeScore,
                  style: styles.scoreLarge?.copyWith(
                    color: _scoreColor(colors, isHome: true),
                    fontSize: 24,
                  )),
              const SizedBox(width: 8),
              Text('-',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(width: 8),
              Text(awayScore,
                  style: styles.scoreLarge?.copyWith(
                    color: _scoreColor(colors, isHome: false),
                    fontSize: 24,
                  )),
            ],
          ),
          Expanded(child: _Team(name: away, leftAligned: false)),
        ],
      ),
    );
  }

  Color _scoreColor(ColorScheme colors, {required bool isHome}) {
    if (homeWinning == null) return colors.onSurface;
    final winning = isHome ? homeWinning! : !homeWinning!;
    return winning ? AppColor.success : colors.onSurfaceVariant;
  }
}

class _Team extends StatelessWidget {
  final String name;
  final bool leftAligned;
  const _Team({required this.name, required this.leftAligned});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final crest = const TeamCrest();
    final label = Flexible(
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: colors.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: leftAligned
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: leftAligned
          ? [crest, const SizedBox(width: 10), label]
          : [label, const SizedBox(width: 10), crest],
    );
  }
}
