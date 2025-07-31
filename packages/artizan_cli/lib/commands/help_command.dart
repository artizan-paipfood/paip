import 'package:args/command_runner.dart';

class HelpCommand extends Command<int> {
  @override
  String get description => 'Mostrar ajuda e informações da CLI';

  @override
  String get name => 'help';

  @override
  Future<int> run() async {
    printGeneralUsage();
    return 0;
  }

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
}
