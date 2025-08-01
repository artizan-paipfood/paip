import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

class FeatureCommand extends Command<int> {
  FeatureCommand();

  @override
  String get description => 'Gerar uma nova feature seguindo a arquitetura estabelecida';

  @override
  String get name => 'feature';

  @override
  String get usage => '''
$description

Exemplo de uso:
  artizan feature <nome_da_feature>

Para ver a estrutura da arquitetura: artizan feature -h ou artizan feature --arch

Árvore da arquitetura gerada:

feature_name/
├── pubspec.yaml                        # Dependências e configurações do Flutter
├── build.yaml                          # Configuração do slang para internacionalização
├── analysis_options.yaml               # Regras de linting e análise de código
├── README.md                           # Documentação da feature (se existir)
├── assets/                             # Recursos estáticos (imagens, fontes, etc.)
│   └── images/                         # Imagens específicas da feature
├── lib/
│   ├── feature_name.dart               # Export principal da feature
│   ├── i18n/
│   │   ├── pt_BR.i18n.json             # Traduções em português
│   │   ├── en_US.i18n.json             # Traduções em inglês
│   │   └── gen/                        # Arquivos gerados pelo slang
│   └── src/
│       ├── feature_name_module.dart    # Módulo de injeção de dependência
│       ├── data/
│       │   ├── repositories/           # Implementações dos repositórios
│       │   ├── services/               # Serviços específicos
│       │   ├── events/                 # Eventos do EventBus
│       │   └── memory/                 # Singleton com ValueNotifier para dados em memória
│       ├── domain/
│       │   ├── models/
│       │   │   └── enums/              # Enumerações
│       │   └── usecases/               # Casos de uso
│       └── presentation/
│           ├── pages/                  # Telas/páginas
│           ├── components/             # Widgets reutilizáveis
│           └── viewmodels/             # ViewModels/Controllers
├── test/
│   └── feature_name_test.dart          # Teste principal
└── .dart_tool/                         # Cache do Dart (gerado automaticamente)
''';

  @override
  Future<int> run() async {
    if (argResults?.rest.isEmpty == true) {
      print('Erro: Nome da feature é obrigatório');
      print('Uso: artizan feature <nome_da_feature>');
      return 1;
    }

    final featureName = argResults!.rest.first;
    return await generateFeature(featureName);
  }

  @override
  void printUsage() {
    // Sobrescreve o método padrão para mostrar a arquitetura completa
    _printFeatureArchitecture();
  }

  /// Gera uma nova feature com a estrutura completa
  Future<int> generateFeature(String featureName) async {
    try {
      final currentDir = Directory.current;
      final featuresDir = Directory(path.join(currentDir.path, 'features'));

      // Verifica se a pasta features existe
      if (!featuresDir.existsSync()) {
        print('❌ Erro: A pasta "features" não existe no diretório atual');
        print('💡 Certifique-se de estar no diretório raiz do projeto ou crie a pasta "features" primeiro');
        return 1;
      }

      final featureDir = Directory(path.join(featuresDir.path, featureName));
      if (featureDir.existsSync()) {
        print('Erro: A feature "$featureName" já existe');
        return 1;
      }

      featureDir.createSync(recursive: true);

      _createFeatureStructure(featureDir, featureName);
      _createPubspecYaml(featureDir, featureName);
      _createBuildYaml(featureDir, featureName);
      _createAnalysisOptions(featureDir);
      _createModuleFile(featureDir, featureName);
      _createDirectories(featureDir, featureName);
      _createAssetsDirectory(featureDir);
      _createTestDirectory(featureDir, featureName);
      _createI18nStructure(featureDir, featureName);

      print('✅ Feature "$featureName" criada com sucesso!');
      print('📁 Localização: ${featureDir.path}');

      // Executar flutter pub get automaticamente
      await _runFlutterPubGet(featureDir);

      // Executar dart run slang para gerar arquivos de tradução
      await _runSlangBuild(featureDir);

      print('🚀 Próximos passos:');
      print('   1. cd features/$featureName');
      print('   2. Implemente sua feature seguindo a arquitetura estabelecida');

      return 0;
    } catch (e) {
      print('❌ Erro ao criar feature: $e');
      return 1;
    }
  }

  void _printFeatureArchitecture() {
    print('''
📁 Estrutura da Arquitetura de Features:

feature_name/                           # Pasta raiz da feature
├── 📄 pubspec.yaml                        # Dependências e configurações do Flutter
├── 📄 build.yaml                          # Configuração do slang para internacionalização
├── 📄 analysis_options.yaml               # Regras de linting e análise de código
├── 📄 README.md                           # Documentação da feature (se existir)
├── 📁 assets/                             # Recursos estáticos (imagens, fontes, etc.)
│   └── 📁 images/                         # Imagens específicas da feature
├── 📁 lib/                                # Código fonte da feature
│   ├── 📄 feature_name.dart               # Arquivo de export principal da feature
│   ├── 📁 i18n/                           # Arquivos de internacionalização
│   │   ├── 📄 pt_BR.i18n.json             # Traduções em português
│   │   ├── 📄 en_US.i18n.json             # Traduções em inglês
│   │   └── 📁 gen/                        # Arquivos gerados automaticamente pelo slang
│   └── 📁 src/                            # Código fonte principal
│       ├── 📄 feature_name_module.dart    # Módulo de injeção de dependência
│       ├── 📁 data/                       # Camada de dados (Clean Architecture)
│       │   ├── 📁 repositories/           # Implementações dos repositórios
│       │   ├── 📁 services/               # Serviços específicos da feature
│       │   ├── 📁 events/                 # Eventos do EventBus
│       │   └── 📁 memory/                 # Singleton com ValueNotifier para dados em memória
│       ├── 📁 domain/                     # Camada de domínio (Clean Architecture)
│       │   ├── 📁 models/                 # Modelos de dados
│       │   │   └── 📁 enums/              # Enumerações
│       │   └── 📁 usecases/               # Casos de uso da feature
│       ├── 📁 presentation/               # Camada de apresentação (Clean Architecture)
│       │   ├── 📁 pages/                  # Telas/páginas da feature
│       │   ├── 📁 components/             # Widgets reutilizáveis
│       │   └── 📁 viewmodels/             # ViewModels/Controllers
├── 📁 test/                               # Testes da feature
│   └── 📄 feature_name_test.dart          # Arquivo de teste principal
└── 📁 .dart_tool/                         # Cache do Dart (gerado automaticamente)

📋 Explicação dos Usos:

📄 Arquivos de Configuração:
- pubspec.yaml: Define dependências, versões e configurações do Flutter
- build.yaml: Configura o slang para gerar arquivos de tradução automaticamente
- analysis_options.yaml: Define regras de qualidade de código e linting

📁 Estrutura Clean Architecture:
- data/: Implementações concretas (APIs, banco de dados, repositórios, memory)
- domain/: Regras de negócio, modelos e casos de uso (independente de framework)
- presentation/: Interface do usuário, widgets e lógica de apresentação

🌍 Internacionalização:
- i18n/: Arquivos JSON com traduções em diferentes idiomas
- gen/: Arquivos gerados automaticamente pelo slang para uso no código

🧪 Testes:
- test/: Testes unitários, de widget e de integração da feature

📦 Módulo:
- feature_name_module.dart: Configuração de injeção de dependência para a feature

🎨 Assets:
- assets/: Recursos estáticos como imagens, ícones e fontes específicas da feature

📊 Memory:
- data/memory/: Singleton com ValueNotifier para manipular dados em memória

🚀 Events:
- data/events/: Eventos do EventBus para comunicação entre componentes
''');
  }

  Future<void> _runFlutterPubGet(Directory featureDir) async {
    try {
      print('📦 Executando flutter pub get...');

      final result = await Process.run('flutter', ['pub', 'get'], workingDirectory: featureDir.path, runInShell: true);

      if (result.exitCode == 0) {
        print('✅ flutter pub get executado com sucesso!');
      } else {
        print('⚠️  flutter pub get falhou: ${result.stderr}');
        print('💡 Execute manualmente: cd ${featureDir.path} && flutter pub get');
      }
    } catch (e) {
      print('⚠️  Erro ao executar flutter pub get: $e');
      print('💡 Execute manualmente: cd ${featureDir.path} && flutter pub get');
    }
  }

  Future<void> _runSlangBuild(Directory featureDir) async {
    try {
      print('🌍 Executando dart run slang...');

      final result = await Process.run('dart', ['run', 'slang'], workingDirectory: featureDir.path, runInShell: true);

      if (result.exitCode == 0) {
        print('✅ dart run slang executado com sucesso!');
      } else {
        print('⚠️  dart run slang falhou: ${result.stderr}');
        print('💡 Execute manualmente: cd ${featureDir.path} && dart run slang');
      }
    } catch (e) {
      print('⚠️  Erro ao executar dart run slang: $e');
      print('💡 Execute manualmente: cd ${featureDir.path} && dart run slang');
    }
  }

  void _createFeatureStructure(Directory featureDir, String featureName) {
    print('📁 Criando estrutura de diretórios...');
  }

  void _createPubspecYaml(Directory featureDir, String featureName) {
    final pubspecContent = '''name: $featureName
description: "Feature $featureName do projeto PaipFood."

publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.8

  core:
    path: ../../packages/core
  core_flutter:
    path: ../../packages/core_flutter
  artizan_ui:
    path: ../../../artizan_ui
  ui:
    path: ../../packages/ui
  i18n:
    path: ../i18n


dev_dependencies:
  flutter_test:
    sdk: flutter
  slang_build_runner: ^4.7.0
  build_runner: ^2.5.2
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/
''';

    final pubspecFile = File(path.join(featureDir.path, 'pubspec.yaml'));
    pubspecFile.writeAsStringSync(pubspecContent);
    print('📄 pubspec.yaml criado');
  }

  void _createBuildYaml(Directory featureDir, String featureName) {
    final buildContent = '''targets:
  \$default:
    builders:
      slang_build_runner:
        options:
          base_locale: en_US
          fallback_strategy: base_locale
          input_directory: lib/i18n
          input_file_pattern: .i18n.json
          string_interpolation: braces
          output_directory: lib/i18n/gen
          namespaces: false
          locale_handling: true
          flutter_integration: true
          generate_enum: false
          ${_toPascalCase(featureName)}Language:
            default_parameter: language
            generate_enum: false
''';

    final buildFile = File(path.join(featureDir.path, 'build.yaml'));
    buildFile.writeAsStringSync(buildContent);
    print('📄 build.yaml criado');
  }

  void _createAnalysisOptions(Directory featureDir) {
    final analysisContent = '''include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - build/**
    - assets/**
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  language:
    strict-inference: false
    strict-raw-types: false
  errors:
    deprecated_member_use: ignore
    missing_required_param: error
    missing_return: error

linter:
  rules:
    avoid_print: true
    always_use_package_imports: false
    prefer_single_quotes: false
    avoid_empty_else: true
    empty_statements: true
    unnecessary_statements: true
    always_declare_return_types: true
    always_put_required_named_parameters_first: true
    constant_identifier_names: true
    prefer_interpolation_to_compose_strings: true
    unnecessary_parenthesis: true
    unawaited_futures: true
    use_key_in_widget_constructors: true
    curly_braces_in_flow_control_structures: true
    avoid_redundant_argument_values: true
    avoid_unnecessary_containers: true
    sized_box_for_whitespace: true
    use_colored_box: true
    use_decorated_box: true
    cascade_invocations: true
    prefer_adjacent_string_concatenation: true
    prefer_final_locals: true
    unnecessary_lambdas: false
    avoid_relative_lib_imports: true
    implementation_imports: true
''';

    final analysisFile = File(path.join(featureDir.path, 'analysis_options.yaml'));
    analysisFile.writeAsStringSync(analysisContent);
    print('📄 analysis_options.yaml criado');
  }

  void _createModuleFile(Directory featureDir, String featureName) {
    final moduleContent = '''import 'package:core_flutter/core_flutter.dart';

class ${_toPascalCase(featureName)}Module extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [];
}
''';

    final moduleFile = File(path.join(featureDir.path, 'lib', 'src', '${featureName}_module.dart'));
    moduleFile.parent.createSync(recursive: true);
    moduleFile.writeAsStringSync(moduleContent);
    print('📄 lib/src/${featureName}_module.dart criado');
  }

  void _createDirectories(Directory featureDir, String featureName) {
    final libDir = Directory(path.join(featureDir.path, 'lib'));
    final srcDir = Directory(path.join(libDir.path, 'src'));

    // Criar estrutura de pastas seguindo Clean Architecture
    final directories = [
      // Data layer
      path.join(srcDir.path, 'data', 'repositories'),
      path.join(srcDir.path, 'data', 'memory'),
      path.join(srcDir.path, 'data', 'services'),
      path.join(srcDir.path, 'data', 'events'),

      // Domain layer
      path.join(srcDir.path, 'domain', 'models', 'enums'),
      path.join(srcDir.path, 'domain', 'usecases'),

      // Presentation layer
      path.join(srcDir.path, 'presentation', 'pages'),
      path.join(srcDir.path, 'presentation', 'components'),
      path.join(srcDir.path, 'presentation', 'viewmodels'),
    ];

    for (final dir in directories) {
      Directory(dir).createSync(recursive: true);
    }

    // Criar arquivo de export principal
    final exportContent = '''// Export principal da feature ${_toPascalCase(featureName)}
export 'src/${featureName}_module.dart';
''';

    final exportFile = File(path.join(libDir.path, '$featureName.dart'));
    exportFile.writeAsStringSync(exportContent);
    print('📄 lib/$featureName.dart criado');
    print('📁 Estrutura de diretórios criada (data, domain, presentation, services, events)');
  }

  void _createAssetsDirectory(Directory featureDir) {
    final assetsDir = Directory(path.join(featureDir.path, 'assets'));
    assetsDir.createSync(recursive: true);
    print('📁 Diretório assets criado');
  }

  void _createTestDirectory(Directory featureDir, String featureName) {
    final testDir = Directory(path.join(featureDir.path, 'test'));
    testDir.createSync(recursive: true);

    final testContent = '''import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${_toPascalCase(featureName)} Tests', () {
    test('should create feature module', () {
      // TODO: Implementar testes
      expect(true, isTrue);
    });
  });
}
''';

    final testFile = File(path.join(testDir.path, '${featureName}_test.dart'));
    testFile.writeAsStringSync(testContent);
    print('📁 Diretório test criado com arquivo de teste');
  }

  void _createI18nStructure(Directory featureDir, String featureName) {
    final libDir = Directory(path.join(featureDir.path, 'lib'));
    final i18nDir = Directory(path.join(libDir.path, 'i18n'));
    i18nDir.createSync(recursive: true);

    // Criar arquivo JSON para português
    final ptBrContent = '''{
  "welcome": "Bem-vindo à feature ${_toPascalCase(featureName)}"
}''';

    final ptBrFile = File(path.join(i18nDir.path, 'pt_BR.i18n.json'));
    ptBrFile.writeAsStringSync(ptBrContent);

    // Criar arquivo JSON para inglês
    final enUsContent = '''{
  "welcome": "Welcome to ${_toPascalCase(featureName)} feature"
}''';

    final enUsFile = File(path.join(i18nDir.path, 'en_US.i18n.json'));
    enUsFile.writeAsStringSync(enUsContent);

    print('📁 Estrutura i18n criada (pt_BR.i18n.json, en_US.i18n.json)');
  }

  String _toPascalCase(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
