import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18n/gen/strings.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'main.directories.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await I18nService.instance.initialize();
  runApp(TranslationProvider(child: const WidgetbookApp()));
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
      theme: ArtThemeData(colorScheme: const ArtPaipColorScheme.light(), brightness: Brightness.light),
      darkTheme: ArtThemeData(colorScheme: const ArtPaipColorScheme.dark(), brightness: Brightness.dark),
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
          ThemeAddon<ArtThemeData>(
            themes: [
              WidgetbookTheme(name: 'Paip Light', data: ArtThemeData(colorScheme: const ArtPaipColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Paip Dark', data: ArtThemeData(colorScheme: const ArtPaipColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Zinc Light', data: ArtThemeData(colorScheme: const ArtZincColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Zinc Dark', data: ArtThemeData(colorScheme: const ArtZincColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Blue Light', data: ArtThemeData(colorScheme: const ArtBlueColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Blue Dark', data: ArtThemeData(colorScheme: const ArtBlueColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Gray Light', data: ArtThemeData(colorScheme: const ArtBlueColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Gray Dark', data: ArtThemeData(colorScheme: const ArtBlueColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Green Light', data: ArtThemeData(colorScheme: const ArtGreenColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Green Dark', data: ArtThemeData(colorScheme: const ArtGreenColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Neutral Light', data: ArtThemeData(colorScheme: const ArtNeutralColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Neutral Dark', data: ArtThemeData(colorScheme: const ArtNeutralColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Orange Light', data: ArtThemeData(colorScheme: const ArtOrangeColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Orange Dark', data: ArtThemeData(colorScheme: const ArtOrangeColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Red Light', data: ArtThemeData(colorScheme: const ArtRedColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Red Dark', data: ArtThemeData(colorScheme: const ArtRedColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Rose Light', data: ArtThemeData(colorScheme: const ArtRoseColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Rose Dark', data: ArtThemeData(colorScheme: const ArtRoseColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Stone Light', data: ArtThemeData(colorScheme: const ArtStoneColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Stone Dark', data: ArtThemeData(colorScheme: const ArtStoneColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Slate Light', data: ArtThemeData(colorScheme: const ArtSlateColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Slate Dark', data: ArtThemeData(colorScheme: const ArtSlateColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Violet Light', data: ArtThemeData(colorScheme: const ArtVioletColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Violet Dark', data: ArtThemeData(colorScheme: const ArtVioletColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Yellow Light', data: ArtThemeData(colorScheme: const ArtYellowColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Yellow Dark', data: ArtThemeData(colorScheme: const ArtYellowColorScheme.dark(), brightness: Brightness.dark)),
              WidgetbookTheme(name: 'Zinc Light', data: ArtThemeData(colorScheme: const ArtZincColorScheme.light(), brightness: Brightness.light)),
              WidgetbookTheme(name: 'Zinc Dark', data: ArtThemeData(colorScheme: const ArtZincColorScheme.dark(), brightness: Brightness.dark)),
            ],
            themeBuilder: (context, theme, child) => ArtApp.material(
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
