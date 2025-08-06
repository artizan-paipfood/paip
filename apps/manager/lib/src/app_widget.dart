import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:manager/l10n/gen/app_localizations.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/helpers/breakpoints.dart';
import 'package:manager/src/modules/order/presenter/components/render_image_order.dart';
import 'package:paipfood_package/paipfood_package.dart' as core;

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([core.ConfigNotifier.instance.listenable, AppI18n.instance.observer]),
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return ArtApp.router(
              routerConfig: core.Modular.routerConfig,
              title: 'Paip Food Gestor',
              themeMode: core.ThemeNotifier.instance.themeMode,
              builder: (context, child) => core.ToastProvider.builder(context, core.FlutterBreakpointProvider.builder(context: context, breakpoints: PaipBreakpoint.breakpoints, child: RenderImageProvider.builder(context, L10nProvider.builder(context, child)))),
              locale: AppI18n.instance.locale,
              theme: ArtThemeData(colorScheme: ArtPaipColorScheme.light(), brightness: Brightness.light),
              darkTheme: ArtThemeData(colorScheme: ArtPaipColorScheme.dark(), brightness: Brightness.dark),
              localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...core.AppLocalizations.localizationsDelegates],
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
