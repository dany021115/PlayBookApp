import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/mock/matches_mock.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/match_card.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/section_header.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "En vivo ahora" section — column count comes from the section's actual
/// rendered width (not the screen size), so the cards always have a sane
/// width regardless of sidebar / max-width constraints.
class LiveMatchesSection extends StatelessWidget {
  const LiveMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = MatchesMock.live;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16, AppSpacing.s8, AppSpacing.s16, AppSpacing.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            leading: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColor.danger,
                shape: BoxShape.circle,
              ),
            ),
            title: 'En vivo ahora',
          ),
          const SizedBox(height: AppSpacing.s8),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.s12;
              final w = constraints.maxWidth;
              final cols = w >= 900 ? 3 : (w >= 520 ? 2 : 1);
              final cardWidth = (w - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final m in matches)
                    SizedBox(
                      width: cardWidth,
                      child: MatchCard(
                        league: m.league,
                        leagueColor: m.leagueColor,
                        liveMinute: m.liveMinute,
                        home: m.home,
                        away: m.away,
                        homeScore: m.homeScore,
                        awayScore: m.awayScore,
                        homeWinning: m.homeWinning,
                        odds: m.odds,
                        pick: m.pick,
                        onTap: () => context.pushNamed(
                          AppRoute.matchDetail.name,
                          pathParameters: {'id': m.id},
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
