#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:io';

class SlangGenerator {
  static const String _pubspecPath = 'pubspec.yaml';
  static const String _outputPath = 'lib/src/slang_wrapper.dart';

  static Future<void> generateSlangWrapper() async {
    try {
      print('🚀 Iniciando geração do slang_wrapper.dart...');

      // Ler o pubspec.yaml
      final pubspecFile = File(_pubspecPath);
      if (!await pubspecFile.exists()) {
        print('❌ Erro: pubspec.yaml não encontrado');
        return;
      }

      final pubspecContent = await pubspecFile.readAsString();

      // Extrair o nome do projeto
      final nameMatch = RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(pubspecContent);
      if (nameMatch == null) {
        print('❌ Erro: Não foi possível encontrar o nome do projeto no pubspec.yaml');
        return;
      }
      final projectName = nameMatch.group(1)!.trim();
      print('🏷️ Nome do projeto: $projectName');

      // Extrair dependências com path que tenham lib/i18n
      final dependencies = _extractDependenciesWithI18n(pubspecContent);
      if (dependencies.isEmpty) {
        print('⚠️ Nenhuma dependência com lib/i18n encontrada');
        return;
      }

      // Gerar o conteúdo do slang_wrapper.dart
      final wrapperContent = _generateWrapperContent(projectName, dependencies);

      // Escrever o arquivo
      final outputFile = File(_outputPath);
      await outputFile.writeAsString(wrapperContent);

      print('✅ slang_wrapper.dart gerado com sucesso!');
      print('📁 Arquivo criado em: $_outputPath');
      print('📦 Dependências processadas: ${dependencies.length}');
    } catch (e) {
      print('❌ Erro ao gerar slang_wrapper.dart: $e');
    }
  }

  static List<String> _extractDependenciesWithI18n(String pubspecContent) {
    final dependencies = <String>[];

    // Extrair dependências com path (incluindo comentários)
    final pathRegex = RegExp(r'^\s*(\w+):\s*(?:#.*\n\s*)?path:\s*([^\s]+)', multiLine: true);
    final matches = pathRegex.allMatches(pubspecContent);

    for (final match in matches) {
      final packageName = match.group(1)!;
      final path = match.group(2)!;

      // Verificar se tem # ignore-slang na linha do package
      final packageLineStart = pubspecContent.lastIndexOf('\n', match.start) + 1;
      final packageLineEnd = pubspecContent.indexOf('\n', packageLineStart);
      final packageLine = pubspecContent.substring(packageLineStart, packageLineEnd == -1 ? pubspecContent.length : packageLineEnd);

      if (packageLine.contains('# ignore-slang')) {
        print('⏭️ Ignorando: $packageName (marcado com # ignore-slang)');
        continue;
      }

      print('🔍 Verificando: $packageName -> $path');

      // Verificar se existe lib/i18n no package
      final i18nPath = '$path/lib/i18n';
      final i18nDir = Directory(i18nPath);

      if (i18nDir.existsSync()) {
        print('✅ Encontrado lib/i18n em: $packageName');
        dependencies.add(packageName);
      } else {
        print('❌ lib/i18n não encontrado em: $packageName');
      }
    }

    return dependencies;
  }

  static String _generateWrapperContent(String projectName, List<String> dependencies) {
    final buffer = StringBuffer();

    // Imports
    for (final dependency in dependencies) {
      buffer.writeln("import 'package:$dependency/i18n/gen/strings.g.dart' as $dependency;");
    }
    buffer.writeln("import 'package:$projectName/i18n/gen/strings.g.dart';");
    buffer.writeln("import 'package:$projectName/src/app_widget.dart';");
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln();

    // Classe
    buffer.writeln('class SlangWrapperAppWidget extends StatelessWidget {');
    buffer.writeln('  const SlangWrapperAppWidget({');
    buffer.writeln('    super.key,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context) {');
    buffer.writeln('    return //');

    // TranslationProviders aninhados (incluindo o do próprio app)
    String nestedProviders = 'AppWidget()';
    for (int i = dependencies.length - 1; i >= 0; i--) {
      final dependency = dependencies[i];
      nestedProviders = '$dependency.TranslationProvider(child: $nestedProviders)';
    }
    // Adicionar o TranslationProvider do próprio app
    nestedProviders = 'TranslationProvider(child: $nestedProviders)';

    buffer.writeln('        $nestedProviders;');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}

void main() async {
  print('🎯 Gerador de Slang Wrapper');
  print('============================');
  await SlangGenerator.generateSlangWrapper();
}
