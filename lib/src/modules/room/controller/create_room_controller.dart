import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RoomPrivacy { public, private }

class CreateRoomController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roomNameController = TextEditingController();

  late final String generatedCode;
  RoomPrivacy privacy = RoomPrivacy.public;
  bool copiedCode = false;
  Timer? _copyFeedbackTimer;

  CreateRoomController() {
    generatedCode = _generateRoomCode();
    nameController.addListener(_notifyStateChanged);
    emailController.addListener(_notifyStateChanged);
    roomNameController.addListener(_notifyStateChanged);
  }

  bool get isFormValid =>
      nameController.text.trim().isNotEmpty &&
      emailController.text.trim().isNotEmpty &&
      roomNameController.text.trim().isNotEmpty;

  void selectPrivacy(RoomPrivacy value) {
    if (privacy == value) return;

    privacy = value;
    notifyListeners();
  }

  Future<void> copyCode() async {
    await Clipboard.setData(ClipboardData(text: generatedCode));

    _copyFeedbackTimer?.cancel();
    copiedCode = true;
    notifyListeners();

    _copyFeedbackTimer = Timer(const Duration(seconds: 5), () {
      copiedCode = false;
      notifyListeners();
    });
  }

  String _generateRoomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = math.Random();
    final prefix = List.generate(
      3,
      (_) => letters[random.nextInt(letters.length)],
    ).join();
    final suffix = (1000 + random.nextInt(9000)).toString();
    return '$prefix-$suffix';
  }

  void _notifyStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _copyFeedbackTimer?.cancel();
    nameController.removeListener(_notifyStateChanged);
    emailController.removeListener(_notifyStateChanged);
    roomNameController.removeListener(_notifyStateChanged);
    nameController.dispose();
    emailController.dispose();
    roomNameController.dispose();
    super.dispose();
  }
}
