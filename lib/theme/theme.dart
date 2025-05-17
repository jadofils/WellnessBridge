import 'package:flutter/material.dart';

class AppTheme {
  // Your brand color palette
  static const Color rustOrange = Color(0xFFBB3E00); // #BB3E00
  static const Color amber = Color(0xFFF7AD45); // #F7AD45
  static const Color sage = Color(0xFF657C6A); // #657C6A
  static const Color mintGreen = Color(0xFFA2B9A7); // #A2B9A7

  // Common Colors - using your brand colors
  static const Color primaryColor = rustOrange;
  static const Color secondaryColor = amber;
  static const Color accentColor = sage;
  static const Color backgroundColor = mintGreen;

  // Night Mode Colors
  static const Color nightBackgroundColor = Color(0xFF121212);
  static const Color nightPrimaryColor =
      amber; // Using amber for night mode primary

  // Sun Mode Colors
  static const Color sunBackgroundColor = Color(
    0xFFFFFFF5,
  ); // Slight cream tint
  static const Color sunPrimaryColor = rustOrange;

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 14.0;

  // Button Colors
  static const Color buttonColor = rustOrange;
  static const Color buttonTextColor = Colors.white;

  // Text Styles
  static TextStyle titleTextStyle = TextStyle(
    fontSize: titleFontSize,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle subtitleTextStyle = TextStyle(
    fontSize: subtitleFontSize,
    color: sage, // Using sage for subtitles
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: bodyFontSize,
    color: sage, // Using sage for body text
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: rustOrange,
      secondary: amber,
      tertiary: sage,
      surface: mintGreen.withOpacity(0.3), // Lighter version for surfaces
      background: sunBackgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: rustOrange,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(buttonColor: buttonColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: rustOrange,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: titleTextStyle,
      titleMedium: subtitleTextStyle,
      bodyMedium: bodyTextStyle,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: sage.withOpacity(0.3),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor:
        amber, // Using amber as primary in dark mode for better contrast
    colorScheme: ColorScheme.dark(
      primary: amber,
      secondary: rustOrange,
      tertiary: mintGreen,
      surface: sage.withOpacity(0.2),
      background: nightBackgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: amber,
      foregroundColor: Colors.white, // Dark text on light background
    ),
    buttonTheme: ButtonThemeData(buttonColor: amber),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: amber,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: titleTextStyle.copyWith(color: amber),
      titleMedium: subtitleTextStyle.copyWith(color: mintGreen),
      bodyMedium: bodyTextStyle.copyWith(color: Colors.white),
    ),
    cardTheme: CardTheme(color: Color(0xFF1E1E1E), shadowColor: Colors.black),
  );
}
