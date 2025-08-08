import 'package:core/core.dart';
import 'package:ui/src/.i18n/gen/strings.g.dart';

extension AppErrorExtension on AppError {
  String messageTranslated() {
    return message(LocaleSettings.currentLocale.underscoreTag);
  }
}
