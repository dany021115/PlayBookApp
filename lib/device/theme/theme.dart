import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getLightTheme() => _build(Brightness.light);
  static ThemeData getDarkTheme() => _build(Brightness.dark);

  // === COLOR SCHEME (Pencil tokens) ===

  static ColorScheme _scheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final canvas = isDark ? AppColor.bgCanvasDark : AppColor.bgCanvasLight;
    final surface = isDark ? AppColor.surfaceDark : AppColor.surfaceLight;
    final surfaceElevated =
        isDark ? AppColor.surfaceElevatedDark : AppColor.surfaceElevatedLight;
    final border = isDark ? AppColor.borderDark : AppColor.borderLight;
    final textPrimary =
        isDark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight;
    final textSecondary =
        isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight;
    final textTertiary =
        isDark ? AppColor.textTertiaryDark : AppColor.textTertiaryLight;

    return ColorScheme(
      brightness: brightness,
      primary: AppColor.primary,
      onPrimary: AppColor.onPrimary,
      secondary: AppColor.primaryHover,
      onSecondary: AppColor.onPrimary,
      tertiary: AppColor.info,
      onTertiary: AppColor.onPrimary,
      error: AppColor.danger,
      onError: AppColor.onPrimary,
      surface: canvas,
      onSurface: textPrimary,
      surfaceContainer: surface,
      surfaceContainerHigh: surfaceElevated,
      surfaceContainerHighest: surfaceElevated,
      onSurfaceVariant: textSecondary,
      primaryContainer: AppColor.primaryHover,
      onPrimaryContainer: AppColor.onPrimary,
      secondaryContainer: surfaceElevated,
      onSecondaryContainer: textPrimary,
      tertiaryContainer: surfaceElevated,
      onTertiaryContainer: textTertiary,
      errorContainer: AppColor.danger.withValues(alpha: 0.15),
      onErrorContainer: AppColor.danger,
      outline: border,
      outlineVariant: border.withValues(alpha: 0.5),
      shadow: Colors.black.withValues(alpha: 0.1),
      scrim: Colors.black.withValues(alpha: 0.5),
      inverseSurface: isDark ? AppColor.bgCanvasLight : AppColor.bgCanvasDark,
      onInverseSurface: isDark ? AppColor.textPrimaryLight : AppColor.textPrimaryDark,
      inversePrimary:
          isDark ? AppColor.primary.withValues(alpha: 0.8) : AppColor.primary,
    );
  }

  // === COMPONENT THEMES ===

  static AppBarTheme get _appBarTheme => const AppBarTheme(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
      );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme c) =>
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardBorder,
          borderSide: BorderSide(color: c.outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardBorder,
          borderSide: BorderSide(color: c.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardBorder,
          borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardBorder,
          borderSide: const BorderSide(color: AppColor.danger, width: 1.5),
        ),
        filled: true,
        fillColor: c.surfaceContainer,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            color: c.onSurfaceVariant,
            fontSize: 14),
        hintStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            color: c.onSurfaceVariant.withValues(alpha: 0.6),
            fontSize: 14),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0 : 2,
          shadowColor: Colors.black.withValues(alpha: 0.15),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
          textStyle: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      );

  static FilledButtonThemeData _filledButtonTheme() => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.onPrimary,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
          textStyle: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primary,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
          side: const BorderSide(color: AppColor.primary, width: 1.5),
          textStyle: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      );

  static TextButtonThemeData _textButtonTheme() => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
          textStyle: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      );

  static CardThemeData _cardTheme(ColorScheme c) => CardThemeData(
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0 : 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
        margin: const EdgeInsets.all(8),
        color: c.surfaceContainer,
      );

  static FloatingActionButtonThemeData _fabTheme(ColorScheme c) =>
      FloatingActionButtonThemeData(
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0 : 6,
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
      );

  static BottomNavigationBarThemeData _bottomNavTheme(ColorScheme c) =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0 : 8,
        backgroundColor: c.surfaceContainer,
        selectedItemColor: c.primary,
        unselectedItemColor: c.onSurfaceVariant,
        selectedLabelStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      );

  static TextTheme get _textTheme => TextTheme(
        displayLarge: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8),
        displayMedium: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6),
        displaySmall: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6),
        headlineLarge: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4),
        headlineMedium: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700),
        titleLarge: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        titleSmall: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        labelMedium: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        labelSmall: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 11,
            fontWeight: FontWeight.w600),
      );

  // === BUILDER ===

  static ThemeData _build(Brightness brightness) {
    final c = _scheme(brightness);
    return ThemeData(
      brightness: brightness,
      fontFamily: AppTextStyle.fontFamily,
      useMaterial3: true,
      colorScheme: c,
      textTheme: _textTheme.apply(
        bodyColor: c.onSurface,
        displayColor: c.onSurface,
      ),
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: c.surface,
        foregroundColor: c.onSurface,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            color: c.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4),
      ),
      inputDecorationTheme: _inputDecorationTheme(c),
      elevatedButtonTheme: _elevatedButtonTheme(),
      filledButtonTheme: _filledButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      cardTheme: _cardTheme(c),
      floatingActionButtonTheme: _fabTheme(c),
      bottomNavigationBarTheme: _bottomNavTheme(c),
      dividerTheme: DividerThemeData(
          color: c.outline.withValues(alpha: 0.6), thickness: 1),
      scaffoldBackgroundColor: c.surface,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
    );
  }
}
