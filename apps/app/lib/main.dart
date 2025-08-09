import 'package:app/src/_i18n/gen/strings.g.dart';
import 'package:app/src/app_module.dart';
import 'package:app/src/core/data/services/config/initialize_web_service.dart';
import 'package:app/src/slang_wrapper.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa tradução
  await SlangDartCore.initalize();
  final language = await AppI18n.initialize();
  await LocaleSettings.setLocaleRaw(language);

  // Demais serviços
  await InitializeWebService.initialize();
  await AuthSetup.setup(expiration: const Duration(days: 365));

  await Modular.configure(
    appModule: AppModule(),
    initialRoute: '/',
    debugLogDiagnostics: true,
    debugLogDiagnosticsGoRouter: true,
    debugLogEventBus: true,
  );

  runApp(SlangWrapperAppWidget());
}
