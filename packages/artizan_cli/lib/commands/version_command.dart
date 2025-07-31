import 'package:args/command_runner.dart';

class VersionCommand extends Command<int> {
  static const String _version = '1.0.0';

  @override
  String get description => 'Mostrar a versão da CLI';

  @override
  String get name => 'version';

  @override
  Future<int> run() async {
    print('Artizan CLI v$_version');
    return 0;
  }
}
