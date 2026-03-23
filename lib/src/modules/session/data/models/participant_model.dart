class ParticipantModel {
  final String id;
  final String sessionId;
  final String name;
  final String speakLocale;
  final String listenLocale;
  final String speakCountry;
  final String listenCountry;

  ParticipantModel({
    required this.id,
    required this.sessionId,
    required this.name,
    required this.speakLocale,
    required this.listenLocale,
    required this.speakCountry,
    required this.listenCountry,
  });

  factory ParticipantModel.fromMap(Map<String, dynamic> map) {
    return ParticipantModel(
      id: map['id'],
      sessionId: map['sessionId'],
      name: map['name'],
      speakLocale: map['speakLocale'],
      listenLocale: map['listenLocale'],
      speakCountry: map['speakCountry'],
      listenCountry: map['listenCountry'],
    );
  }
}
