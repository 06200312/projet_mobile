import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF7C3AED),
      secondary: Color(0xFF10B981),
      surface: Colors.white,
      background: Color(0xFFF8FAFC),
      error: Color(0xFFEF4444),
      onPrimary: Colors.white,
    ),
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFF34D399),
      surface: Color(0xFF1F2937),
      background: Color(0xFF111827),
    ),
    fontFamily: 'Inter',
  );
}