import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/src/core/helpers/breakpoints.dart';
import 'package:app/src/core/helpers/i18n.dart';
import 'package:paipfood_package/paipfood_dependencies.dart';
import 'package:paipfood_package/paipfood_package.dart' as core;
import '../l10n/gen/app_localizations.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  // ErrorWidget.builder = (FlutterErrorDetails details) => CwErrorWidget(onPop: () => Modular.to.pop(), details: details);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => I18n.instance.initialize(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([core.ConfigNotifier.instance.listenable, I18n.instance]),
      builder: (context, _) {
        return PopScope(
          canPop: false,
          child: ModularApp.router(
            title: 'Paip Food',
            debugShowCheckedModeBanner: false,
            theme: core.ThemeCustom().lightTheme,
            darkTheme: core.ThemeCustom().darkTheme,
            locale: core.LanguageNotifier.instance.locale,
            themeMode: core.ThemeNotifier.instance.themeMode,
            builder: (context, child) => core.ToastProvider.builder(
              context,
              core.FlutterBreakpointProvider.builder(
                context: context,
                breakpoints: PaipBreakpoint.breakpoints,
                child: child,
              ),
            ),
            localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...core.AppLocalizations.localizationsDelegates],
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }
}
