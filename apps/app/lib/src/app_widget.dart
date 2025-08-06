import 'package:artizan_ui/artizan_ui.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/i18n/gen/strings.g.dart';
import 'package:i18n/i18n.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: ArtApp.router(
        routerConfig: Modular.routerConfig,
        builder: (context, child) {
          LocaleSettings.setLocale(AppLocale.ptBr);
          return ModularLoader.builder(
            context,
            child,
            // GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            //   onTap: () {
            //         FocusScope.of(context).unfocus();
            //       },
            //       child: child,
            //     ),
          );
        },
        theme: ArtThemeData(colorScheme: ArtOrangeColorScheme.light(), brightness: Brightness.light),
        darkTheme: ArtThemeData(colorScheme: ArtYellowColorScheme.dark(), brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        locale: AppI18n.locale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        title: 'PaipFood App',
      ),
    );
  }
}
