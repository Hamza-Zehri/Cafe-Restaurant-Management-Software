// ═══════════════════════════════════════════════════════
// APP THEME — Material Design 3 dark & light
// ═══════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Status colors (constant across themes)
class AppColors {
  static const tableAvailable    = Color(0xFF16A34A);
  static const tableOccupied     = Color(0xFFDC2626);
  static const tableReserved     = Color(0xFF7C3AED);
  static const tableCleaning     = Color(0xFFD97706);

  static const orderOpen         = Color(0xFF2563EB);
  static const orderKitchen      = Color(0xFFD97706);
  static const orderReady        = Color(0xFF16A34A);
  static const orderPaid         = Color(0xFF6B7280);

  static const success           = Color(0xFF16A34A);
  static const warning           = Color(0xFFD97706);
  static const error             = Color(0xFFDC2626);
  static const info              = Color(0xFF2563EB);

  static const darkBg            = Color(0xFF0F172A);
  static const darkCard          = Color(0xFF1E293B);
  static const darkCardElevated  = Color(0xFF263348);
  static const darkBorder        = Color(0xFF334155);

  static const lightBg           = Color(0xFFF8FAFC);
  static const lightCard         = Color(0xFFFFFFFF);
  static const lightBorder       = Color(0xFFE2E8F0);
}

class AppTheme {
  static ThemeData dark() => _build(Brightness.dark);
  static ThemeData light() => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primary = isDark ? const Color(0xFF60A5FA) : const Color(0xFF1A56DB);

    final cs = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      surface: isDark ? AppColors.darkBg : AppColors.lightBg,
    ).copyWith(
      surfaceContainerHighest: isDark ? AppColors.darkCard : AppColors.lightCard,
      surfaceContainer: isDark ? AppColors.darkCardElevated : const Color(0xFFF1F5F9),
    );

    final txt = GoogleFonts.interTextTheme(ThemeData(brightness: brightness).textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: cs,
      textTheme: txt,
      scaffoldBackgroundColor: cs.surface,

      appBarTheme: AppBarTheme(
        elevation: 0, scrolledUnderElevation: 0.5,
        backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
        foregroundColor: cs.onSurface,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18, fontWeight: FontWeight.w700, color: cs.onSurface,
        ),
        shape: Border(bottom: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder, width: 0.5,
        )),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, width: 0.5),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1A2332) : const Color(0xFFF1F5F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
        hintStyle: TextStyle(color: cs.onSurfaceVariant.withAlpha(130), fontSize: 13),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        thickness: 0.5, space: 0.5,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: isDark ? AppColors.darkCardElevated : const Color(0xFF1E293B),
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 13),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, width: 0.5),
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}

// Extensions for quick color access in widgets
extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get cs => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get cardBg => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get border => isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get bg => isDark ? AppColors.darkBg : AppColors.lightBg;
  Color get elevated => isDark ? AppColors.darkCardElevated : const Color(0xFFF1F5F9);
  TextTheme get tt => Theme.of(this).textTheme;
}
