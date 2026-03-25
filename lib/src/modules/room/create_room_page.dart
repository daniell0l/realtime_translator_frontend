import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
// import 'package:realtime_translator_frontend/src/shared/widgets/app_button.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_input.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final nameCtrl = TextEditingController();
  final roomCtrl = TextEditingController();
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    const generatedCode = 'X7P9QK';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar sala'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: AppCard(
            child: Column(
              children: [
                AppInput(
                  label: 'Seu nome',
                  hint: 'Ex: Larissa',
                  controller: nameCtrl,
                ),
                const SizedBox(height: 18),
                AppInput(
                  label: 'Nome da sala',
                  hint: 'Ex: Equipe Mobile',
                  controller: roomCtrl,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSoft,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          generatedCode,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.copy_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sala privada'),
                  value: isPrivate,
                  onChanged: (v) => setState(() => isPrivate = v),
                ),
                const SizedBox(height: 16),
                GradientButton(
                  label: 'Criar sala',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
