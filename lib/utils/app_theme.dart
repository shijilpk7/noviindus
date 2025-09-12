import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Poppins",
      textTheme: TextTheme(
        // Title
        titleLarge: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: AppColors.textPrimary,
        ),
        // Field labels
        bodyLarge: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        // Placeholder (Inter)
        bodyMedium: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: AppColors.hintText,
        ),
        // Button
        labelLarge: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: AppColors.white,
        ),
        // Terms
        bodySmall: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.0,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
