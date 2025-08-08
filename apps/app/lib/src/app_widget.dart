import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/src/.i18n/gen/strings.g.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool _isInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
    final language = await AppI18n.initialize();
    LocaleSettings.setLocale(AppLocale.enUs);
    Future.microtask(() async => await LocaleSettings.setLocaleRaw(language));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: Listenable.merge([AppI18n.observer, UserMe.observer]),
        builder: (context, _) {
          return ArtApp.router(
            routerConfig: Modular.routerConfig,
            builder: (context, child) {
              return ModularLoader.builder(
                context,
                child,
                customModularLoader: PaipCustomLoader(),
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
            // themeMode: ThemeMode.light,
            locale: AppI18n.locale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            title: 'PaipFood App',
          );
        });
  }
}

class PaipCustomLoader extends CustomModularLoader {
  @override
  Color get backgroundColor => Colors.black.withValues(alpha: .2);

  @override
  Widget get child => Center(child: PaipLoader());
}
