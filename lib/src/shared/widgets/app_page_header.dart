import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class AppPageHeader extends StatelessWidget {
  final double scale;
  final String title;
  final VoidCallback onBack;

  const AppPageHeader({
    super.key,
    required this.scale,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        8 * scale,
        16 * scale,
        8 * scale,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33735AF4),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56 * scale,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24 * scale),
                  onTap: onBack,
                  child: Ink(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21 * scale,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
