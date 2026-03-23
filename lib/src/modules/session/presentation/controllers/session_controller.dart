import 'package:flutter/material.dart';
import '../../data/models/participant_model.dart';
import '../../data/models/session_model.dart';
import '../../data/services/session_api_service.dart';

class SessionController extends ChangeNotifier {
  final SessionApiService apiService;

  SessionController(this.apiService);

  SessionModel? session;
  ParticipantModel? participant;
  bool isLoading = false;
  String? errorMessage;

  Future<void> createSession() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await apiService.createSession(mode: 'chat');
      session = SessionModel.fromMap(result);
    } catch (error) {
      errorMessage = 'Erro ao criar sala. ${error.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinSession({
    required String sessionCode,
    required String name,
    required String speakLocale,
    required String listenLocale,
    required String speakCountry,
    required String listenCountry,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await apiService.joinSession(
        sessionCode: sessionCode,
        name: name,
        speakLocale: speakLocale,
        listenLocale: listenLocale,
        speakCountry: speakCountry,
        listenCountry: listenCountry,
      );

      session = SessionModel.fromMap(result['session']);
      participant = ParticipantModel.fromMap(result['participant']);
    } catch (error) {
      errorMessage = 'Erro ao entrar na sala. ${error.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
