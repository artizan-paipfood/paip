// ignore_for_file: cascade_invocations, avoid_print
import 'dart:io';
import 'dart:convert';

void main() {
  const inputDir = 'public/l10n';
  const inputFile = 'public/l10n/app_en.arb';
  const outputFile = 'lib/l10n/i18n.dart';

  final file = File(inputFile);
  if (!file.existsSync()) {
    print('Arquivo $inputFile não encontrado!');
    return;
  }
  final Map<String, dynamic> map = json.decode(file.readAsStringSync());

  final dir = Directory(inputDir);
  if (!dir.existsSync()) {
    print('Diretório $inputDir não encontrado!');
    return;
  }

  final files = dir.listSync().whereType<File>().where((file) => file.path.contains(RegExp(r'app_([a-zA-Z_]+)\.arb')));
  final languages = files.map((file) => RegExp(r'app_([a-zA-Z_]+)\.arb').firstMatch(file.path)?.group(1)).whereType<String>().toSet();

  final buffer = StringBuffer();

  buffer.writeln("""
import 'dart:core';
import 'dart:io';
import 'dart:convert';
""");

  buffer.writeln("""
enum I18nLanguages {
${languages.map((language) => '  $language,').join('\n')}
}
""");

  buffer.writeln(r"""
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
""");

  for (var key in map.keys) {
    final regex = RegExp(r'\{(\w+)\}');
    final matches = regex.allMatches(map[key]);
    final params = matches.map((m) => "required String ${m.group(1)}").join(', ');
    final args = matches.map((m) => '"${m.group(1)}": ${m.group(1)}').join(', ');

    buffer
      ..writeln('  static String $key(String language, {$params}) {')
      ..writeln('    return _translate(language, "$key", args: {$args});')
      ..writeln('  }\n');
  }

  buffer.writeln('}');

  File(outputFile).writeAsStringSync(buffer.toString());
  print('✅ Arquivo $outputFile gerado com sucesso!');
}
