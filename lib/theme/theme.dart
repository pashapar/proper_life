import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFE9E9E9),
  // scaffoldBackgroundColor: const Color(0xFFEEE5FF),
  cardColor: const Color(0xfff5f5f5),
  dividerColor: const Color(0xcc5900ff),
  primaryColor: const Color(0xff5900ff),
  iconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelAlignment: FloatingLabelAlignment.center,
    focusColor: const Color(0x66d9d9d9),
    fillColor: const Color(0x99d9d9d9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  textTheme:
      // GoogleFonts.sunflowerTextTheme(
      const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          bodyLarge: TextStyle(
            color: Color(0xbf000000),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Color(0x99000000),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            color: Color(0x99000000),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          titleMedium: TextStyle(
            color: Color(0xfff5f5f5),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Color(0xff5900ff),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          )),
  // ),
  useMaterial3: true,
);
