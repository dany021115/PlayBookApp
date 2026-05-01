import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playbook/device/theme/color.dart';

/// Pencil uses Inter as the design system font. We honor that on Android & web.
/// On iOS we return null so SF Pro is used (HIG compliance).
class AppTextStyle {
  static bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static String? get fontFamily =>
      _isIOS ? null : GoogleFonts.inter().fontFamily;

  final BuildContext context;

  AppTextStyle(this.context);

  TextTheme get textTheme => Theme.of(context).textTheme;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  // ─── DISPLAY / HEADINGS ───

  /// Auth main title — 22/800 (mobile). Used in "Iniciar sesión", "Crear cuenta".
  TextStyle? get authTitle => textTheme.headlineLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: 22,
        letterSpacing: -0.4,
        height: 1.2,
      );

  /// Auth subtitle — 13 secondary, used under authTitle.
  TextStyle? get authSubtitle => textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
        fontSize: 13,
        height: 1.4,
      );

  /// "Picks deportivos con IA" hero on Splash mobile — 28/800 white.
  TextStyle? get heroTitle => textTheme.displayMedium?.copyWith(
        color: AppColor.onPrimary,
        fontWeight: FontWeight.w800,
        fontSize: 28,
        letterSpacing: -1.0,
        height: 1.1,
      );

  /// Hero supporting text — 14 white at 80%.
  TextStyle? get heroSubtitle => textTheme.bodyMedium?.copyWith(
        color: AppColor.onPrimary.withValues(alpha: 0.8),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.5,
      );

  /// Generic page title — 22/800 (used in headers).
  TextStyle? get pageTitle => textTheme.headlineLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: 22,
        letterSpacing: -0.4,
        height: 1.2,
      );

  TextStyle? get sectionTitle => textTheme.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 1.3,
      );

  TextStyle? get cardTitle => textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 1.4,
      );

  // ─── BODY ───

  TextStyle? get bodyText => textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.5,
      );

  TextStyle? get bodySecondary => textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
        fontSize: 13,
        height: 1.4,
      );

  // ─── FORM ───

  /// Input label — 12/600 secondary (Pencil Component/Input/Text `inpLabel`).
  TextStyle? get formLabel => textTheme.titleSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        height: 1.2,
      );

  /// Placeholder — 14 tertiary (`inpPlaceholder`).
  TextStyle? get formHint => textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );

  /// Input value — 14 primary text.
  TextStyle? get formField => textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  TextStyle? get formError => textTheme.bodySmall?.copyWith(
        color: AppColor.danger,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );

  // ─── BUTTONS / LINKS ───

  /// Primary CTA label — 14/600 white (Component/Button/Primary).
  TextStyle? get buttonPrimary => textTheme.labelLarge?.copyWith(
        color: AppColor.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  /// Outlined / text button label — 14/600 primary.
  TextStyle? get buttonSecondary => textTheme.labelLarge?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  /// "¿Olvidaste tu contraseña?" — 12/600 primary right aligned.
  TextStyle? get authLink => textTheme.titleSmall?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );

  /// Foot link — 13/800 primary ("Crear cuenta" / "Iniciar sesión").
  TextStyle? get authFootLink => textTheme.bodySmall?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w800,
        fontSize: 13,
      );

  /// Foot prompt — 13/400 secondary ("¿No tienes cuenta?").
  TextStyle? get authFootPrompt => textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      );

  // ─── STATUS / BADGES ───

  TextStyle? get statusSuccess => textTheme.labelMedium?.copyWith(
        color: AppColor.success,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  TextStyle? get statusWarning => textTheme.labelMedium?.copyWith(
        color: AppColor.warning,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  TextStyle? get statusError => textTheme.labelMedium?.copyWith(
        color: AppColor.danger,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  TextStyle? get statusLive => textTheme.labelMedium?.copyWith(
        color: AppColor.danger,
        fontWeight: FontWeight.w700,
        fontSize: 12,
        letterSpacing: 0.5,
      );

  // ─── ODDS / SCORES (tabular) ───

  TextStyle? get scoreLarge => textTheme.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: 28,
        height: 1.0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  TextStyle? get oddsPrice => textTheme.titleMedium?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // ─── NAV ───

  TextStyle? get navActive => textTheme.labelMedium?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );

  TextStyle? get navInactive => textTheme.labelMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  // ─── MISC ───

  TextStyle? get caption => textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
        fontSize: 11,
      );

  TextStyle? get chipLabel => textTheme.labelMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
}
