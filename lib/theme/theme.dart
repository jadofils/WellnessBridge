import 'package:flutter/material.dart';

class AppTheme {
  // Common Colors
  static const Color primaryColor = Color(0xFF6200EE); // Example color
  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Night Mode Colors
  static const Color nightBackgroundColor = Color(0xFF121212);
  static const Color nightPrimaryColor = Color(0xFF6200EE);

  // Sun Mode Colors
  static const Color sunBackgroundColor = Color(0xFFFFFFFF);
  static const Color sunPrimaryColor = Color(0xFF2196F3);

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 14.0;

  // Button Colors
  static const Color buttonColor = Color(0xFF6200EE);
  static const Color buttonTextColor = Colors.white;

  // Text Styles
  static TextStyle titleTextStyle = TextStyle(
    fontSize: titleFontSize,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle subtitleTextStyle = TextStyle(
    fontSize: subtitleFontSize,
    color: primaryColor,
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: bodyFontSize,
    color: Colors.black,
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      background: backgroundColor, // Use `background` instead of `backgroundColor`
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
    ),
    textTheme: TextTheme(
      titleLarge: titleTextStyle, // Use `titleLarge` instead of `headline6`
      titleMedium: subtitleTextStyle, // Use `titleMedium` instead of `subtitle1`
      bodyMedium: bodyTextStyle, // Use `bodyMedium` instead of `bodyText2`
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: nightPrimaryColor,
    colorScheme: ColorScheme.dark(
      background: nightBackgroundColor, // Use `background` instead of `backgroundColor`
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
    ),
    textTheme: TextTheme(
      titleLarge: titleTextStyle.copyWith(color: Colors.white), // Use `titleLarge`
      titleMedium: subtitleTextStyle.copyWith(color: Colors.white), // Use `titleMedium`
      bodyMedium: bodyTextStyle.copyWith(color: Colors.white), // Use `bodyMedium`
    ),
  );
}