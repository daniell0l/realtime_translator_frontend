import 'package:flutter/material.dart';

class CreateRoomInputBox extends StatelessWidget {
  final double scale;
  final Widget child;

  const CreateRoomInputBox({
    super.key,
    required this.scale,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFD8E0EC)),
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
        child: child,
      ),
    );
  }
}
