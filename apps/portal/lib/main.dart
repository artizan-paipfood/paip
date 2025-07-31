import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';

import './src/app_module.dart';
import './src/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configura a estratégia de URL
  setUrlStrategy(PathUrlStrategy());

  // Inicializa as configurações
  await ConfigNotifier.instance.initialize();

  // Inicializa e limpa o Isar
  // Configura o Modular
  // Modular.configure(appModule: AppModule(), initialRoute: Routes.changelog(project: ChangelogProject.gest) + '?language=pt-br');
  Modular.configure(appModule: AppModule(), initialRoute: Routes.home);

  return runApp(AppWidget());
}
