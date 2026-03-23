class ChatMessageModel {
  final String id;
  final String sessionId;
  final String senderId;
  final String senderName;
  final String originalText;
  final String translatedText;
  final String sourceLocale;
  final String targetLocale;
  final DateTime createdAt;

  ChatMessageModel({
    required this.id,
    required this.sessionId,
    required this.senderId,
    required this.senderName,
    required this.originalText,
    required this.translatedText,
    required this.sourceLocale,
    required this.targetLocale,
    required this.createdAt,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'],
      sessionId: map['sessionId'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      originalText: map['originalText'],
      translatedText: map['translatedText'],
      sourceLocale: map['sourceLocale'],
      targetLocale: map['targetLocale'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
