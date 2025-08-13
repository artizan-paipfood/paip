import 'dart:core';
import 'dart:io';
import 'dart:convert';

enum I18nLanguages {
  pt_BR,
  en,
}

class I18n {
  static I18n? _instance;
  I18n._();
  static I18n get instance => _instance ??= I18n._();

  final Map<String, Map<String, String>> _map = {};

  void initialize() {
    for (var language in I18nLanguages.values) {
      final path = "public/l10n/app_${language.name}.arb";
      final file = File(path);
      if (file.existsSync()) {
        final Map<String, dynamic> map = json.decode(file.readAsStringSync());
        _map[language.name] = map.cast<String, String>();
      }
    }
  }

  static String _getTextBylanguage(String language, String key) {
    final map = instance._map[language];
    return map?[key] ?? key;
  }

  static String _translate(String language, String key, {Map<String, dynamic>? args}) {
    String template = _getTextBylanguage(language, key);

    final regex = RegExp(r'\{(\w+)\}');
    final matches = regex.allMatches(template);

    for (var match in matches) {
      final String param = match.group(1)!;
      final String replacement = args?[param]?.toString() ?? '{$param}';
      template = template.replaceAll('{$param}', replacement);
    }

    return template;
  }

  static String testI18n(String language, {required String name}) {
    return _translate(language, "testI18n", args: {"name": name});
  }

  static String yourVerificationCodeIs(String language, {required String code}) {
    return _translate(language, "yourVerificationCodeIs", args: {"code": code});
  }
}
