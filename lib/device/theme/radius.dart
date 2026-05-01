import 'package:flutter/material.dart';

/// Mirrors Pencil radius tokens.
class AppRadius {
  AppRadius._();

  /// $radius-small — 8
  static const double small = 8;

  /// $radius-card — 12
  static const double card = 12;

  /// $radius-sheet — 16
  static const double sheet = 16;

  /// $radius-pill — 9999
  static const double pill = 9999;

  static final BorderRadius smallBorder = BorderRadius.circular(small);
  static final BorderRadius cardBorder = BorderRadius.circular(card);
  static final BorderRadius sheetBorder = BorderRadius.circular(sheet);
  static final BorderRadius pillBorder = BorderRadius.circular(pill);

  // Compatibility aliases (legacy names used in earlier widgets).
  static const double xs = small;
  static const double sm = small;
  static const double md = card;
  static const double lg = sheet;
  static const double xl = 20;

  static final BorderRadius xsBorder = smallBorder;
  static final BorderRadius smBorder = smallBorder;
  static final BorderRadius mdBorder = cardBorder;
  static final BorderRadius lgBorder = sheetBorder;
  static final BorderRadius xlBorder = BorderRadius.circular(xl);
}
