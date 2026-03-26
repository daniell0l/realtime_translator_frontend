import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_page_header.dart';

class ParticipantsPage extends StatefulWidget {
  const ParticipantsPage({super.key});

  @override
  State<ParticipantsPage> createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage> {
  static const double _designWidth = 380;
  static const String _roomCode = 'ABC-1234';
  Timer? _copyFeedbackTimer;
  bool _copied = false;

  @override
  void dispose() {
    _copyFeedbackTimer?.cancel();
    super.dispose();
  }

  Future<void> _handleCopyCode() async {
    await Clipboard.setData(const ClipboardData(text: _roomCode));

    _copyFeedbackTimer?.cancel();

    if (!mounted) return;

    setState(() => _copied = true);

    _copyFeedbackTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final participants = <_ParticipantItem>[
      const _ParticipantItem(
        initials: 'V',
        name: 'Voce',
        online: true,
        avatarColor: Color(0xFFFF7C8A),
        isHost: true,
        highlighted: true,
      ),
      const _ParticipantItem(
        initials: 'AS',
        name: 'Ana Silva',
        online: true,
        avatarColor: Color(0xFF8B6CF6),
      ),
      const _ParticipantItem(
        initials: 'CL',
        name: 'Carlos Lima',
        online: true,
        avatarColor: AppColors.cyan,
      ),
      const _ParticipantItem(
        initials: 'MC',
        name: 'Marina Costa',
        online: false,
        avatarColor: Color(0xFF8B6CF6),
      ),
      const _ParticipantItem(
        initials: 'JP',
        name: 'Joao Pedro',
        online: true,
        avatarColor: Color(0xFFFFB84D),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final layoutWidth = math.min(constraints.maxWidth, 380.0);
          final scale = layoutWidth / _designWidth;

          return Column(
            children: [
              AppPageHeader(
                scale: scale,
                title: 'Participantes',
                subtitle: '4 online - 5 total',
                onBack: () => Navigator.pop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24 * scale,
                    24 * scale,
                    24 * scale,
                    28 * scale,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: layoutWidth,
                      child: Column(
                        children: [
                          AppCard(
                            padding: EdgeInsets.fromLTRB(
                              24 * scale,
                              18 * scale,
                              18 * scale,
                              18 * scale,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Codigo da sala',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 15 * scale,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 6 * scale),
                                      Text(
                                        _roomCode,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 22 * scale,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12 * scale),
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: 52 * scale,
                                    height: 52 * scale,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(
                                        18 * scale,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x33735AF4),
                                          blurRadius: 18,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                        18 * scale,
                                      ),
                                      onTap: _handleCopyCode,
                                      child: Icon(
                                        _copied
                                            ? Icons.check_rounded
                                            : Icons.copy_all_outlined,
                                        color: Colors.white,
                                        size: 24 * scale,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24 * scale),
                          AppCard(
                            padding: EdgeInsets.fromLTRB(
                              18 * scale,
                              18 * scale,
                              18 * scale,
                              18 * scale,
                            ),
                            child: Column(
                              children: [
                                for (
                                  var i = 0;
                                  i < participants.length;
                                  i++
                                ) ...[
                                  _ParticipantTile(
                                    participant: participants[i],
                                    scale: scale,
                                  ),
                                  if (i != participants.length - 1)
                                    SizedBox(height: 14 * scale),
                                ],
                              ],
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

class _ParticipantTile extends StatelessWidget {
  final _ParticipantItem participant;
  final double scale;

  const _ParticipantTile({required this.participant, required this.scale});

  @override
  Widget build(BuildContext context) {
    final cardColor = participant.highlighted
        ? const Color(0xFFF3F4FF)
        : Colors.transparent;
    final borderColor = participant.highlighted
        ? const Color(0xFFB9C2FF)
        : Colors.transparent;
    final statusColor = participant.online
        ? const Color(0xFF19C37D)
        : const Color(0xFF6B7280);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 14 * scale,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: borderColor, width: 1.4),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: participant.avatarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  participant.initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 12 * scale,
                  height: 12 * scale,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        participant.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (participant.isHost) ...[
                      SizedBox(width: 6 * scale),
                      Icon(
                        Icons.workspace_premium_rounded,
                        size: 16 * scale,
                        color: const Color(0xFFFF6B8A),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 2 * scale),
                Text(
                  participant.online ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (participant.isHost)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scale,
                vertical: 6 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEDF2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Lider',
                style: TextStyle(
                  color: const Color(0xFFFF6B8A),
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ParticipantItem {
  final String initials;
  final String name;
  final bool online;
  final Color avatarColor;
  final bool isHost;
  final bool highlighted;

  const _ParticipantItem({
    required this.initials,
    required this.name,
    required this.online,
    required this.avatarColor,
    this.isHost = false,
    this.highlighted = false,
  });
}
