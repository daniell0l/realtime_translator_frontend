import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../chat/data/services/chat_socket_service.dart';
import '../../../chat/presentation/controllers/chat_controller.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../data/services/session_api_service.dart';
import '../controllers/session_controller.dart';

class JoinRoomPage extends StatefulWidget {
  final String? initialRoomCode;
  final bool autoCreateRoom;

  const JoinRoomPage({
    super.key,
    this.initialRoomCode,
    this.autoCreateRoom = false,
  });

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  static const double _designWidth = 250;

  final sessionController = SessionController(SessionApiService());
  final nameController = TextEditingController();
  late final TextEditingController roomCodeController;
  bool obscureCode = false;
  String? lastErrorMessage;

  @override
  void initState() {
    super.initState();
    roomCodeController = TextEditingController(
      text: widget.initialRoomCode ?? '',
    );
    sessionController.addListener(_handleControllerChanges);

    if (widget.autoCreateRoom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleCreateRoom();
      });
    }
  }

  @override
  void dispose() {
    sessionController.removeListener(_handleControllerChanges);
    sessionController.dispose();
    nameController.dispose();
    roomCodeController.dispose();
    super.dispose();
  }

  void _handleControllerChanges() {
    if (!mounted) return;

    final errorMessage = sessionController.errorMessage;
    if (errorMessage != null && errorMessage != lastErrorMessage) {
      lastErrorMessage = errorMessage;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }

    setState(() {});
  }

  Future<void> handleCreateRoom() async {
    await sessionController.createSession();

    if (!mounted || sessionController.session == null) return;

    roomCodeController.text = sessionController.session!.code;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sala criada com sucesso: ${sessionController.session!.code}',
        ),
      ),
    );
  }

  Future<void> handleJoinRoom() async {
    FocusScope.of(context).unfocus();

    if (nameController.text.trim().isEmpty ||
        roomCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha seu nome e o codigo da sala.')),
      );
      return;
    }

    await sessionController.joinSession(
      sessionCode: roomCodeController.text.trim(),
      name: nameController.text.trim(),
      speakLocale: 'pt-BR',
      listenLocale: 'en-US',
      speakCountry: 'BR',
      listenCountry: 'US',
    );

    if (!mounted ||
        sessionController.session == null ||
        sessionController.participant == null) {
      return;
    }

    final chatController = ChatController(ChatSocketService());
    chatController.connect(sessionId: sessionController.session!.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          sessionId: sessionController.session!.id,
          sessionCode: sessionController.session!.code,
          participantId: sessionController.participant!.id,
          participantName: sessionController.participant!.name,
          chatController: chatController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final layoutWidth = math.min(constraints.maxWidth, 350.0);
            final scale = layoutWidth / _designWidth;
            final formWidth = 244 * scale;

            return Column(
              children: [
                _JoinHeader(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: layoutWidth,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            5 * scale,
                            60 * scale,
                            5 * scale,
                            30 * scale, // Aumentado para dar espaço ao fim do scroll
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Seu nome',
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5 * scale),
                              SizedBox(
                                width: formWidth,
                                child: _InputShell(
                                  borderRadius: 50 * scale,
                                  child: TextField(
                                    controller: nameController,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      fontSize: 15 * scale,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      filled: false,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8 * scale,
                                          right: 4 * scale,
                                        ),
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          size: 24 * scale,
                                        ),
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 50 * scale,
                                        minHeight: 0,
                                      ),
                                      hintText: 'Daniel Medrado',
                                      hintStyle: TextStyle(
                                        fontSize: 15 * scale,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF5D627C),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20 * scale,
                                        vertical: 14 * scale,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15 * scale),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Codigo da sala',
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5 * scale),
                              SizedBox(
                                width: formWidth,
                                child: _InputShell(
                                  borderRadius: 50 * scale,
                                  child: TextField(
                                    controller: roomCodeController,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    obscureText: obscureCode,
                                    style: TextStyle(
                                      fontSize: 15 * scale,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      filled: false,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8 * scale,
                                          right: 4 * scale,
                                        ),
                                        child: Icon(
                                          Icons.qr_code_2_rounded,
                                          size: 24 * scale,
                                        ),
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 52 * scale,
                                        minHeight: 0,
                                      ),
                                      hintText: 'CHR-7X9B',
                                      hintStyle: TextStyle(
                                        fontSize: 15 * scale,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF5D627C),
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          left: 4 * scale,
                                          right: 8 * scale,
                                        ),
                                        child: IconButton(
                                          onPressed: () => setState(
                                            () => obscureCode = !obscureCode,
                                          ),
                                          icon: Icon(
                                            obscureCode
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            size: 23 * scale,
                                          ),
                                        ),
                                      ),
                                      suffixIconConstraints: BoxConstraints(
                                        minWidth: 52 * scale,
                                        minHeight: 0,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20 * scale,
                                        vertical: 14 * scale,
                                      ),
                                    ),
                                    onSubmitted: (_) => handleJoinRoom(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 26 * scale),
                              SizedBox(
                                width: formWidth,
                                child: GradientButton(
                                  label: 'Entrar agora',
                                  gradient: AppColors.ctaGradient,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16 * scale,
                                  ),
                                  borderRadius: 50 * scale,
                                  fontSize: 17 * scale,
                                  fontWeight: FontWeight.w800,
                                  onPressed: handleJoinRoom,
                                  isLoading: sessionController.isLoading,
                                ),
                              ),
                              SizedBox(height: 10 * scale),
                              TextButton(
                                onPressed: sessionController.isLoading
                                    ? null
                                    : handleCreateRoom,
                                child: Text(
                                  'Criar nova sala',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15 * scale,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
      ),
    );
  }
}

class _InputShell extends StatefulWidget {
  final Widget child;
  final double borderRadius;

  const _InputShell({required this.child, this.borderRadius = 30});

  @override
  State<_InputShell> createState() => _InputShellState();
}

class _InputShellState extends State<_InputShell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _isHovered ? const Color(0x558C53F9) : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? const Color(0x264F5D95) : AppColors.shadow,
              blurRadius: _isHovered ? 50 : 16,
              offset: Offset(0, _isHovered ? 10 : 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: ColoredBox(color: AppColors.surface, child: widget.child),
        ),
      ),
    );
  }
}

class _JoinHeader extends StatelessWidget {
  final double scale;

  const _JoinHeader({required this.scale});

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
                    decoration: BoxDecoration(
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
                'Entrar na sala',
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
