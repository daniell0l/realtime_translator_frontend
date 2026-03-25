import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class RoomInputBox extends StatefulWidget {
  final double scale;
  final Widget child;

  const RoomInputBox({
    super.key,
    required this.scale,
    required this.child,
  });

  @override
  State<RoomInputBox> createState() => _RoomInputBoxState();
}

class _RoomInputBoxState extends State<RoomInputBox> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasFocus
        ? AppColors.primary
        : const Color(0xFFD8E0EC);
    final borderWidth = _hasFocus ? 1.8 : 1.2;

    return FocusScope(
      onFocusChange: (hasFocus) {
        if (_hasFocus == hasFocus) return;

        setState(() {
          _hasFocus = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 18 * widget.scale),
        decoration: BoxDecoration(
          color: _hasFocus ? const Color(0xFFF2F5FF) : Colors.white,
          borderRadius: BorderRadius.circular(18 * widget.scale),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                color: Color(0xFF8B95A7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
