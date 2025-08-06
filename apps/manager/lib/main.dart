// ignore_for_file: cascade_invocations

import 'dart:io';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18n/gen/strings.g.dart';
import 'package:manager/src/core/components/sidebar/sidebar.dart';
import 'package:manager/src/core/components/sidebar/sidebar_route_observer.dart';
import 'package:manager/src/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/services/http_permision_service.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';
import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppI18n.instance.initialize();

  if (kIsWeb) setUrlStrategy(PathUrlStrategy());
  if (isWindows) {
    await windowManager.ensureInitialized();
    const WindowOptions windowOptions = WindowOptions(titleBarStyle: TitleBarStyle.normal);
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    await windowManager.setTitle('Paip Food Manager');
    HttpOverrides.global = HttpPermisionService();
  }
  await LocalStorageHive.init(Helpers.collections);
  if (isAndroid) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    ScreenService.setFullScreen();
  }

  await ConfigNotifier.instance.initialize();
  if (Env.isDev) Future.delayed(2.seconds, () => toast.showInfo("AMBIENTE DE DESENVOLVIMENTO", subtitle: "Atenção", duration: 10.seconds, alignment: Alignment.topCenter));
  Animate.restartOnHotReload = true; // flutter_animate
  await WakelockPlus.enable();
  await Modular.configure(appModule: AppModule(), initialRoute: Routes.splash, debugLogDiagnosticsGoRouter: true, observers: [SidebarRouteObserver(sidebarController: SidebarController.instance)]);
  await SentryFlutter.init((options) {
    options.dsn = 'https://8b7e958a9f797c217db0de79da9ef37e@o4509287819247616.ingest.us.sentry.io/4509287820492800';
    options.beforeSend = (event, hint) {
      if (event.exceptions?.isNotEmpty == true && event.exceptions![0].type == 'GenericError') {
        return null;
      }

      return event;
    };
    options.tracesSampleRate = 1.0;
    options.attachViewHierarchy = true;
    options.enableUserInteractionTracing = true;
    options.enableUserInteractionBreadcrumbs = true;
    options.maxBreadcrumbs = 100;
    options.attachScreenshot = false;
    options.attachViewHierarchy = false;

    // if (!isWeb) {
    //   options.experimental.replay.sessionSampleRate = 0.1;
    //   options.experimental.replay.onErrorSampleRate = 1.0;
    //   options.experimental.privacy.maskAllText = false;
    //   options.experimental.privacy.maskAllImages = false;
    // }

    options.sendDefaultPii = true;
    options.debug = Env.isDev;
  }, appRunner: () => runApp(SentryWidget(child: TranslationProvider(child: AppWidget()))));
}
