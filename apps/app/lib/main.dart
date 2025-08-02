import 'package:app/src/app_module.dart';
import 'package:app/src/app_widget.dart';
import 'package:app/src/core/data/services/config/initialize_web_service.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeWebService.initialize();
  await Modular.configure(
    appModule: AppModule(),
    initialRoute: '/address',
    debugLogDiagnostics: true,
    debugLogDiagnosticsGoRouter: true,
    debugLogEventBus: true,
  );
  // await Modular.con
  runApp(AppWidget());
}
