import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../widgets/welcome_decorations.dart';
import '../widgets/welcome_hero_mark.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const double _designWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF7F8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final layoutWidth = math.min(constraints.maxWidth, 330.0);
            final scale = layoutWidth / _designWidth;
            final verticalSpacing = constraints.maxHeight > 760 ? 1.0 : 0.92;

            return Stack(
              children: [
                const Positioned.fill(child: WelcomeDecorations()),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: layoutWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                      child: Column(
                        children: [
                          SizedBox(height: 60 * scale * verticalSpacing),
                          WelcomeHeroMark(scale: scale),
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
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AppRoutes.joinRoom,
                              ),
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
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AppRoutes.createRoom,
                              ),
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
