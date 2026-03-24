import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/gradient_button.dart';
import 'join_room_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double _designWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final layoutWidth = math.min(constraints.maxWidth, 330.0);
            final scale = layoutWidth / _designWidth;
            final verticalSpacing = constraints.maxHeight > 760 ? 1.0 : 0.92;

            return Stack(
              children: [
                const Positioned.fill(child: _HomeDecorations()),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: layoutWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                      child: Column(
                        children: [
                          SizedBox(height: 70 * scale * verticalSpacing),
                          _HeroMark(scale: scale),
                          SizedBox(height: 22 * scale),
                          Text(
                            'ChameChat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35 * scale,
                              height: 1,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              letterSpacing: -1.1 * scale,
                            ),
                          ),
                          SizedBox(height: 16 * scale),
                          Text(
                            'Conecte-se e converse\nem salas unicas.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.2 * scale,
                              height: 1.32,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2D2F42),
                              letterSpacing: -0.1 * scale,
                            ),
                          ),
                          SizedBox(height: 25 * scale * verticalSpacing),
                          SizedBox(
                            width: 244 * scale,
                            child: GradientButton(
                              label: 'Entrar em uma sala',
                              padding: EdgeInsets.symmetric(
                                vertical: 16 * scale,
                              ),
                              borderRadius: 25 * scale,
                              fontSize: 17 * scale,
                              fontWeight: FontWeight.w800,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const JoinRoomPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 18 * scale),
                          SizedBox(
                            width: 244 * scale,
                            child: GradientButton(
                              label: 'Criar nova sala',
                              padding: EdgeInsets.symmetric(
                                vertical: 16 * scale,
                              ),
                              borderRadius: 25 * scale,
                              fontSize: 17 * scale,
                              fontWeight: FontWeight.w800,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const JoinRoomPage(
                                      autoCreateRoom: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HomeDecorations extends StatelessWidget {
  const _HomeDecorations();

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
                  colors: [Color(0xFF6F53F7), Color(0xFF2D59F0)],
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
              left: -width * 0.14,
              top: height * 0.58,
              child: _SoftCircle(
                size: width * 0.17,
                color: const Color(0x50BCC7FF),
              ),
            ),
            Positioned(
              left: -width * 0.21,
              bottom: -width * 0.18,
              child: _SoftCircle(
                size: width * 0.66,
                gradient: const LinearGradient(
                  colors: [Color(0x1FA7E8EE), Color(0x10B7B6FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -width * 0.06,
              bottom: -width * 0.04,
              child: _SoftCircle(
                size: width * 0.23,
                gradient: const LinearGradient(
                  colors: [Color(0x55FF8D85), Color(0x33AEEEF0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: width * 0.27,
              bottom: height * 0.14,
              child: _SoftCircle(
                size: width * 0.03,
                color: const Color(0x4BA4AAFF),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HeroMark extends StatelessWidget {
  final double scale;

  const _HeroMark({required this.scale});

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
              color: AppColors.accentLavender,
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
              color: const Color(0xFFD9FAFD),
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
            right: 36 * scale,
            bottom: 8 * scale,
            child: _MiniBubble(size: 28 * scale, color: AppColors.accentMint),
          ),
          SizedBox(
            width: 102 * scale,
            height: 102 * scale,
            child: const _ColorWheel(),
          ),
        ],
      ),
    );
  }
}

class _ColorWheel extends StatelessWidget {
  const _ColorWheel();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Color(0xFF6B56F7),
            Color(0xFF2D60EF),
            Color(0xFF77E2E2),
            Color(0xFFFF7D73),
            Color(0xFF9955F7),
            Color(0xFF6B56F7),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
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
