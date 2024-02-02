import 'dart:developer';

class CustomLog {
  static success(dynamic message) {
    return log('\x1B[32m$message\x1B[0m');
  }

  static error(dynamic message) {
    return log('\x1B[31m$message\x1B[0m');
  }

  void warning(String msg) {
    return log('\x1B[33m$msg\x1B[0m');
  }

  static info(dynamic message) {
    return log("$message");
  }
}
