import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundBlack = Color(0xFF101116); // Gunmetal Black
  static const Color surfaceDark = Color(0xFF1C1E26); // Darker Surface
  static const Color primaryGreen = Color(0xFF00FF94); // Neon Green
  static const Color secondaryBlue = Color(0xFF00E0FF); // Cyber Blue
  static const Color textWhite = Color(0xFFF0F2F5);
  static const Color textGrey = Color(0xFFA0AEC0);
  static const Color errorRed = Color(0xFFFF453A);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundBlack,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: secondaryBlue,
      surface: surfaceDark,
      background: backgroundBlack,
      error: errorRed,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: textWhite,
      onBackground: textWhite,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: textWhite,
      displayColor: textWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textWhite),
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
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen),
      ),
      hintStyle: TextStyle(color: textGrey.withOpacity(0.5)),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryGreen,
      inactiveTrackColor: surfaceDark,
      thumbColor: textWhite,
      trackHeight: 4,
      overlayColor: primaryGreen.withOpacity(0.2),
    ),
  );
}
