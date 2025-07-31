import 'package:paipfood_package/paipfood_package.dart' hide Platform;

Uuid _uuid = const Uuid();

PColors paipThemeLight = PColors.light;
PColors paipThemeDark = PColors.dark;

String get uuid => _uuid.v4();

const String stringEmpty = " -- ";
