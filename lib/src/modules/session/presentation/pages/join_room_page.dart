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
  final sessionController = SessionController(SessionApiService());
  final nameController = TextEditingController();
  late final TextEditingController roomCodeController;
  bool obscureCode = false;
  String? _lastErrorMessage;

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
    if (errorMessage != null && errorMessage != _lastErrorMessage) {
      _lastErrorMessage = errorMessage;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () => Navigator.pop(context),
                  child: Ink(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0x1FEDE7FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x267658EE),
                      blurRadius: 28,
                      offset: Offset(0, 18),
                    ),
                  ],
                ),
                child: const Text(
                  'Entrar na sala',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 44),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Seu nome',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              _InputShell(
                child: TextField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    hintText: 'Mariana Silva',
                  ),
                ),
              ),
              const SizedBox(height: 26),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Codigo da sala',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              _InputShell(
                child: TextField(
                  controller: roomCodeController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: obscureCode,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.qr_code_2_rounded),
                    hintText: 'CHR-7X9B',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => obscureCode = !obscureCode),
                      icon: Icon(
                        obscureCode
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => handleJoinRoom(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Entrar agora',
                  gradient: AppColors.ctaGradient,
                  onPressed: handleJoinRoom,
                  isLoading: sessionController.isLoading,
                ),
              ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: sessionController.isLoading
                    ? null
                    : handleCreateRoom,
                child: const Text(
                  'Criar nova sala',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    decoration: TextDecoration.underline,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputShell extends StatelessWidget {
  final Widget child;

  const _InputShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
