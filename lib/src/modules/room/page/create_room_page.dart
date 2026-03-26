import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/modules/room/controller/create_room_controller.dart';
import 'package:realtime_translator_frontend/src/modules/room/widgets/create_room_generated_code_box.dart';
import 'package:realtime_translator_frontend/src/modules/room/widgets/create_room_privacy_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_background.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_field_label.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_input_box.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_page_header.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  static const double _designWidth = 380;

  final controller = CreateRoomController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleCreateRoom() {
    if (!controller.isFormValid) return;

    Navigator.pushNamed(context, AppRoutes.chat);
  }

  Future<void> _handleBack() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    await Future<void>.delayed(const Duration(milliseconds: 80));

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final layoutWidth = math.min(constraints.maxWidth, 380.0);
            final scale = layoutWidth / _designWidth;

            return ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return Column(
                  children: [
                    AppPageHeader(
                      scale: scale,
                      title: 'Criar sala',
                      onBack: _handleBack,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          24 * scale,
                          24 * scale,
                          24 * scale,
                          32 * scale,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: layoutWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Configure sua sala e comece a conversar',
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 16 * scale),
                                AppFieldLabel(label: 'Seu nome', scale: scale),
                                SizedBox(height: 10 * scale),
                                AppInputBox(
                                  scale: scale,
                                  child: TextField(
                                    controller: controller.nameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: 'Digite seu nome',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22 * scale),
                                AppFieldLabel(label: 'Email', scale: scale),
                                SizedBox(height: 10 * scale),
                                AppInputBox(
                                  scale: scale,
                                  child: TextField(
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: 'Digite seu email',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22 * scale),
                                AppFieldLabel(
                                  label: 'Nome da sala',
                                  scale: scale,
                                ),
                                SizedBox(height: 10 * scale),
                                AppInputBox(
                                  scale: scale,
                                  child: TextField(
                                    controller: controller.roomNameController,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                      hintText: 'Ex: Reuniao de equipe',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22 * scale),
                                AppFieldLabel(
                                  label: 'Codigo gerado',
                                  scale: scale,
                                ),
                                SizedBox(height: 10 * scale),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CreateRoomGeneratedCodeBox(
                                        scale: scale,
                                        code: controller.generatedCode,
                                      ),
                                    ),
                                    SizedBox(width: 12 * scale),
                                    CreateRoomCopyButton(
                                      scale: scale,
                                      copied: controller.copiedCode,
                                      onPressed: controller.copyCode,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 22 * scale),
                                AppFieldLabel(
                                  label: 'Privacidade',
                                  scale: scale,
                                ),
                                SizedBox(height: 10 * scale),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CreateRoomPrivacyCard(
                                        scale: scale,
                                        label: 'Publica',
                                        icon: Icons.public_rounded,
                                        selected:
                                            controller.privacy ==
                                            RoomPrivacy.public,
                                        onTap: () => controller.selectPrivacy(
                                          RoomPrivacy.public,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12 * scale),
                                    Expanded(
                                      child: CreateRoomPrivacyCard(
                                        scale: scale,
                                        label: 'Privada',
                                        icon: Icons.lock_outline_rounded,
                                        selected:
                                            controller.privacy ==
                                            RoomPrivacy.private,
                                        onTap: () => controller.selectPrivacy(
                                          RoomPrivacy.private,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 26 * scale),
                                Opacity(
                                  opacity: controller.isFormValid ? 1 : 0.45,
                                  child: IgnorePointer(
                                    ignoring: !controller.isFormValid,
                                    child: GradientButton(
                                      label: 'Criar sala',
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16 * scale,
                                      ),
                                      borderRadius: 18 * scale,
                                      fontSize: 18 * scale,
                                      fontWeight: FontWeight.w800,
                                      onPressed: _handleCreateRoom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
