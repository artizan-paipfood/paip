import 'package:args/args.dart';

/// Classe principal da CLI Artizan
/// Responsável apenas pela coordenação geral e informações da versão
class ArtizanCLI {
  static const String _version = '1.0.0';

  /// Versão atual da CLI
  static String get version => _version;

  /// Exibe a mensagem de uso geral da CLI
  static void printGeneralUsage() {
    print('''
Artizan CLI - Ferramenta de desenvolvimento para projetos Flutter

Uso: artizan <comando> [opções]

Comandos disponíveis:
  feature    Gerar uma nova feature seguindo a arquitetura estabelecida
  version    Mostrar a versão da CLI
  help       Mostrar esta mensagem de ajuda

Exemplo:
  artizan feature auth
  artizan feature user_profile
  artizan feature -h
''');
  }

  /// Ponto de entrada principal da CLI
  /// Responsável apenas pelo parsing básico e redirecionamento para help/comandos
  static void main(List<String> arguments) {
    final parser =
        ArgParser()
          ..addFlag('h', help: 'Mostrar ajuda', negatable: false)
          ..addCommand('feature', ArgParser()..addFlag('h', help: 'Mostrar ajuda', negatable: false))
          ..addCommand('version')
          ..addCommand('help');

    try {
      final results = parser.parse(arguments);

      // Se foi passado --h no nível global, mostra help
      if (results['h'] == true) {
        printGeneralUsage();
        return;
      }

      // Se o comando é 'help', mostra help
      if (results.command?.name == 'help') {
        printGeneralUsage();
        return;
      }

      // Se não há comando especificado, mostra help
      if (results.command == null) {
        printGeneralUsage();
        return;
      }

      // Para outros comandos, apenas mostra que devem ser usados via runner
      print('Use: artizan <comando>');
      print('Para ver comandos disponíveis: artizan --help');
    } catch (e) {
      // Se houver erro no parsing, mostra help
      printGeneralUsage();
    }
  }
}
