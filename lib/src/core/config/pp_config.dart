import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseUrl =>
      kIsWeb ? 'http://localhost:3333' : 'http://10.0.2.2:3333';

  static String get socketUrl =>
      kIsWeb ? 'http://localhost:3333' : 'http://10.0.2.2:3333';
}
