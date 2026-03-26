import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_page_header.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  static const double _designWidth = 330;

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Joao (voce)', 'online': true},
      {'name': 'Ana', 'online': true},
      {'name': 'Pedro', 'online': true},
      {'name': 'Mariana', 'online': false},
      {'name': 'Lucas', 'online': true},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final layoutWidth = math.min(constraints.maxWidth, 380.0);
          final scale = layoutWidth / _designWidth;

          return Column(
            children: [
              AppPageHeader(
                scale: scale,
                title: 'Participantes',
                onBack: () => Navigator.pop(context),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(24 * scale),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: layoutWidth,
                      child: AppCard(
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Codigo da sala: ABC123',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: users.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (_, i) {
                                  final user = users[i];
                                  final online = user['online'] as bool;
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: online
                                          ? AppColors.cyan.withOpacity(.2)
                                          : AppColors.surfaceSoft,
                                      child: Icon(
                                        Icons.person,
                                        color: online
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                    title: Text(user['name'] as String),
                                    trailing: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: online
                                            ? AppColors.success
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            GradientButton(
                              label: 'Copiar codigo',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
