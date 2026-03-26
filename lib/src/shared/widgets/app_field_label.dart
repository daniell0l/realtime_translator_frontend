import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class AppFieldLabel extends StatelessWidget {
  final String label;
  final double scale;

  const AppFieldLabel({
    super.key,
    required this.label,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
