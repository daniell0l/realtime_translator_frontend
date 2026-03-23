import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF7F8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF181C48);
  static const Color textSecondary = Color(0xFF667085);
  static const Color border = Color(0xFFE5E7F4);
  static const Color shadow = Color(0x1A4F5D95);

  static const Color gradientStart = Color(0xFF8C53F9);
  static const Color gradientEnd = Color(0xFF2456E8);
  static const Color accentCoral = Color(0xFFFF7A70);
  static const Color accentMint = Color(0xFFAEEEF0);
  static const Color accentPeach = Color(0xFFFFC2B7);
  static const Color accentLavender = Color(0xFFDCD3FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient ctaGradient = LinearGradient(
    colors: [accentCoral, gradientStart],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
