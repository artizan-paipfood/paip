#!/usr/bin/env dart

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length < 2) {
    print('Uso: dart cli.dart <comando> <subcomando> [nome]');
    print('Exemplo: dart cli.dart arch feature meu_feature');
    exit(1);
  }

  final command = arguments[0];
  final subcommand = arguments[1];

  if (command == 'arch' && subcommand == 'feature') {
    if (arguments.length < 3) {
      print('Nome do feature é obrigatório!');
      print('Uso: dart cli.dart arch feature <nome_do_feature>');
      exit(1);
    }

    final featureName = arguments[2];
    createFeatureStructure(featureName);
  } else {
    print('Comando não reconhecido: $command $subcommand');
    print('Comandos disponíveis:');
    print('  arch feature <nome> - Cria estrutura de pastas para um feature');
    exit(1);
  }
}

void createFeatureStructure(String featureName) {
  print('🚀 Criando estrutura para o feature: $featureName');

  // Define o caminho base para o feature
  final basePath = 'features/$featureName';

  // Pastas que serão criadas
  final folders = [
    'lib/src/components',
    'lib/src/controllers',
    'lib/src/models',
    'lib/src/pages',
    'lib/src/usecase',
    'lib/src/viewmodels',
  ];

  try {
    // Cria o diretório base do feature
    final baseDir = Directory(basePath);
    if (baseDir.existsSync()) {
      print('❌ Feature "$featureName" já existe!');
      exit(1);
    }

    baseDir.createSync(recursive: true);
    print('✅ Diretório base criado: $basePath');

    // Cria todas as pastas
    for (final folder in folders) {
      final fullPath = '$basePath/$folder';
      final dir = Directory(fullPath);
      dir.createSync(recursive: true);
      print('✅ Pasta criada: $fullPath');

      // Cria um arquivo .gitkeep para manter as pastas no git
      final gitkeepFile = File('$fullPath/.gitkeep');
      gitkeepFile.writeAsStringSync('');
    }

    // Cria arquivo main.dart básico
    createMainDart(basePath, featureName);

    // Cria pubspec.yaml básico
    createPubspecYaml(basePath, featureName);

    // Cria analysis_options.yaml
    createAnalysisOptions(basePath);

    // Cria README.md
    createReadme(basePath, featureName);

    print('🎉 Feature "$featureName" criado com sucesso!');
    print('📁 Estrutura criada em: $basePath');
    print('\n📋 Próximos passos:');
    print('1. cd $basePath');
    print('2. flutter pub get');
    print('3. Comece a implementar seu feature!');
  } catch (e) {
    print('❌ Erro ao criar feature: $e');
    exit(1);
  }
}

void createMainDart(String basePath, String featureName) {
  final content = '''import 'package:flutter/material.dart';

void main() {
  runApp(${_pascalCase(featureName)}App());
}

class ${_pascalCase(featureName)}App extends StatelessWidget {
  const ${_pascalCase(featureName)}App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${_pascalCase(featureName)} Feature',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ${_pascalCase(featureName)}Page(),
    );
  }
}

class ${_pascalCase(featureName)}Page extends StatelessWidget {
  const ${_pascalCase(featureName)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('${_pascalCase(featureName)} Feature'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Feature ${_pascalCase(featureName)} criado com sucesso!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Comece a implementar aqui.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
''';

  final file = File('$basePath/lib/main.dart');
  file.writeAsStringSync(content);
  print('✅ Arquivo criado: $basePath/lib/main.dart');
}

void createPubspecYaml(String basePath, String featureName) {
  final content = '''name: ${_snakeCase(featureName)}
description: "Feature ${_pascalCase(featureName)} do PaipFood"
version: 1.0.0+1

environment:
  sdk: '>=3.1.0 <4.0.0'
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
''';

  final file = File('$basePath/pubspec.yaml');
  file.writeAsStringSync(content);
  print('✅ Arquivo criado: $basePath/pubspec.yaml');
}

void createAnalysisOptions(String basePath) {
  final content = '''include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    prefer_const_constructors_in_immutables: true
''';

  final file = File('$basePath/analysis_options.yaml');
  file.writeAsStringSync(content);
  print('✅ Arquivo criado: $basePath/analysis_options.yaml');
}

void createReadme(String basePath, String featureName) {
  final content = '''# ${_pascalCase(featureName)} Feature

Feature ${_pascalCase(featureName)} do sistema PaipFood.

## Estrutura

- **components/**: Componentes reutilizáveis específicos deste feature
- **controllers/**: Controladores de estado e lógica de negócio
- **models/**: Modelos de dados e entidades
- **pages/**: Páginas/telas do feature
- **usecase/**: Casos de uso e regras de negócio
- **viewmodels/**: ViewModels para gerenciamento de estado das telas

## Como executar

```bash
flutter pub get
flutter run
```

## Desenvolvimento

1. Implemente seus modelos em `lib/src/models/`
2. Crie os casos de uso em `lib/src/usecase/`
3. Desenvolva os controladores em `lib/src/controllers/`
4. Construa as páginas em `lib/src/pages/`
5. Crie componentes reutilizáveis em `lib/src/components/`
6. Gerencie estado com viewmodels em `lib/src/viewmodels/`
''';

  final file = File('$basePath/README.md');
  file.writeAsStringSync(content);
  print('✅ Arquivo criado: $basePath/README.md');
}

// Utilitários para conversão de nomes
String _pascalCase(String input) {
  return input.split('_').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '').join('');
}

String _snakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}').replaceAll(RegExp(r'^_'), '').toLowerCase();
}
