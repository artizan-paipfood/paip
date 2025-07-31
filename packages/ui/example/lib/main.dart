import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatefulWidget {
  const WidgetbookApp({super.key});

  @override
  State<WidgetbookApp> createState() => _WidgetbookAppState();
}

class _WidgetbookAppState extends State<WidgetbookApp> {
  @override
  Widget build(BuildContext context) {
    return ArtApp.material(
      theme: UiThemeData(colorScheme: const ShadPaipColorScheme.light(), brightness: Brightness.light),
      darkTheme: UiThemeData(colorScheme: const ShadPaipColorScheme.dark(), brightness: Brightness.dark),
      builder: (context, child) => Widgetbook.cupertino(
        directories: directories,
        addons: [
          DeviceFrameAddon(
            initialDevice: Devices.ios.iPhone13Mini,
            devices: [
              Devices.ios.iPhone13Mini,
              Devices.android.samsungGalaxyA50,
              Devices.ios.iPadPro11Inches,
            ],
          ),
          ThemeAddon<UiThemeData>(
            themes: [
              WidgetbookTheme(name: 'Paip Light', data: UiThemeData(colorScheme: const ShadPaipColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Paip Dark', data: UiThemeData(colorScheme: const ShadPaipColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Zinc Light', data: UiThemeData(colorScheme: const ShadZincColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Zinc Dark', data: UiThemeData(colorScheme: const ShadZincColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Blue Light', data: UiThemeData(colorScheme: const ShadBlueColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Blue Dark', data: UiThemeData(colorScheme: const ShadBlueColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Gray Light', data: UiThemeData(colorScheme: const ShadBlueColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Gray Dark', data: UiThemeData(colorScheme: const ShadBlueColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Green Light', data: UiThemeData(colorScheme: const ShadGreenColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Green Dark', data: UiThemeData(colorScheme: const ShadGreenColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Neutral Light', data: UiThemeData(colorScheme: const ShadNeutralColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Neutral Dark', data: UiThemeData(colorScheme: const ShadNeutralColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Orange Light', data: UiThemeData(colorScheme: const ShadOrangeColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Orange Dark', data: UiThemeData(colorScheme: const ShadOrangeColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Red Light', data: UiThemeData(colorScheme: const ShadRedColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Red Dark', data: UiThemeData(colorScheme: const ShadRedColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Rose Light', data: UiThemeData(colorScheme: const ShadRoseColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Rose Dark', data: UiThemeData(colorScheme: const ShadRoseColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Stone Light', data: UiThemeData(colorScheme: const ShadStoneColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Stone Dark', data: UiThemeData(colorScheme: const ShadStoneColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Slate Light', data: UiThemeData(colorScheme: const ShadSlateColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Slate Dark', data: UiThemeData(colorScheme: const ShadSlateColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Violet Light', data: UiThemeData(colorScheme: const ShadVioletColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Violet Dark', data: UiThemeData(colorScheme: const ShadVioletColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Yellow Light', data: UiThemeData(colorScheme: const ShadYellowColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Yellow Dark', data: UiThemeData(colorScheme: const ShadYellowColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Zinc Light', data: UiThemeData(colorScheme: const ShadZincColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Zinc Dark', data: UiThemeData(colorScheme: const ShadZincColorScheme.dark(), brightness: Brightness.dark)),
            ],
            themeBuilder: (context, theme, child) => UiApp.cupertino(
              theme: theme,
              darkTheme: theme,
              themeMode: theme.brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
              home: child,
            ),
          )
        ],
      ),
    );
  }
}
