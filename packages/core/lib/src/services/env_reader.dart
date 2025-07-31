import 'dart:io';

class EnvReader {
  static final Map<String, String> _envVars = {};

  static Future<void> loadEnvFile(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception('.env file not found at path: $path');
    }

    final lines = await file.readAsLines();

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;

      final index = line.indexOf('=');
      if (index == -1) continue;

      final key = line.substring(0, index).trim();
      var value = line.substring(index + 1).trim();

      if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
        value = value.substring(1, value.length - 1);
      }

      _envVars[key] = value;
    }
  }

  static String? loadString(String key, {String? fallback}) {
    if (_envVars.isEmpty) return null;
    return _envVars[key] ?? fallback;
  }

  static bool? loadBool(String key, {bool? fallback}) {
    if (_envVars.isEmpty) return null;
    final value = _envVars[key];
    if (value == null) return fallback;
    return value.toLowerCase() == 'true';
  }

  static num? loadNum(String key, {num? fallback}) {
    if (_envVars.isEmpty) return null;
    final value = _envVars[key];
    if (value == null) return fallback;
    return num.tryParse(value) ?? fallback;
  }

  static String getOrThrow(String key) {
    final value = _envVars[key];
    if (value == null) {
      throw Exception('Env variable $key not found.');
    }
    return value;
  }
}
