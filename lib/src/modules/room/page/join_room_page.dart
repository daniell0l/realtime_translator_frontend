import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_background.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_field_label.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_input_box.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_page_header.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  static const double _designWidth = 380;

  final nameCtrl = TextEditingController();
  final codeCtrl = TextEditingController();

  bool get isFormValid =>
      nameCtrl.text.trim().isNotEmpty && codeCtrl.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    nameCtrl.addListener(_refreshForm);
    codeCtrl.addListener(_refreshForm);
  }

  @override
  void dispose() {
    nameCtrl.removeListener(_refreshForm);
    codeCtrl.removeListener(_refreshForm);
    nameCtrl.dispose();
    codeCtrl.dispose();
    super.dispose();
  }

  void _refreshForm() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleBack() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    await Future<void>.delayed(const Duration(milliseconds: 80));

    if (!mounted) return;

    Navigator.pop(context);
  }

  void _handleJoinRoom() {
    if (!isFormValid) return;

    Navigator.pushNamed(context, AppRoutes.chat);
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

            return Column(
              children: [
                AppPageHeader(
                  scale: scale,
                  title: 'Entrar na sala',
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
                              'Informe seu nome e o codigo compartilhado para entrar na conversa.',
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
                                controller: nameCtrl,
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
                            AppFieldLabel(
                              label: 'Codigo da sala',
                              scale: scale,
                            ),
                            SizedBox(height: 10 * scale),
                            AppInputBox(
                              scale: scale,
                              child: TextField(
                                controller: codeCtrl,
                                textInputAction: TextInputAction.done,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: const InputDecoration(
                                  hintText: 'Ex: ABC-1234',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onSubmitted: (_) => _handleJoinRoom(),
                              ),
                            ),
                            SizedBox(height: 26 * scale),
                            Opacity(
                              opacity: isFormValid ? 1 : 0.45,
                              child: IgnorePointer(
                                ignoring: !isFormValid,
                                child: GradientButton(
                                  label: 'Entrar agora',
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16 * scale,
                                  ),
                                  borderRadius: 18 * scale,
                                  fontSize: 18 * scale,
                                  fontWeight: FontWeight.w800,
                                  onPressed: _handleJoinRoom,
                                ),
                              ),
                            ),
                            SizedBox(height: 10 * scale),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.createRoom,
                                ),
                                child: const Text('Criar nova sala'),
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
        ),
      ),
    );
  }
}
