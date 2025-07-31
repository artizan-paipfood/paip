import 'dart:convert';

import 'package:talker/talker.dart';

class PaipTalkerLog {
  final DateTime timestamp;
  final String talkerId;
  final String? message;
  final String? title;
  final String? logLevel;
  final String? exception;
  final String? error;
  final String? stackTrace;
  final String? key;

  const PaipTalkerLog({
    required this.timestamp,
    required this.talkerId,
    this.message,
    this.title,
    this.logLevel,
    this.exception,
    this.error,
    this.stackTrace,
    this.key,
  });

  factory PaipTalkerLog.fromTalkerData(TalkerData data, String talkerId) {
    return PaipTalkerLog(
      timestamp: data.time,
      talkerId: talkerId,
      message: data.message,
      title: data.title,
      logLevel: data.logLevel?.name,
      exception: data.exception?.toString(),
      error: data.error?.toString(),
      stackTrace: data.stackTrace?.toString(),
      key: data.key,
    );
  }

  TalkerData toTalkerData() {
    LogLevel? level;
    if (logLevel != null) {
      level = LogLevel.values.firstWhere(
        (e) => e.name == logLevel,
        orElse: () => LogLevel.debug,
      );
    }

    return TalkerData(
      message,
      logLevel: level,
      exception: exception != null ? Exception(exception) : null,
      error: error != null ? Error() : null,
      stackTrace: stackTrace != null ? StackTrace.fromString(stackTrace!) : null,
      title: title,
      time: timestamp,
      key: key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'talkerId': talkerId,
      'message': message,
      'title': title,
      'logLevel': logLevel,
      'exception': exception,
      'error': error,
      'stackTrace': stackTrace,
      'key': key,
    };
  }

  factory PaipTalkerLog.fromMap(Map<String, dynamic> map) {
    return PaipTalkerLog(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      talkerId: map['talkerId'] ?? '',
      message: map['message'],
      title: map['title'],
      logLevel: map['logLevel'],
      exception: map['exception'],
      error: map['error'],
      stackTrace: map['stackTrace'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaipTalkerLog.fromJson(String source) => PaipTalkerLog.fromMap(json.decode(source));
}
