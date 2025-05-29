import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color rustOrange = Color(0xFFBB3E00); // #BB3E00
  static const Color amber = Color(0xFFF7AD45); // #F7AD45
  static const Color navy = Color(0xFF332D56); // #332D56
  static const Color blue = Color(0xFF4E6688); // #4E6688

  // Common Assignments
  static const Color primaryColor = rustOrange;
  static const Color secondaryColor = amber;

  // Night Mode Colors
  static const Color nightBackgroundColor = navy;
  static const Color nightPrimaryColor = blue;

  // Sun Mode Colors
  static const Color sunBackgroundColor = Color(0xFFFFFFF5); // Light background
  static const Color sunPrimaryColor = rustOrange;

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double smallFontSize = 12.0;
  static const double buttonFontSize = 16.0;

  // Text Styles
  static TextStyle titleTextStyle = TextStyle(
    fontSize: titleFontSize,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle subtitleTextStyle = TextStyle(
    fontSize: subtitleFontSize,
    color: navy,
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: bodyFontSize,
    color: navy,
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: rustOrange,
      secondary: amber,
      tertiary: blue,
      surface: amber.withOpacity(0.3),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: rustOrange,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(buttonColor: rustOrange),
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
      shadowColor: blue.withOpacity(0.3),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: nightPrimaryColor,
    colorScheme: ColorScheme.dark(
      primary: nightPrimaryColor,
      secondary: rustOrange,
      tertiary: amber,
      surface: navy.withOpacity(0.2),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: nightPrimaryColor,
      foregroundColor: amber,
    ),
    buttonTheme: ButtonThemeData(buttonColor: nightPrimaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: rustOrange,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: titleTextStyle.copyWith(color: amber),
      titleMedium: subtitleTextStyle.copyWith(color: amber),
      bodyMedium: bodyTextStyle.copyWith(color: Colors.white),
    ),
    cardTheme: CardTheme(color: navy, shadowColor: blue.withOpacity(0.3)),
  );

  static const Color lightInputFillColor = Color(
    0xFFFFFFF5,
  ); // Using sunBackgroundColor
  static const Color darkInputFillColor = Color(0xFF332D56); // Using navy
}
