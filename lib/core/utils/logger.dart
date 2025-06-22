import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    if (kDebugMode) {
      dev.log(message);
    }
  }
}
