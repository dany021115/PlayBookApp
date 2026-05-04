import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Plain immutable structures for the Partido Detalle screen mocks.
///
/// Mirrors fields the future `MatchDetailEntity` will expose. Replace
/// with a `MatchDetailBloc` selector once the backend wire lands.
@immutable
class MockMatchDetail {
  final String league;
  final String home;
  final String away;
  final String homeScore;
  final String awayScore;
  final bool? homeWinning;
  final String liveLabel; // "EN VIVO · 67' 2T"

  // Pick card
  final String pickTitle;          // "Madrid 1X (Doble oportunidad) · 1.42"
  final String pickReasoning;      // long sentence
  final int pickConfidence;        // 0..100

  // Market groups (Resumen + Cuotas)
  final List<MockMarketGroup> markets;
  final int extraMarketsCount;     // "+24 mercados más →"
  final int bookmakerCount;        // "5 casas"

  // Cuotas tab — extras
  final List<MockOdd> handicap;            // Hándicap asiático
  final List<MockBookmakerOdds> bookmakers; // Mejores cuotas por casa

  // Live stats
  final List<MockStatRow> stats;
  final int homePossession;        // 0..100
  final int awayPossession;

  // Form
  final List<MockFormResult> homeForm;
  final List<MockFormResult> awayForm;

  // Alineación
  final String formation;          // "4-3-3 · vs · 4-3-3"
  final List<String> homeLineup;
  final List<String> awayLineup;
  final int homeBenchExtra;        // "+6 más"
  final int awayBenchExtra;

  // H2H
  final int h2hHomeWins;
  final int h2hDraws;
  final int h2hAwayWins;
  final List<MockH2HMatch> h2hRecent;

  const MockMatchDetail({
    required this.league,
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    this.homeWinning,
    required this.liveLabel,
    required this.pickTitle,
    required this.pickReasoning,
    required this.pickConfidence,
    required this.markets,
    required this.extraMarketsCount,
    required this.bookmakerCount,
    required this.handicap,
    required this.bookmakers,
    required this.stats,
    required this.homePossession,
    required this.awayPossession,
    required this.homeForm,
    required this.awayForm,
    required this.formation,
    required this.homeLineup,
    required this.awayLineup,
    required this.homeBenchExtra,
    required this.awayBenchExtra,
    required this.h2hHomeWins,
    required this.h2hDraws,
    required this.h2hAwayWins,
    required this.h2hRecent,
  });
}

@immutable
class MockBookmakerOdds {
  final String name;
  final String odds; // "1.85 · 3.40 · 4.20"
  final bool best;   // top row uses success color
  const MockBookmakerOdds({
    required this.name,
    required this.odds,
    this.best = false,
  });
}

@immutable
class MockH2HMatch {
  final String date;   // "21 OCT 23"
  final String result; // "Madrid 2 - 1 Barça"
  const MockH2HMatch({required this.date, required this.result});
}

@immutable
class MockMarketGroup {
  final String label; // "Resultado final (1X2)"
  final List<MockOdd> odds;
  const MockMarketGroup({required this.label, required this.odds});
}

@immutable
class MockOdd {
  final String label;       // "Madrid" / "Más 2.5" / "Sí"
  final String price;       // "1.85"
  final String? hint;       // "↑ Bet365" / "= Pinnacle" / "↓ Bwin" — null = no hint
  final bool? hintUp;       // true=success, false=danger, null=tertiary
  final bool selected;      // primary fill (BTTS Sí)
  const MockOdd({
    required this.label,
    required this.price,
    this.hint,
    this.hintUp,
    this.selected = false,
  });
}

@immutable
class MockStatRow {
  final String label;
  final String homeValue;
  final String awayValue;
  final bool homeHighlight; // green text for home (e.g. tiros al arco 6 vs 2)
  const MockStatRow({
    required this.label,
    required this.homeValue,
    required this.awayValue,
    this.homeHighlight = false,
  });
}

/// Result square colour: success (W) / warning (D) / danger (L).
enum MockFormResult { won, drew, lost }

extension MockFormResultColor on MockFormResult {
  Color get color {
    switch (this) {
      case MockFormResult.won:
        return AppColor.success;
      case MockFormResult.drew:
        return AppColor.warning;
      case MockFormResult.lost:
        return AppColor.danger;
    }
  }
}

class MatchDetailMock {
  MatchDetailMock._();

  static const MockMatchDetail sample = MockMatchDetail(
    league: 'LaLiga · J32',
    home: 'R. Madrid',
    away: 'Barça',
    homeScore: '2',
    awayScore: '1',
    homeWinning: true,
    liveLabel: "EN VIVO · 67' 2T",
    pickTitle: 'Madrid 1X (Doble oportunidad) · 1.42',
    pickReasoning:
        "Madrid 67' al frente, presión alta, xG 1.8 vs 0.6.",
    pickConfidence: 78,
    bookmakerCount: 5,
    extraMarketsCount: 24,
    markets: [
      MockMarketGroup(
        label: 'Resultado final (1X2)',
        odds: [
          MockOdd(
              label: 'Madrid',
              price: '1.85',
              hint: '↑ Bet365',
              hintUp: true),
          MockOdd(label: 'Empate', price: '3.40', hint: '= Pinnacle'),
          MockOdd(
              label: 'Barça', price: '4.20', hint: '↓ Bwin', hintUp: false),
        ],
      ),
      MockMarketGroup(
        label: 'Más de / Menos de 2.5 goles',
        odds: [
          MockOdd(label: 'Más 2.5', price: '1.55'),
          MockOdd(label: 'Menos 2.5', price: '2.40'),
        ],
      ),
      MockMarketGroup(
        label: 'Ambos equipos marcan',
        odds: [
          MockOdd(label: 'Sí', price: '1.72', selected: true),
          MockOdd(label: 'No', price: '2.10'),
        ],
      ),
    ],
    homePossession: 58,
    awayPossession: 42,
    stats: [
      MockStatRow(label: 'Tiros', homeValue: '14', awayValue: '7'),
      MockStatRow(
          label: 'Tiros al arco',
          homeValue: '6',
          awayValue: '2',
          homeHighlight: true),
      MockStatRow(label: 'xG', homeValue: '1.8', awayValue: '0.6'),
      MockStatRow(label: 'Córners', homeValue: '5', awayValue: '3'),
    ],
    homeForm: [
      MockFormResult.won,
      MockFormResult.won,
      MockFormResult.drew,
      MockFormResult.won,
      MockFormResult.lost,
    ],
    awayForm: [
      MockFormResult.drew,
      MockFormResult.lost,
      MockFormResult.won,
      MockFormResult.won,
      MockFormResult.drew,
    ],
    handicap: [
      MockOdd(label: 'Madrid -1.5', price: '2.30'),
      MockOdd(label: 'Empate -1.5', price: '3.10'),
      MockOdd(label: 'Barça +1.5', price: '1.62'),
    ],
    bookmakers: [
      MockBookmakerOdds(
          name: 'Bet365', odds: '1.85 · 3.40 · 4.20', best: true),
      MockBookmakerOdds(name: 'Codere', odds: '1.83 · 3.45 · 4.10'),
      MockBookmakerOdds(name: 'Bwin', odds: '1.80 · 3.50 · 4.00'),
    ],
    formation: '4-3-3 · vs · 4-3-3',
    homeLineup: [
      '1. Courtois',
      '2. Carvajal',
      '5. Bellingham',
      '7. Vinicius Jr',
      '9. Joselu',
    ],
    awayLineup: [
      '1. Ter Stegen',
      '3. Araújo',
      '8. Pedri',
      '10. Lewandowski',
      '11. Raphinha',
    ],
    homeBenchExtra: 6,
    awayBenchExtra: 6,
    h2hHomeWins: 5,
    h2hDraws: 2,
    h2hAwayWins: 3,
    h2hRecent: [
      MockH2HMatch(date: '21 OCT 23', result: 'Madrid 2 - 1 Barça'),
      MockH2HMatch(date: '15 ABR 23', result: 'Barça 2 - 1 Madrid'),
      MockH2HMatch(date: '19 MAR 23', result: 'Madrid 2 - 1 Barça'),
    ],
  );
}
