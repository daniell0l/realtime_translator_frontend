import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
// import 'package:realtime_translator_frontend/src/shared/widgets/app_button.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'João (você)', 'online': true},
      {'name': 'Ana', 'online': true},
      {'name': 'Pedro', 'online': true},
      {'name': 'Mariana', 'online': false},
      {'name': 'Lucas', 'online': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Participantes')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AppCard(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Código da sala: ABC123',
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
                          color: online ? AppColors.success : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
              GradientButton(label: 'Copiar código', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
