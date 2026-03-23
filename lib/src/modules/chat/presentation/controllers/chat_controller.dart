import 'package:flutter/material.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/services/chat_socket_service.dart';

class ChatController extends ChangeNotifier {
  final ChatSocketService socketService;

  ChatController(this.socketService);

  final List<ChatMessageModel> messages = [];
  bool isConnected = false;
  String? errorMessage;

  void connect({required String sessionId}) {
    socketService.connect();
    socketService.joinRoom(sessionId);

    socketService.onMessageReceived((data) {
      messages.add(ChatMessageModel.fromMap(Map<String, dynamic>.from(data)));
      notifyListeners();
    });

    socketService.onError((data) {
      errorMessage = data['message'];
      notifyListeners();
    });

    isConnected = true;
    notifyListeners();
  }

  void sendMessage({
    required String sessionId,
    required String senderId,
    required String text,
  }) {
    socketService.sendMessage(
      sessionId: sessionId,
      senderId: senderId,
      text: text,
    );
  }

  @override
  void dispose() {
    socketService.dispose();
    super.dispose();
  }
}
