import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF7F9FC);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSoft = Color(0xFFF1F4F9);

  static const textPrimary = Color(0xFF1A1F36);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);

  static const primary = Color(0xFF4F6BFF);
  static const secondary = Color(0xFF7C4DFF);
  static const accent = Color(0xFFFF6B6B);
  static const cyan = Color(0xFF4DD6FF);

  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const shadow = Color(0x1A4F5D95);

  static const chatMe = Color(0xFF4F6BFF);
  static const chatOther = Color.fromARGB(255, 232, 240, 255);

  static const gradientStart = Color(0xFF4F6BFF);
  static const gradientMiddle = Color(0xFF7C4DFF);
  static const gradientEnd = Color(0xFF4DD6FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientMiddle],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient ctaGradient = LinearGradient(
    colors: [accent, gradientStart],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
