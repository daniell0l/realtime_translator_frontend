import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class CreateRoomPrivacyCard extends StatelessWidget {
  final double scale;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const CreateRoomPrivacyCard({
    super.key,
    required this.scale,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppColors.primary : const Color(0xFFD6DEEA);
    final backgroundColor = selected ? const Color(0xFFF6F8FF) : Colors.white;
    final textColor = selected ? AppColors.primary : AppColors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16 * scale),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 72 * scale,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.8 : 1.3,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 21 * scale),
              SizedBox(height: 6 * scale),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.5 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
