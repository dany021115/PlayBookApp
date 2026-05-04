import 'package:flutter/material.dart';
import 'package:playbook/app/presentation/home/widgets/matches/match_card/odds_value.dart';
import 'package:playbook/device/theme/color.dart';

/// Plain immutable record for a live match. Shape mirrors what a future
/// `MatchEntity` from `domain/entities/match.dart` will look like, so
/// replacing this with real data is a one-line change in the consumer.
@immutable
class MockLiveMatch {
  final String id;
  final String league;
  final Color leagueColor;
  final String liveMinute;
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;
  final List<OddsValue> odds;
  final String? pick;

  const MockLiveMatch({
    required this.id,
    required this.league,
    required this.leagueColor,
    required this.liveMinute,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    this.homeWinning,
    required this.odds,
    this.pick,
  });
}

@immutable
class MockUpcomingMatch {
  final String id;
  final String league;
  final Color leagueColor;
  final String time;
  final String home;
  final String away;
  final List<String> odds;

  const MockUpcomingMatch({
    required this.id,
    required this.league,
    required this.leagueColor,
    required this.time,
    required this.home,
    required this.away,
    required this.odds,
  });
}

/// Single source of truth for static match mocks rendered on the
/// Inicio (Partidos) screen.
///
/// Replace each list / scalar below with state from `MatchesBloc` once the
/// `/api/v1/markets/matches` wiring lands. The widgets that consume these
/// already accept the same fields, so the swap is a one-line change in
/// the section widgets.
class MatchesMock {
  MatchesMock._();

  // ─── Header ────────────────────────────────────────────────────
  static const String greeting = 'Hola, Juan 👋';
  static const String pageTitle = 'Partidos de hoy';

  // ─── Filter chips ──────────────────────────────────────────────
  static const int liveCount = 12;

  // ─── Live ──────────────────────────────────────────────────────
  static const List<MockLiveMatch> live = [
    MockLiveMatch(
      id: 'live-1',
      league: 'LaLiga · J32',
      leagueColor: AppColor.primary,
      liveMinute: "67'",
      home: 'R. Madrid',
      away: 'Barça',
      homeScore: '2',
      awayScore: '1',
      homeWinning: true,
      odds: [
        OddsValue(label: '1', price: '1.85', delta: '↑0.05', up: true),
        OddsValue(label: 'X', price: '3.40', delta: '='),
        OddsValue(label: '2', price: '4.20', delta: '↓0.10', up: false),
      ],
      pick: 'Pick: Madrid 1X · Confianza 78%',
    ),
    MockLiveMatch(
      id: 'live-2',
      league: 'Premier · J33',
      leagueColor: AppColor.success,
      liveMinute: "23'",
      home: 'Liverpool',
      away: 'Arsenal',
      homeScore: '0',
      awayScore: '0',
      odds: [
        OddsValue(label: '1 · 2.30', price: '', delta: ''),
        OddsValue(label: 'X · 3.10', price: '', delta: '', selected: true),
        OddsValue(label: '2 · 3.40', price: '', delta: ''),
      ],
    ),
  ];

  // ─── Upcoming / pre-match ──────────────────────────────────────
  static const List<MockUpcomingMatch> upcoming = [
    MockUpcomingMatch(
      id: 'up-1',
      league: 'Champions · Cuartos',
      leagueColor: AppColor.warning,
      time: '21:00',
      home: 'Bayern',
      away: 'PSG',
      odds: ['1 · 2.05', 'X · 3.55', '2 · 3.60'],
    ),
  ];
}
