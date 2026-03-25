import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RoomPrivacy { public, private }

class CreateRoomController extends ChangeNotifier {
  final nameController = TextEditingController();
  final roomNameController = TextEditingController();

  late final String generatedCode;
  RoomPrivacy privacy = RoomPrivacy.public;

  CreateRoomController() {
    generatedCode = _generateRoomCode();
    nameController.addListener(_notifyStateChanged);
    roomNameController.addListener(_notifyStateChanged);
  }

  bool get isFormValid =>
      nameController.text.trim().isNotEmpty &&
      roomNameController.text.trim().isNotEmpty;

  void selectPrivacy(RoomPrivacy value) {
    if (privacy == value) return;

    privacy = value;
    notifyListeners();
  }

  Future<void> copyCode() {
    return Clipboard.setData(ClipboardData(text: generatedCode));
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
    nameController.removeListener(_notifyStateChanged);
    roomNameController.removeListener(_notifyStateChanged);
    nameController.dispose();
    roomNameController.dispose();
    super.dispose();
  }
}
