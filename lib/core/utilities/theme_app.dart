import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/const.dart';

class AppTheme {
  // ألوان عامة يمكن استخدامها في أي مكان

  static const Color lightBackground = Colors.white;
  //  static const Color darkBackground = ;

  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white70;

  // الثيم الفاتح
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: lightTextColor,
      displayColor: lightTextColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );

  // الثيم المظلم
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey.shade400,
    scaffoldBackgroundColor: Colors.grey.shade700,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: darkTextColor, displayColor: darkTextColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
    ),
  );
}
