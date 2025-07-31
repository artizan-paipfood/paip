import 'package:talker/talker.dart';

class TalkerDataSerializer {
  static Map<String, dynamic> toJson(TalkerData data) {
    return {
      'message': data.message,
      'title': data.title,
      'time': data.time.toIso8601String(),
      'logLevel': data.logLevel?.toString(),
      'stackTrace': data.stackTrace?.toString(),
      'error': data.error?.toString(),
      'exception': data.exception?.toString(),
      'key': data.key,
    };
  }

  static TalkerData fromJson(Map<String, dynamic> json) {
    return TalkerData(
      json['message'] as String?,
      logLevel: _parseLogLevel(json['logLevel'] as String?),
      exception: json['exception'] != null ? Exception(json['exception'] as String) : null,
      error: json['error'] != null ? Error() : null,
      stackTrace: json['stackTrace'] != null ? StackTrace.fromString(json['stackTrace'] as String) : null,
      title: json['title'] as String?,
      time: json['time'] != null ? DateTime.parse(json['time'] as String) : null,
      key: json['key'] as String?,
    );
  }

  static LogLevel? _parseLogLevel(String? level) {
    if (level == null) return null;

    switch (level) {
      case 'LogLevel.debug':
        return LogLevel.debug;
      case 'LogLevel.error':
        return LogLevel.error;
      case 'LogLevel.info':
        return LogLevel.info;
      case 'LogLevel.warning':
        return LogLevel.warning;
      case 'LogLevel.verbose':
        return LogLevel.verbose;
      default:
        return LogLevel.info;
    }
  }
}
