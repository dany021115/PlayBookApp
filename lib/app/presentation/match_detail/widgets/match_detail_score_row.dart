import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/team_crest.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Big score block for the detail hero.
///
/// Mirrors Pencil `mdScore` (48/800 mobile) and `yXEUn` (88/800 desktop).
class MatchDetailScoreRow extends StatelessWidget {
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;
  final bool isMobile;

  const MatchDetailScoreRow({
    super.key,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    required this.isMobile,
    this.homeWinning,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TeamColumn(
            name: home,
            crestSize: isMobile ? 56 : 80,
            width: isMobile ? 96 : 160,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ScoreText(
                text: homeScore,
                color: _scoreColor(colors, isHome: true),
                fontSize: isMobile ? 48 : 88,
              ),
              SizedBox(width: isMobile ? 14 : 24),
              Text(
                '-',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              SizedBox(width: isMobile ? 14 : 24),
              _ScoreText(
                text: awayScore,
                color: _scoreColor(colors, isHome: false),
                fontSize: isMobile ? 48 : 88,
              ),
            ],
          ),
          _TeamColumn(
            name: away,
            crestSize: isMobile ? 56 : 80,
            width: isMobile ? 96 : 160,
          ),
        ],
      ),
    );
  }

  Color _scoreColor(ColorScheme colors, {required bool isHome}) {
    if (homeWinning == null) return colors.onSurface;
    final winning = isHome ? homeWinning! : !homeWinning!;
    return winning ? AppColor.success : colors.onSurface;
  }
}

class _ScoreText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  const _ScoreText({
    required this.text,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        letterSpacing: -2,
        height: 1,
      ),
    );
  }
}

class _TeamColumn extends StatelessWidget {
  final String name;
  final double crestSize;
  final double width;
  const _TeamColumn({
    required this.name,
    required this.crestSize,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          TeamCrest(size: crestSize),
          const SizedBox(height: AppSpacing.s8),
          Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
