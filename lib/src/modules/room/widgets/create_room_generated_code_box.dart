import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class CreateRoomGeneratedCodeBox extends StatelessWidget {
  final double scale;
  final String code;

  const CreateRoomGeneratedCodeBox({
    super.key,
    required this.scale,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54 * scale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFD8E0EC)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class CreateRoomCopyButton extends StatelessWidget {
  final double scale;
  final VoidCallback onPressed;

  const CreateRoomCopyButton({
    super.key,
    required this.scale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54 * scale,
      height: 54 * scale,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD8E0EC)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18 * scale),
          ),
        ),
        onPressed: onPressed,
        child: Icon(
          Icons.content_copy_rounded,
          color: AppColors.textSecondary,
          size: 22 * scale,
        ),
      ),
    );
  }
}
