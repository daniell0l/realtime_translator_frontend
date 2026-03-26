import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const AppCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFDCE4F2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.85),
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}
