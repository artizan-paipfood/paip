import 'package:flutter/material.dart';
import 'package:paipfood_package/l10n/app_localizations.dart';

///doc: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

extension L10nExtension on BuildContext {
  AppLocalizations get i18nCore => AppLocalizations.of(this)!;
}
