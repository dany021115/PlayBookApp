import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/mock/matches_mock.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/upcoming_card.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/section_header.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';

/// "Próximos · pre-match" section. See [LiveMatchesSection] for layout
/// strategy — column count comes from the section's actual width.
class UpcomingMatchesSection extends StatelessWidget {
  const UpcomingMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = MatchesMock.upcoming;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16, 0, AppSpacing.s16, AppSpacing.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            leading: Icon(Icons.timer_outlined,
                size: 14, color: AppColor.muted),
            title: 'Próximos · pre-match',
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
                      child: UpcomingCard(
                        league: m.league,
                        leagueColor: m.leagueColor,
                        time: m.time,
                        home: m.home,
                        away: m.away,
                        odds: m.odds,
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
