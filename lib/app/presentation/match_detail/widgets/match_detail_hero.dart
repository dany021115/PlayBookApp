import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/match_detail/widgets/match_detail_score_row.dart';
import 'package:playbook/app/presentation/match_detail/widgets/match_detail_top_bar.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Hero band: gradient surface→canvas, top bar (back/league/save),
/// live badge, big score row.
///
/// Mirrors Pencil `Bfk1O / mdHero` (mobile) and `yXEUn` (desktop bigger).
/// `isMobile` is supplied by the parent page.
class MatchDetailHero extends StatelessWidget {
  final String league;
  final String liveLabel;
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;
  final bool isMobile;
  final VoidCallback? onBack;
  final VoidCallback? onSave;

  const MatchDetailHero({
    super.key,
    required this.league,
    required this.liveLabel,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    required this.isMobile,
    this.homeWinning,
    this.onBack,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isMobile ? AppSpacing.s16 : AppSpacing.s32,
        isMobile ? AppSpacing.s12 : AppSpacing.s24,
        isMobile ? AppSpacing.s16 : AppSpacing.s32,
        isMobile ? 20 : AppSpacing.s32,
      ),
      decoration: const BoxDecoration(gradient: AppColor.heroDarkGradient),
      child: Column(
        children: [
          MatchDetailTopBar(league: league, onBack: onBack, onSave: onSave),
          SizedBox(height: isMobile ? 14 : 24),
          _LiveBadge(label: liveLabel),
          SizedBox(height: isMobile ? 14 : 24),
          MatchDetailScoreRow(
            home: home,
            away: away,
            homeScore: homeScore,
            awayScore: awayScore,
            homeWinning: homeWinning,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }
}


class _LiveBadge extends StatelessWidget {
  final String label;
  const _LiveBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
      height: 24,
      decoration: BoxDecoration(
        color: AppColor.danger,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColor.onPrimary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColor.onPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
