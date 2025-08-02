import 'package:artizan_ui/artizan_ui.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return ArtApp.router(
      routerConfig: Modular.routerConfig,
      builder: (context, child) => ModularLoader.builder(context, child),
      theme: ArtThemeData(colorScheme: ArtGreenColorScheme.light(), brightness: Brightness.light),
      darkTheme: ArtThemeData(colorScheme: ArtPaipColorScheme.dark(), brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}
