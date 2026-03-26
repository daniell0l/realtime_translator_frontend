import 'package:flutter/material.dart';
import 'welcome_icon.dart';

class WelcomeHeroMark extends StatelessWidget {
  final double scale;

  const WelcomeHeroMark({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230 * scale,
      height: 210 * scale,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: _MiniBubble(
              size: 16 * scale,
              color: const Color.fromARGB(45, 79, 108, 255),
            ),
          ),
          Positioned(
            left: 18 * scale,
            top: 40 * scale,
            child: _SpeechBubble(
              width: 68 * scale,
              height: 42 * scale,
              color: const Color(0xFFD3D4FF),
              tailAlignment: BubbleTailAlignment.end,
            ),
          ),
          Positioned(
            right: 8 * scale,
            top: 24 * scale,
            child: _SpeechBubble(
              width: 68 * scale,
              height: 42 * scale,
              color: const Color(0xFFC6F3F2),
              tailAlignment: BubbleTailAlignment.start,
            ),
          ),
          Positioned(
            left: 2 * scale,
            top: 136 * scale,
            child: _SpeechBubble(
              width: 50 * scale,
              height: 31 * scale,
              color: const Color.fromARGB(255, 187, 249, 255),
              tailAlignment: BubbleTailAlignment.start,
              compact: true,
            ),
          ),
          Positioned(
            right: 16 * scale,
            top: 128 * scale,
            child: _SpeechBubble(
              width: 50 * scale,
              height: 31 * scale,
              color: const Color(0xFFFFC8C0),
              tailAlignment: BubbleTailAlignment.end,
              compact: true,
            ),
          ),
          Positioned(
            right: 100 * scale,
            bottom: 8 * scale,
            child: _MiniBubble(
              size: 28 * scale,
              color: const Color.fromARGB(17, 255, 107, 107),
            ),
          ),
          Positioned(
            top: 20 * scale,
            child: WelcomeIcon(scale: scale),
          ),
        ],
      ),
    );
  }
}

class _MiniBubble extends StatelessWidget {
  final double size;
  final Color color;

  const _MiniBubble({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

enum BubbleTailAlignment { start, end }

class _SpeechBubble extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final BubbleTailAlignment tailAlignment;
  final bool compact;

  const _SpeechBubble({
    required this.width,
    required this.height,
    required this.color,
    required this.tailAlignment,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = compact ? width * 0.09 : width * 0.08;

    return SizedBox(
      width: width,
      height: height + (compact ? 7 : 9),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(compact ? 13 : 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Dot(size: dotSize),
                SizedBox(width: width * 0.08),
                _Dot(size: dotSize),
                SizedBox(width: width * 0.08),
                _Dot(size: dotSize),
              ],
            ),
          ),
          Positioned(
            left: tailAlignment == BubbleTailAlignment.start
                ? width * 0.17
                : null,
            right: tailAlignment == BubbleTailAlignment.end
                ? width * 0.17
                : null,
            bottom: 0,
            child: CustomPaint(
              size: Size(width * 0.16, compact ? 7 : 9),
              painter: _BubbleTailPainter(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;

  const _Dot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color color;

  const _BubbleTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width * 0.40, size.height * 0.12, size.width, 0)
      ..quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.78,
        size.width * 0.48,
        size.height,
      )
      ..quadraticBezierTo(size.width * 0.22, size.height * 0.64, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BubbleTailPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
