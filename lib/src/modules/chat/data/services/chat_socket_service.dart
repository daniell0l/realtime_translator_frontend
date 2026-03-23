import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:realtime_translator_frontend/src/core/config/pp_config.dart';

class ChatSocketService {
  late io.Socket socket;

  void connect() {
    socket = io.io(
      AppConfig.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
  }

  void joinRoom(String sessionId) {
    socket.emit('session:join_room', sessionId);
  }

  void sendMessage({
    required String sessionId,
    required String senderId,
    required String text,
  }) {
    socket.emit('chat:send_message', {
      'sessionId': sessionId,
      'senderId': senderId,
      'text': text,
    });
  }

  void onMessageReceived(Function(dynamic data) callback) {
    socket.on('chat:message_received', callback);
  }

  void onError(Function(dynamic data) callback) {
    socket.on('chat:error', callback);
  }

  void dispose() {
    socket.dispose();
  }
}
