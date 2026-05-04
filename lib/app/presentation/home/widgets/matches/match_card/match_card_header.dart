import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/live_minute_badge.dart';

/// League dot + name on the left, optional [LiveMinuteBadge] on the right.
class MatchCardHeader extends StatelessWidget {
  final String league;
  final Color leagueColor;
  final String? liveMinute;

  const MatchCardHeader({
    super.key,
    required this.league,
    required this.leagueColor,
    this.liveMinute,
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
        if (liveMinute != null) ...[
          const SizedBox(width: 8),
          LiveMinuteBadge(minute: liveMinute!),
        ],
      ],
    );
  }
}
