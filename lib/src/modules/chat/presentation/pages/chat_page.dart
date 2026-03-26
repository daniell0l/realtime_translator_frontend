import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = <_ChatEntry>[
      const _DateEntry('Ontem'),
      const _SystemEntry('Ana entrou usando o codigo: ABC-123'),
      const _MessageEntry(
        senderName: 'Ana Silva',
        senderInitials: 'AS',
        text: 'Passei aqui so para testar o fluxo da sala.',
        time: '22:10',
        isMe: false,
        avatarColor: Color(0xFF8B6CF6),
      ),
      const _SystemEntry('Junior entrou usando o codigo: ABC-123'),
      const _DateEntry('Hoje'),
      const _MessageEntry(
        senderName: 'Magno Mu',
        senderInitials: 'MM',
        text: 'Agora ele achou pra cabeca',
        time: '00:05',
        isMe: false,
        avatarColor: Color(0xFF24262F),
      ),
      const _MessageEntry(
        senderName: 'Voce',
        senderInitials: 'VC',
        text: 'Oi pessoal! Como estao?',
        time: '14:33',
        isMe: true,
        avatarColor: Color(0xFFFF8A9A),
      ),
      const _MessageEntry(
        senderName: 'Carlos Lima',
        senderInitials: 'CL',
        text: 'Tudo otimo por aqui!',
        time: '14:34',
        isMe: false,
        avatarColor: AppColors.cyan,
      ),
      const _MessageEntry(
        senderName: 'Voce',
        senderInitials: 'VC',
        text: 'Que bom! Vamos comecar?',
        time: '14:35',
        isMe: true,
        avatarColor: Color(0xFFFF8A9A),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const _ChatTopBar(),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
              itemCount: entries.length,
              itemBuilder: (_, index) {
                final entry = entries[index];

                if (entry is _DateEntry) {
                  return _DateDivider(label: entry.label);
                }

                if (entry is _SystemEntry) {
                  return _SystemMessage(text: entry.text);
                }

                return _MessageBubble(message: entry as _MessageEntry);
              },
            ),
          ),
          const _ComposerBar(),
        ],
      ),
    );
  }
}

class _ChatTopBar extends StatelessWidget {
  const _ChatTopBar();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14, topPadding + 14, 18, 16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x2A000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF3542A0),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'RM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reuniao de equipe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '4 membros online',
                    style: TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.participants),
                borderRadius: BorderRadius.circular(14),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed) ||
                      states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.focused)) {
                    return Colors.white.withValues(alpha: 0.18);
                  }

                  return Colors.transparent;
                }),
                child: Ink(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.groups_2_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '4',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: Ink(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                  customBorder: const CircleBorder(),
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered) ||
                        states.contains(WidgetState.focused)) {
                      return Colors.white.withValues(alpha: 0.18);
                    }

                    return Colors.transparent;
                  }),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white.withValues(alpha: 0.92),
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  final String label;

  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F8),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _SystemMessage extends StatelessWidget {
  final String text;

  const _SystemMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 290),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _MessageEntry message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isMe) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 280),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 9),
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            message.senderName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xE6FFFFFF),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          message.time,
                          style: const TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 12,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      message.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            _ParticipantAvatar(
              initials: message.senderInitials,
              color: message.avatarColor,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _ParticipantAvatar(
            initials: message.senderInitials,
            color: message.avatarColor,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 9),
              decoration: const BoxDecoration(
                color: AppColors.chatOther,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          message.senderName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        message.time,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    message.text,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantAvatar extends StatelessWidget {
  final String initials;
  final Color color;

  const _ParticipantAvatar({required this.initials, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ComposerBar extends StatefulWidget {
  const _ComposerBar();

  @override
  State<_ComposerBar> createState() => _ComposerBarState();
}

class _ComposerBarState extends State<_ComposerBar> {
  final TextEditingController _textController = TextEditingController();

  bool get _hasText => _textController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _textController
      ..removeListener(_handleTextChanged)
      ..dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 56),
                padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add_rounded,
                        color: AppColors.textSecondary,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Digite sua mensagem...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.only(bottom: 9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    IconButton(
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  _hasText ? Icons.send_rounded : Icons.mic_none_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class _ChatEntry {
  const _ChatEntry();
}

class _DateEntry extends _ChatEntry {
  final String label;

  const _DateEntry(this.label);
}

class _SystemEntry extends _ChatEntry {
  final String text;

  const _SystemEntry(this.text);
}

class _MessageEntry extends _ChatEntry {
  final String senderName;
  final String senderInitials;
  final String text;
  final String time;
  final bool isMe;
  final Color avatarColor;

  const _MessageEntry({
    required this.senderName,
    required this.senderInitials,
    required this.text,
    required this.time,
    required this.isMe,
    required this.avatarColor,
  });
}
