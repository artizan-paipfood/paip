import 'package:flutter/material.dart';
import 'package:paipfood_package/l10n/app_localizations.dart';
import 'package:paipfood_package/paipfood_package.dart' as core;
import 'package:portal/src/core/helpers/breakpoints.dart';
import 'package:ui/ui.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    // Modular.setInitialRoute(SecretPage.route);
    return ArtApp.router(
      title: 'Portal - PaipFood',
      theme: ArtThemeData(colorScheme: const ArtPaipColorScheme.light(), brightness: Brightness.light),
      darkTheme: ArtThemeData(colorScheme: const ArtPaipColorScheme.dark(), brightness: Brightness.light),
      themeMode: ThemeMode.light,
      // locale: const Locale('pt', 'BR'),
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => FlutterBreakpointProvider.builder(context: context, breakpoints: PaipBreakpoint.breakpoints, child: core.ToastProvider.builder(context, child)),

      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...core.AppLocalizations.localizationsDelegates],
      supportedLocales: core.AppLocalizations.supportedLocales,
      routerConfig: Modular.routerConfig,
    );
  }
}
