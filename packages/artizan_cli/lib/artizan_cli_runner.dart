import 'package:args/command_runner.dart';
import 'package:artizan_cli/commands/feature_command.dart';
import 'package:artizan_cli/commands/version_command.dart';
import 'package:artizan_cli/commands/help_command.dart';

class ArtizanCliRunner extends CommandRunner<int> {
  ArtizanCliRunner() : super('artizan', 'Ferramenta de desenvolvimento para projetos Flutter') {
    addCommand(FeatureCommand());
    addCommand(VersionCommand());
    addCommand(HelpCommand());
  }
}
