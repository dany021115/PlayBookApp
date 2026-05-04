import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_row.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_value.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/team_crest.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';

/// Pre-match card — league + time, home/vs/away, odds row.
///
/// Mirrors Pencil `up1`.
class UpcomingCard extends StatelessWidget {
  final String league;
  final Color leagueColor;
  final String time;
  final String home;
  final String away;
  final List<String> odds;
  final VoidCallback? onTap;

  const UpcomingCard({
    super.key,
    required this.league,
    required this.leagueColor,
    required this.time,
    required this.home,
    required this.away,
    required this.odds,
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
            // Scheduled card = `$bg/surface` with NO border per Pencil XiKrS.
            color: colors.surfaceContainer,
            borderRadius: AppRadius.sheetBorder,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LeagueAndTime(
                  league: league, leagueColor: leagueColor, time: time),
              const SizedBox(height: AppSpacing.s8),
              _TeamsRow(home: home, away: away),
              const SizedBox(height: AppSpacing.s12),
              OddsRow(
                values: [
                  for (final o in odds)
                    OddsValue(label: o, price: '', delta: ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeagueAndTime extends StatelessWidget {
  final String league;
  final Color leagueColor;
  final String time;
  const _LeagueAndTime({
    required this.league,
    required this.leagueColor,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: leagueColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  league,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TeamsRow extends StatelessWidget {
  final String home;
  final String away;
  const _TeamsRow({required this.home, required this.away});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final nameStyle = TextStyle(
      color: colors.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TeamCrest(size: 28),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  home,
                  overflow: TextOverflow.ellipsis,
                  style: nameStyle,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'vs',
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  away,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: nameStyle,
                ),
              ),
              const SizedBox(width: 10),
              const TeamCrest(size: 28),
            ],
          ),
        ),
      ],
    );
  }
}
