// ignore_for_file: cascade_invocations, avoid_print
import 'dart:io';
import 'dart:convert';

void main() {
  const inputDir = 'lib/l10n';
  const inputFile = 'lib/l10n/app_en.arb';
  const outputFile = 'lib/l10n/l10n_service.dart';

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

  final buffer = StringBuffer();

  buffer.writeln(r"""
import 'package:manager/l10n/l10n_provider.dart';
import 'package:paipfood_package/l10n/app_localizations.dart';

extension L10nStringExtension on AppLocalizations {
  String byString(String key) {
    return _map[key] ?? key;
  }
}

final Map<String, String> _map = {
""");

  for (var key in map.keys) {
    if (map[key]!.toString().contains('{')) {
      continue;
    }
    buffer.writeln('"$key": l10n.$key,\n');
  }

  buffer.writeln('};');

  File(outputFile).writeAsStringSync(buffer.toString());
  print('✅ Arquivo $outputFile gerado com sucesso!');
}
