import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

enum _RoomPrivacy { public, private }

class _CreateRoomPageState extends State<CreateRoomPage> {
  static const double _designWidth = 250;

  final nameController = TextEditingController();
  final roomNameController = TextEditingController();

  late final String generatedCode;
  _RoomPrivacy privacy = _RoomPrivacy.public;

  bool get isFormValid =>
      nameController.text.trim().isNotEmpty &&
      roomNameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    generatedCode = _generateRoomCode();
    nameController.addListener(_refreshForm);
    roomNameController.addListener(_refreshForm);
  }

  @override
  void dispose() {
    nameController.removeListener(_refreshForm);
    roomNameController.removeListener(_refreshForm);
    nameController.dispose();
    roomNameController.dispose();
    super.dispose();
  }

  void _refreshForm() {
    if (mounted) {
      setState(() {});
    }
  }

  String _generateRoomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = math.Random();
    final prefix = List.generate(
      3,
      (_) => letters[random.nextInt(letters.length)],
    ).join();
    final suffix = (1000 + random.nextInt(9000)).toString();
    return '$prefix-$suffix';
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: generatedCode));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Codigo copiado com sucesso.')),
    );
  }

  void _handleCreateRoom() {
    if (!isFormValid) return;

    Navigator.pushNamed(context, AppRoutes.chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final layoutWidth = math.min(constraints.maxWidth, 380.0);
          final scale = layoutWidth / _designWidth;

          return Column(
            children: [
              _CreateRoomHeader(scale: scale),
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
                            'Criar sala',
                            style: TextStyle(
                              fontSize: 28 * scale,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.8,
                            ),
                          ),
                          SizedBox(height: 8 * scale),
                          Text(
                            'Configure sua sala e comece a conversar',
                            style: TextStyle(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 28 * scale),
                          _FieldLabel(label: 'Seu nome', scale: scale),
                          SizedBox(height: 10 * scale),
                          _InputBox(
                            scale: scale,
                            child: TextField(
                              controller: nameController,
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
                          _FieldLabel(label: 'Nome da sala', scale: scale),
                          SizedBox(height: 10 * scale),
                          _InputBox(
                            scale: scale,
                            child: TextField(
                              controller: roomNameController,
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
                          _FieldLabel(label: 'Codigo gerado', scale: scale),
                          SizedBox(height: 10 * scale),
                          Row(
                            children: [
                              Expanded(
                                child: _GeneratedCodeBox(
                                  scale: scale,
                                  code: generatedCode,
                                ),
                              ),
                              SizedBox(width: 12 * scale),
                              _CopyButton(scale: scale, onPressed: _copyCode),
                            ],
                          ),
                          SizedBox(height: 22 * scale),
                          _FieldLabel(label: 'Privacidade', scale: scale),
                          SizedBox(height: 10 * scale),
                          Row(
                            children: [
                              Expanded(
                                child: _PrivacyCard(
                                  scale: scale,
                                  label: 'Publica',
                                  icon: Icons.public_rounded,
                                  selected: privacy == _RoomPrivacy.public,
                                  onTap: () => setState(
                                    () => privacy = _RoomPrivacy.public,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12 * scale),
                              Expanded(
                                child: _PrivacyCard(
                                  scale: scale,
                                  label: 'Privada',
                                  icon: Icons.lock_outline_rounded,
                                  selected: privacy == _RoomPrivacy.private,
                                  onTap: () => setState(
                                    () => privacy = _RoomPrivacy.private,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 26 * scale),
                          Opacity(
                            opacity: isFormValid ? 1 : 0.45,
                            child: IgnorePointer(
                              ignoring: !isFormValid,
                              child: GradientButton(
                                label: 'Criar sala',
                                padding: EdgeInsets.symmetric(
                                  vertical: 16 * scale,
                                ),
                                borderRadius: 18 * scale,
                                fontSize: 18 * scale,
                                fontWeight: FontWeight.w800,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFC9B4FF),
                                    Color(0xFFB99CF6),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
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
      ),
    );
  }
}

class _CreateRoomHeader extends StatelessWidget {
  final double scale;

  const _CreateRoomHeader({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        16 * scale,
        16 * scale,
        22 * scale,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33735AF4),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56 * scale,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24 * scale),
                  onTap: () => Navigator.pop(context),
                  child: Ink(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'Criar sala',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21 * scale,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final double scale;

  const _FieldLabel({required this.label, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final double scale;
  final Widget child;

  const _InputBox({required this.scale, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFD8E0EC)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              color: Color(0xFF8B95A7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _GeneratedCodeBox extends StatelessWidget {
  final double scale;
  final String code;

  const _GeneratedCodeBox({required this.scale, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54 * scale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFD8E0EC)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final double scale;
  final VoidCallback onPressed;

  const _CopyButton({required this.scale, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54 * scale,
      height: 54 * scale,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD8E0EC)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18 * scale),
          ),
        ),
        onPressed: onPressed,
        child: Icon(
          Icons.content_copy_rounded,
          color: AppColors.textSecondary,
          size: 22 * scale,
        ),
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final double scale;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PrivacyCard({
    required this.scale,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppColors.primary : const Color(0xFFD8E0EC);
    final backgroundColor = selected ? const Color(0xFFF2F5FF) : Colors.white;
    final textColor = selected ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(18 * scale),
      onTap: onTap,
      child: Ink(
        height: 72 * scale,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: borderColor, width: selected ? 1.8 : 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 22 * scale),
            SizedBox(height: 6 * scale),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
