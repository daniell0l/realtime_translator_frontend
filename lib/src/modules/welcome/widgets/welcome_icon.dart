import 'package:flutter/material.dart';

class WelcomeIcon extends StatelessWidget {
  final double scale;

  const WelcomeIcon({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250 * scale,
      height: 250 * scale,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          maxWidth: 420 * scale,
          maxHeight: 420 * scale,
          child: Image.asset(
            'assets/images/logo-chame-chat.png',
            width: 300 * scale,
            height: 300 * scale,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
