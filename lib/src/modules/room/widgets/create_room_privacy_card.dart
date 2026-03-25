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
    final borderColor = selected ? AppColors.primary : const Color(0xFFD8E0EC);
    final backgroundColor = selected ? const Color(0xFFF2F5FF) : Colors.white;
    final textColor = selected ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(18 * scale),
      onTap: onTap,
      child: Ink(
        height: 72 * scale,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: borderColor, width: selected ? 1.8 : 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 22 * scale),
            SizedBox(height: 6 * scale),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
