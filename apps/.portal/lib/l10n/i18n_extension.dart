import 'package:flutter/material.dart';
import 'package:portal/l10n/gen/app_localizations.dart';

extension ContextL10nExtension on BuildContext {
  AppLocalizations get i18n => AppLocalizations.of(this)!;
}
