import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hms_app/core/theme/colors.dart';

class AppTheme {
  static TextTheme textTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: AppColors.grey900,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: AppColors.grey900,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.grey900,
    ),
    bodyLarge: TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      color: AppColors.grey900,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.grey900,
    ),
    bodySmall: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w600,
      color: AppColors.grey900,
    ),
  ).apply(
    fontFamily: GoogleFonts.urbanist().fontFamily,
  );
  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(width: 1.5, color: AppColors.greyScaleColor),
  );
  static final themeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryColor900,
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
    ),
  );
}
