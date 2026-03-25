import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/routes/app_routes.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_theme.dart';
import 'package:realtime_translator_frontend/src/modules/chat/presentation/pages/chat_page.dart';
import 'package:realtime_translator_frontend/src/modules/profile/profile_page.dart';
import 'package:realtime_translator_frontend/src/modules/room/create_room_page.dart';
import 'package:realtime_translator_frontend/src/modules/room/join_room_page.dart';
import 'package:realtime_translator_frontend/src/modules/room/participants_page.dart';
import 'package:realtime_translator_frontend/src/modules/welcome/page/welcome_page.dart';

void main() {
  runApp(const RoomsApp());
}

class RoomsApp extends StatelessWidget {
  const RoomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (_) => const WelcomePage(),
        AppRoutes.joinRoom: (_) => const JoinRoomPage(),
        AppRoutes.createRoom: (_) => const CreateRoomPage(),
        AppRoutes.chat: (_) => const ChatRoomPage(),
        AppRoutes.participants: (_) => const ParticipantsPage(),
        AppRoutes.profile: (_) => const ProfilePage(),
      },
    );
  }
}
