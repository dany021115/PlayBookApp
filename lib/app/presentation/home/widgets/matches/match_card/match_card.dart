import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/match_card_header.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_row.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_value.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/pick_pill.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/score_row.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Live-match card — header + score row + odds row + optional AI pick pill.
///
/// Mirrors Pencil `card1` (with pick) / `card2` (without pick).
class MatchCard extends StatelessWidget {
  final String league;
  final Color leagueColor;
  final String? liveMinute;
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;
  final List<OddsValue> odds;
  final String? pick;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.league,
    required this.leagueColor,
    this.liveMinute,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    this.homeWinning,
    required this.odds,
    this.pick,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.sheetBorder,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: AppRadius.sheetBorder,
            border: Border.all(
              // Live border = `#EF444433` per Pencil DeBNp (danger ~20% alpha).
              color: AppColor.danger.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MatchCardHeader(
                league: league,
                leagueColor: leagueColor,
                liveMinute: liveMinute,
              ),
              const SizedBox(height: AppSpacing.s12),
              ScoreRow(
                home: home,
                away: away,
                homeScore: homeScore,
                awayScore: awayScore,
                homeWinning: homeWinning,
              ),
              const SizedBox(height: AppSpacing.s12),
              OddsRow(values: odds),
              if (pick != null) ...[
                const SizedBox(height: AppSpacing.s12),
                PickPill(text: pick!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
