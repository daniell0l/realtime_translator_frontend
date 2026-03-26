import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFFEAEFF7)),
      child: Stack(
        children: [
          const Positioned(
            bottom: -105,
            left: -129,
            child: _BlurBubble(
              size: 220,
              colors: [Color(0x22305CF0), Color(0x228C53F9)],
            ),
          ),
          const Positioned(
            top: 110,
            right: -40,
            child: _BlurBubble(
              size: 120,
              colors: [Color(0x33FF7A70), Color(0x11FF7A70)],
            ),
          ),
          const Positioned(
            bottom: -90,
            left: -40,
            child: _BlurBubble(
              size: 250,
              colors: [Color(0x26AEEEF0), Color(0x12DCD3FF)],
            ),
          ),
          const Positioned(
            bottom: 42,
            right: -30,
            child: _BlurBubble(
              size: 130,
              colors: [Color(0x33FFB0A9), Color(0x11AEEEF0)],
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _BlurBubble extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _BlurBubble({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
