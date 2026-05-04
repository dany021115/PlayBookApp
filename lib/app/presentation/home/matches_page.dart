import 'package:flutter/material.dart';
import 'package:playbook/app/mock/matches_mock.dart';
import 'package:playbook/app/presentation/home/widgets/matches/live_matches_section.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_filter_chips.dart';
import 'package:playbook/app/presentation/home/widgets/matches/matches_top_bar.dart';
import 'package:playbook/app/presentation/home/widgets/matches/sport_tabs.dart';
import 'package:playbook/app/presentation/home/widgets/matches/upcoming_matches_section.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Mirrors Pencil:
///   * Mobile  `xN5ee` — 1-column stack
///   * Tablet  `mR4ge` — 2-column grid
///   * Desktop `gtE9B` — 3-column grid + bigger header
///
/// Sections compute their own column count from `LayoutBuilder` constraints,
/// so the page just provides a max-width container and inline `isMobile`
/// for the header chrome.
class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  int _filterIndex = 1;
  int _sportIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
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
                  child: MatchesTopBar(
                    greeting: MatchesMock.greeting,
                    title: MatchesMock.pageTitle,
                    compact: !isDesktop,
                  ),
                ),
                SliverToBoxAdapter(
                  child: MatchFilterChips(
                    activeIndex: _filterIndex,
                    liveCount: MatchesMock.liveCount,
                    onChanged: (i) => setState(() => _filterIndex = i),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SportTabs(
                    activeIndex: _sportIndex,
                    items: SportTabs.defaultItems,
                    onChanged: (i) => setState(() => _sportIndex = i),
                  ),
                ),
                const SliverToBoxAdapter(child: LiveMatchesSection()),
                const SliverToBoxAdapter(child: UpcomingMatchesSection()),
                SliverToBoxAdapter(
                    child: SizedBox(height: isMobile ? 100 : 48)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
