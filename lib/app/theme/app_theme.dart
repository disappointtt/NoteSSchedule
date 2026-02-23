import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF7C5CFF);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentOrange = Color(0xFFFF9500);
  static const Color accentBlue = Color(0xFF6CBAFF);
  static const Color bgLight = Color(0xFFFAFBFC);
  static const Color bgCard = Colors.white;
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF718096);
  static const Color borderLight = Color(0xFFE2E8F0);

  static ThemeData lightTheme(double fontScale) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      appBarTheme: AppBarTheme(
        backgroundColor: bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: textPrimary,
        titleTextStyle: TextStyle(
          fontSize: 18 * fontScale,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16 * fontScale,
          color: textPrimary,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14 * fontScale,
          color: textSecondary,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 20 * fontScale,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16 * fontScale,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryPurple,
        secondary: accentGreen,
        tertiary: accentOrange,
        surface: bgCard,
        onSurface: textPrimary,
        onPrimary: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: TextStyle(
            fontSize: 16 * fontScale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(primaryPurple),
      ),
    );
  }

  static ThemeData darkTheme(double fontScale) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 18 * fontScale,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16 * fontScale,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14 * fontScale,
          color: Colors.grey[400],
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 20 * fontScale,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16 * fontScale,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryPurple,
        secondary: accentGreen,
        tertiary: accentOrange,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: TextStyle(
            fontSize: 16 * fontScale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(primaryPurple),
      ),
    );
  }
}
