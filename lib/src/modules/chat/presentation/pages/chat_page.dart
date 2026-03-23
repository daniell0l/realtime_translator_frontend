import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String sessionId;
  final String sessionCode;
  final String participantId;
  final String participantName;
  final ChatController chatController;

  const ChatPage({
    super.key,
    required this.sessionId,
    required this.sessionCode,
    required this.participantId,
    required this.participantName,
    required this.chatController,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    widget.chatController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = textController.text.trim();

    if (text.isEmpty) return;

    widget.chatController.sendMessage(
      sessionId: widget.sessionId,
      senderId: widget.participantId,
      text: text,
    );

    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.chatController;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final hasMessages = controller.messages.isNotEmpty;

          return Column(
            children: [
              _ChatHeader(sessionCode: widget.sessionCode),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: hasMessages
                            ? ListView.builder(
                                padding: const EdgeInsets.only(bottom: 12),
                                itemCount: controller.messages.length,
                                itemBuilder: (_, index) {
                                  final message = controller.messages[index];
                                  final isMe =
                                      message.senderId == widget.participantId;

                                  return _MessageBubble(
                                    senderName: message.senderName,
                                    body: message.translatedText.isNotEmpty
                                        ? message.translatedText
                                        : message.originalText,
                                    originalText: message.originalText,
                                    timestamp: _formatTime(message.createdAt),
                                    isMe: isMe,
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'Envie a primeira mensagem da sala.',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_rounded),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppColors.border),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: textController,
                                  decoration: const InputDecoration(
                                    hintText: 'Digite sua mensagem...',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onSubmitted: (_) => sendMessage(),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.sentiment_satisfied_alt_outlined,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppColors.ctaGradient,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: IconButton(
                          onPressed: sendMessage,
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ChatHeader extends StatelessWidget {
  final String sessionCode;

  const _ChatHeader({required this.sessionCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 20),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sala: #$sessionCode',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Chat em tempo real',
                    style: TextStyle(color: Color(0xE6FFFFFF), fontSize: 15),
                  ),
                ],
              ),
            ),
            const _AvatarCluster(),
          ],
        ),
      ),
    );
  }
}

class _AvatarCluster extends StatelessWidget {
  const _AvatarCluster();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 72,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: _HeaderAvatar(color: AppColors.accentPeach),
          ),
          Positioned(
            right: 18,
            child: _HeaderAvatar(color: AppColors.accentMint),
          ),
          Positioned(
            right: 36,
            child: _HeaderAvatar(color: AppColors.accentLavender),
          ),
        ],
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  final Color color;

  const _HeaderAvatar({required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.white,
      child: CircleAvatar(radius: 12, backgroundColor: color),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String senderName;
  final String body;
  final String originalText;
  final String timestamp;
  final bool isMe;

  const _MessageBubble({
    required this.senderName,
    required this.body,
    required this.originalText,
    required this.timestamp,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final rowAlignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final gradient = isMe
        ? AppColors.primaryGradient
        : const LinearGradient(
            colors: [Color(0xFFC7F3F3), Color(0xFFAEEEF0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
    final textColor = isMe ? Colors.white : const Color(0xFF20233A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: rowAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.accentMint,
              child: Icon(Icons.person, color: AppColors.textPrimary, size: 18),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: alignment,
                    children: [
                      Text(
                        senderName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        body,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.35,
                          color: textColor,
                        ),
                      ),
                      if (originalText != body) ...[
                        const SizedBox(height: 6),
                        Text(
                          originalText,
                          style: TextStyle(
                            fontSize: 12,
                            color: isMe
                                ? const Color(0xCCFFFFFF)
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: isMe
                              ? const Color(0xCCFFFFFF)
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.accentLavender,
              child: Icon(Icons.person, color: AppColors.textPrimary, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}
