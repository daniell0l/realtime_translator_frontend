import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_input.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final nameCtrl = TextEditingController();
  final codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar na sala'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppInput(
                label: 'Seu nome',
                hint: 'Ex: João',
                controller: nameCtrl,
              ),
              const SizedBox(height: 18),
              AppInput(
                label: 'Código da sala',
                hint: 'Ex: ABC123',
                controller: codeCtrl,
              ),
              const SizedBox(height: 24),
              GradientButton(
                label: 'Entrar agora',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.createRoom),
                child: const Text('Criar nova sala'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
