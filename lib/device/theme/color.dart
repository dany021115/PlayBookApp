import 'package:flutter/material.dart';

/// PlayBook design tokens — sourced from `PlayBook.pen` (`get_variables`).
/// Variables that have light/dark variants are exposed as `xxxDark` / `xxxLight`.
abstract class AppColor {
  AppColor._();

  // === BRAND (theme-agnostic) ===
  /// $primary — `#6366F1`
  static const Color primary = Color(0xFF6366F1);

  /// $primary/hover — `#4F46E5`
  static const Color primaryHover = Color(0xFF4F46E5);

  // === BACKGROUNDS (theme-aware) ===
  /// $bg/canvas — `#0F172A` dark / `#F8FAFC` light
  static const Color bgCanvasDark = Color(0xFF0F172A);
  static const Color bgCanvasLight = Color(0xFFF8FAFC);

  /// $bg/surface — `#1E293B` dark / `#FFFFFF` light
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// $bg/surface-elevated — `#334155` dark / `#F1F5F9` light
  static const Color surfaceElevatedDark = Color(0xFF334155);
  static const Color surfaceElevatedLight = Color(0xFFF1F5F9);

  /// $border — `#334155` dark / `#E2E8F0` light
  static const Color borderDark = Color(0xFF334155);
  static const Color borderLight = Color(0xFFE2E8F0);

  // === TEXT (theme-aware) ===
  /// $text/primary — `#F1F5F9` dark / `#0F172A` light
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textPrimaryLight = Color(0xFF0F172A);

  /// $text/secondary — `#94A3B8` dark / `#64748B` light
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textSecondaryLight = Color(0xFF64748B);

  /// $text/tertiary — `#64748B` dark / `#94A3B8` light
  static const Color textTertiaryDark = Color(0xFF64748B);
  static const Color textTertiaryLight = Color(0xFF94A3B8);

  // === STATUS (theme-agnostic) ===
  /// $success — `#22C55E`
  static const Color success = Color(0xFF22C55E);

  /// $danger — `#EF4444`
  static const Color danger = Color(0xFFEF4444);

  /// $warning — `#F59E0B`
  static const Color warning = Color(0xFFF59E0B);

  /// $info — `#38BDF8`
  static const Color info = Color(0xFF38BDF8);

  /// $muted — `#64748B`
  static const Color muted = Color(0xFF64748B);

  // === DERIVED ===
  /// White text on primary/danger surfaces.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Brand gradient — left/hero panels (primary → primary/hover).
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryHover],
  );

  /// Hero backdrop on Login screen — surface → canvas.
  static const LinearGradient heroDarkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [surfaceDark, bgCanvasDark],
  );

  // === PREDICTION OUTCOMES (re-using status palette) ===
  static const Color predictionWon = success;
  static const Color predictionLost = danger;
  static const Color predictionPending = warning;
  static const Color predictionVoid = muted;

  // === SOCIAL ===
  static const Color googleBlue = Color(0xFF4285F4);
}
