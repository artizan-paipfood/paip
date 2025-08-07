import 'package:address/i18n/gen/strings.g.dart';
import 'package:app/src/app_widget.dart';
import 'package:app/src/slang_wrapper.dart';
import 'package:app/src/app_module.dart';
import 'package:app/src/core/data/services/config/initialize_web_service.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SlangDartCore.initalize();
  await InitializeWebService.initialize();
  await AppI18n.initialize();
  await Modular.configure(
    appModule: AppModule(),
    initialRoute: '/address',
    debugLogDiagnostics: true,
    debugLogDiagnosticsGoRouter: true,
    debugLogEventBus: true,
  );
  // await Modular.con
  runApp(TranslationProvider(child: AppWidget()));
}
