import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFFAEDC81);
  static const Color primaryDark = Color(0xFF6CC51D);
  static const Color primaryLight = Color(0xFFEBFFD7);

  // Backgrounds
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF4F5F9);
  static const Color backgroundTertiary = Color(0xFFF5F5F5);

  // Text
  static const Color textPrimary = Color(
    0xFF1E1E1E,
  ); // Custom dark grey for headings
  static const Color textSecondary = Color(0xFF868889);

  // Extras
  static const Color link = Color(0xFF1A0DAB);
  static const Color border = Color(0xFFEBEBEB);
}
