import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:meta_seo/meta_seo.dart';
import 'package:app/src/app_module.dart';
import 'package:app/src/app_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigNotifier.instance.initialize();

  if (kIsWeb) {
    usePathUrlStrategy();
    MetaSEO().config();
  }

  Animate.restartOnHotReload = true;

  await Modular.configure(
    appModule: AppModule(),
    delayDisposeMilliseconds: 1000,
    initialRoute: '/login',
    debugLogDiagnostics: true,
    debugLogDiagnosticsGoRouter: true,
    pageTransition: PageTransition.fade,
  );

  runApp(AppWidget());
}
