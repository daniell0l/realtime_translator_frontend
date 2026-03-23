import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/gradient_button.dart';
import 'join_room_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),
              const _HeroMark(),
              const SizedBox(height: 28),
              const Text(
                'ChameChat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Conecte-se e converse\nem salas únicas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Entrar em uma sala',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const JoinRoomPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Criar nova sala',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const JoinRoomPage(autoCreateRoom: true),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 44),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroMark extends StatelessWidget {
  const _HeroMark();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 210,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Positioned(
            top: 10,
            left: 38,
            child: _MiniBubble(color: AppColors.accentLavender),
          ),
          Positioned(
            top: 26,
            right: 16,
            child: _MiniChatBubble(color: AppColors.accentMint),
          ),
          Positioned(
            left: 0,
            top: 84,
            child: _MiniChatBubble(color: Color(0xFFCDEFF8)),
          ),
          Positioned(
            right: 6,
            top: 96,
            child: _MiniChatBubble(color: AppColors.accentPeach),
          ),
          _ColorWheel(),
        ],
      ),
    );
  }
}

class _ColorWheel extends StatelessWidget {
  const _ColorWheel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Color(0xFF6B5BFF),
            Color(0xFF2B64F1),
            Color(0xFF7AE8E8),
            Color(0xFFFF7B70),
            Color(0xFF8C53F9),
            Color(0xFF6B5BFF),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _MiniBubble extends StatelessWidget {
  final Color color;

  const _MiniBubble({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _MiniChatBubble extends StatelessWidget {
  final Color color;

  const _MiniChatBubble({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 42,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: const Text(
        '...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
