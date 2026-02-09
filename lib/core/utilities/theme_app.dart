import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/const.dart';

class AppTheme {
  static const Color lightBackground = kScaffoldColor;
  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white70;

  // ===== Helper لتحديد الخط =====
  static TextTheme _getFontTextTheme(String languageCode, TextTheme baseTheme) {
    if (languageCode == 'ar') {
      return GoogleFonts.notoSansTextTheme(baseTheme);
    } else {
      return GoogleFonts.manropeTextTheme(baseTheme);
    }
  }

  static TextStyle _getAppBarFont(String languageCode) {
    if (languageCode == 'ar') {
      return GoogleFonts.notoSansArabic(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );
    } else {
      return GoogleFonts.manrope(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );
    }
  }

  // ================= Light Theme =================
  static ThemeData lightTheme(String languageCode) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: lightBackground,

      appBarTheme: AppBarTheme(
        backgroundColor: kScaffoldColor,
        surfaceTintColor: kScaffoldColor,
        foregroundColor: Colors.red,
        elevation: 0,
        titleTextStyle: _getAppBarFont(languageCode),
      ),

      textTheme: _getFontTextTheme(
        languageCode,
        ThemeData.light().textTheme,
      ).apply(bodyColor: lightTextColor, displayColor: lightTextColor),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
  }

  // ================= Dark Theme =================
  static ThemeData darkTheme(String languageCode) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey.shade400,
      scaffoldBackgroundColor: Colors.grey.shade700,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: _getAppBarFont(languageCode),
      ),

      textTheme: _getFontTextTheme(
        languageCode,
        ThemeData.dark().textTheme,
      ).apply(bodyColor: darkTextColor, displayColor: darkTextColor),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
}
