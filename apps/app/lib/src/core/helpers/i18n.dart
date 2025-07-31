import 'package:flutter/widgets.dart';
import 'package:app/l10n/gen/app_localizations.dart';
import 'package:paipfood_package/paipfood_package.dart' as core;

AppLocalizations? _i18n;
core.AppLocalizations? _i18nCore;

core.AppLocalizations get i18nCore {
  assert(_i18nCore != null, 'I18nCore not initialized');
  return _i18nCore!;
}

AppLocalizations get i18n {
  assert(_i18n != null, 'I18n not initialized');
  return _i18n!;
}

class I18n extends ChangeNotifier {
  static I18n? _instance;
  I18n._();
  static I18n get instance => _instance ??= I18n._();

  void initialize(BuildContext context) {
    _i18n = AppLocalizations.of(context);
  }

  void changeLocale(BuildContext context, Locale locale) {
    core.Intl.defaultLocale = locale.languageCode;
    _i18n = AppLocalizations.of(context);
    _i18nCore = core.AppLocalizations.of(context);
    notifyListeners();
  }
}
