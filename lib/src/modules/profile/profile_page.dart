import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.surfaceSoft,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'João Silva',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      const Text('Disponível para conversar'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text('Tema', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Claro'),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Escuro'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Salas recentes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Equipe Mobile'),
                subtitle: Text('ABC123'),
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Amigos'),
                subtitle: Text('QWE908'),
              ),
              const Spacer(),
              GradientButton(
                label: 'Sair',
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
