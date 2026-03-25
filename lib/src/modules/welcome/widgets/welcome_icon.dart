import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class WelcomeIcon extends StatelessWidget {
  final double scale;

  const WelcomeIcon({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98 * scale,
      height: 98 * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x224F6BFF),
            blurRadius: 50,
            offset: Offset(0, 16),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        20 * scale,
        23 * scale,
        20 * scale,
        16 * scale,
      ),
      child: const Icon(
        Icons.chat_bubble_rounded,
        color: Colors.white,
        size: 70,
      ),
    );
  }
}
