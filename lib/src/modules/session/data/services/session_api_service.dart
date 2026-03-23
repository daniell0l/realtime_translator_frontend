import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:realtime_translator_frontend/src/core/config/pp_config.dart';

class SessionApiService {
  Future<Map<String, dynamic>> createSession({required String mode}) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/sessions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mode': mode}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro ao criar sala. Status: ${response.statusCode}. Body: ${response.body}',
      );
    }

    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> joinSession({
    required String sessionCode,
    required String name,
    required String speakLocale,
    required String listenLocale,
    required String speakCountry,
    required String listenCountry,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/sessions/join'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'sessionCode': sessionCode,
        'participant': {
          'name': name,
          'speakLocale': speakLocale,
          'listenLocale': listenLocale,
          'speakCountry': speakCountry,
          'listenCountry': listenCountry,
        },
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro ao entrar na sala. Status: ${response.statusCode}. Body: ${response.body}',
      );
    }

    return Map<String, dynamic>.from(jsonDecode(response.body));
  }
}
