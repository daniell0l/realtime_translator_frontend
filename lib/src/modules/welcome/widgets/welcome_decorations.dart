import 'package:flutter/material.dart';

class WelcomeDecorations extends StatelessWidget {
  const WelcomeDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            Positioned(
              top: -width * 0.36,
              left: -width * 0.40,
              child: _SoftCircle(
                size: width * 0.75,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(52, 110, 83, 247),
                    Color.fromARGB(31, 45, 90, 240),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: width * 0.16,
              right: -width * 0.15,
              child: _SoftCircle(
                size: width * 0.34,
                color: const Color(0x1FFFA9A1),
              ),
            ),
            Positioned(
              left: -width * 0.21,
              bottom: -width * 0.18,
              child: _SoftCircle(
                size: width * 0.66,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(14, 167, 232, 238),
                    Color(0x10B7B6FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              left: -width * 0.06,
              bottom: -width * 0.04,
              child: _SoftCircle(
                size: width * 0.23,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 141, 133),
                    Color(0x33AEEEF0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -width * 0.4,
              bottom: height * 0.0,
              child: _SoftCircle(
                size: width * 0.85,
                color: const Color.fromARGB(17, 164, 170, 255),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SoftCircle extends StatelessWidget {
  final double size;
  final Color? color;
  final Gradient? gradient;

  const _SoftCircle({required this.size, this.color, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: gradient == null ? color : null,
        gradient: gradient,
      ),
    );
  }
}
