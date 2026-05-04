import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/mock/match_detail_mock.dart';
import 'package:playbook/app/presentation/match_detail/widgets/bookmaker_odds_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/form_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/h2h_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/handicap_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/lineups_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/live_stats_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/markets_section.dart';
import 'package:playbook/app/presentation/match_detail/widgets/match_detail_hero.dart';
import 'package:playbook/app/presentation/match_detail/widgets/match_detail_tabs.dart';
import 'package:playbook/app/presentation/match_detail/widgets/pick_card.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Mirrors Pencil match-detail variants:
///   * Mobile  `BZlUL` (Resumen) / `GyMwC` (Cuotas) / `EaMJ3` (Alineaciones)
///     / `t0r52` (H2H)
///   * Desktop `yXEUn`
///
/// Layout: same widget instances rendered in either Column (mobile / tablet)
/// or Row(main 2/3, sidebar 1/3) (desktop). Tab switch picks the widget
/// list — no duplicated tree.
class MatchDetailPage extends StatefulWidget {
  final String? matchId;
  const MatchDetailPage({super.key, this.matchId});

  @override
  State<MatchDetailPage> createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  int _activeTab = 0;

  /// Returns `(main, sidebar)` widget lists for the active tab. On mobile
  /// they render stacked; on desktop main goes left, sidebar right.
  ({List<Widget> main, List<Widget> sidebar}) _tabContent(
      MockMatchDetail m) {
    switch (_activeTab) {
      case 1: // Cuotas
        return (
          main: [
            PickCard(
              title: m.pickTitle,
              reasoning: m.pickReasoning,
              confidence: m.pickConfidence,
            ),
            const SizedBox(height: 14),
            MarketsSection(
              markets: m.markets,
              bookmakerCount: m.bookmakerCount,
              extraCount: m.extraMarketsCount,
            ),
          ],
          sidebar: [
            HandicapSection(handicap: m.handicap),
            const SizedBox(height: 14),
            BookmakerOddsSection(rows: m.bookmakers),
          ],
        );
      case 2: // Stats
        return (
          main: [
            LiveStatsSection(
              homePossession: m.homePossession,
              awayPossession: m.awayPossession,
              stats: m.stats,
            ),
          ],
          sidebar: [
            FormSection(
              home: m.home,
              away: m.away,
              homeForm: m.homeForm,
              awayForm: m.awayForm,
            ),
          ],
        );
      case 3: // Alineación
        return (
          main: [
            LineupsSection(
              formation: m.formation,
              homeName: m.home,
              awayName: m.away,
              homeLineup: m.homeLineup,
              awayLineup: m.awayLineup,
              homeBenchExtra: m.homeBenchExtra,
              awayBenchExtra: m.awayBenchExtra,
            ),
          ],
          sidebar: const <Widget>[],
        );
      case 4: // H2H
        return (
          main: [
            H2HSection(
              homeName: m.home,
              awayName: m.away,
              homeWins: m.h2hHomeWins,
              draws: m.h2hDraws,
              awayWins: m.h2hAwayWins,
              recent: m.h2hRecent,
            ),
          ],
          sidebar: const <Widget>[],
        );
      default: // 0 Resumen
        return (
          main: [
            PickCard(
              title: m.pickTitle,
              reasoning: m.pickReasoning,
              confidence: m.pickConfidence,
            ),
            const SizedBox(height: 14),
            MarketsSection(
              markets: m.markets,
              bookmakerCount: m.bookmakerCount,
              extraCount: m.extraMarketsCount,
            ),
          ],
          sidebar: [
            LiveStatsSection(
              homePossession: m.homePossession,
              awayPossession: m.awayPossession,
              stats: m.stats,
            ),
            const SizedBox(height: 14),
            FormSection(
              home: m.home,
              away: m.away,
              homeForm: m.homeForm,
              awayForm: m.awayForm,
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = MatchDetailMock.sample;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
    final content = _tabContent(m);
    final hasSidebar = content.sidebar.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 1280 : double.infinity,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MatchDetailHero(
                    league: m.league,
                    liveLabel: m.liveLabel,
                    home: m.home,
                    away: m.away,
                    homeScore: m.homeScore,
                    awayScore: m.awayScore,
                    homeWinning: m.homeWinning,
                    isMobile: isMobile,
                    onBack: () => context.pop(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: MatchDetailTabs(
                    activeIndex: _activeTab,
                    labels: MatchDetailTabs.defaultLabels,
                    onChanged: (i) => setState(() => _activeTab = i),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? AppSpacing.s16 : AppSpacing.s32,
                    AppSpacing.s16,
                    isMobile ? AppSpacing.s16 : AppSpacing.s32,
                    isMobile ? 100 : 48,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: isDesktop && hasSidebar
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(children: content.main)),
                              const SizedBox(width: AppSpacing.s24),
                              Expanded(
                                  flex: 1,
                                  child: Column(children: content.sidebar)),
                            ],
                          )
                        : Column(
                            children: [
                              ...content.main,
                              if (hasSidebar) const SizedBox(height: 14),
                              ...content.sidebar,
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
