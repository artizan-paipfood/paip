import 'package:flutter/foundation.dart';
import '../../../paipfood_package.dart';

class Log {
  final Logger logger;

  Log({required this.logger});

  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.d(message, error: error, stackTrace: stackTrace, time: time);
    }
  }

  void e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.e(message, error: error, stackTrace: stackTrace, time: time);
    }
  }

  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.i(message, error: error, stackTrace: stackTrace, time: time);
    }
  }

  void v(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.t(message, error: error, stackTrace: stackTrace, time: time);
    }
  }

  void w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.w(message, error: error, stackTrace: stackTrace, time: time);
    }
  }

  void wtf(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.f(message, error: error, stackTrace: stackTrace, time: time);
    }
  }
}
