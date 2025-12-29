import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core Colors - matching mobile app
  static const Color backgroundBlack = Color(0xFF0A0B0E);
  static const Color surfaceDark = Color(0xFF14161C);
  static const Color surfaceLight = Color(0xFF1C1E26);
  static const Color primaryGreen = Color(0xFF00FF94);
  static const Color secondaryBlue = Color(0xFF00E0FF);
  static const Color accentPurple = Color(0xFF9D4EDD);
  static const Color textWhite = Color(0xFFF0F2F5);
  static const Color textGrey = Color(0xFFA0AEC0);
  static const Color errorRed = Color(0xFFFF453A);
  static const Color successGreen = Color(0xFF30D158);
  static const Color warningOrange = Color(0xFFFF9F0A);

  // Glassmorphism Colors
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundBlack,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: secondaryBlue,
      tertiary: accentPurple,
      surface: surfaceDark,
      error: errorRed,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: textWhite,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: textWhite,
      displayColor: textWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textWhite),
    ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: glassBorder),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      hintStyle: TextStyle(color: textGrey.withValues(alpha: 0.5)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    dataTableTheme: DataTableThemeData(
      headingRowColor: WidgetStateProperty.all(surfaceLight),
      dataRowColor: WidgetStateProperty.all(Colors.transparent),
      dividerThickness: 0.5,
      headingTextStyle: const TextStyle(
        color: textGrey,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      dataTextStyle: const TextStyle(
        color: textWhite,
        fontSize: 14,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: glassBorder,
      thickness: 1,
    ),
  );
}
