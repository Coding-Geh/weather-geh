import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF5B9FE3);
  static const Color secondaryColor = Color(0xFFFFB347);
  static const Color sunnyColor = Color(0xFFFFD93D);
  static const Color rainyColor = Color(0xFF6B7B8C);
  static const Color nightColor = Color(0xFF1A1A2E);
  static const Color cloudyColor = Color(0xFF87CEEB);

  static const LinearGradient sunnyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF87CEEB), Color(0xFF5B9FE3), Color(0xFF4A8FD3)],
  );

  static const LinearGradient nightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
  );

  static const LinearGradient cloudyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF8E9EAB), Color(0xFFEEF2F3), Color(0xFFD5DEE7)],
  );

  static const LinearGradient rainyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF373B44), Color(0xFF4286f4), Color(0xFF373B44)],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFF512F), Color(0xFFDD2476), Color(0xFF7B4397)],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIconColor: Colors.white.withOpacity(0.7),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Color(0xFF1E1E2E),
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIconColor: Colors.white.withOpacity(0.5),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  static LinearGradient getWeatherGradient(String condition, {bool isNight = false}) {
    if (isNight) return nightGradient;
    
    switch (condition.toLowerCase()) {
      case 'clear':
        return sunnyGradient;
      case 'clouds':
        return cloudyGradient;
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return rainyGradient;
      default:
        return sunnyGradient;
    }
  }
}
