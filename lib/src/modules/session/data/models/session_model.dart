class SessionModel {
  final String id;
  final String code;
  final String mode;
  final String status;
  final DateTime createdAt;

  SessionModel({
    required this.id,
    required this.code,
    required this.mode,
    required this.status,
    required this.createdAt,
  });

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'],
      code: map['code'],
      mode: map['mode'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
