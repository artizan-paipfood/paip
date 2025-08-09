import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'gen/app_localizations.dart';

AppLocalizations? _l10n;

AppLocalizations get l10nProiver {
  assert(_l10n != null, """Add L10nProvider.builder in your MaterialApp;
       return MaterialApp(
         builder: L10nProvider.builder,
         ...
  """);
  return _l10n!;
}

AppLocalizations get l10n => l10nProiver;

class L10nProvider {
  static Widget builder(BuildContext context, Widget? child) {
    return _BuildListener(child: child ?? const SizedBox.shrink());
  }
}

class _BuildListener extends StatelessWidget {
  final Widget child;
  const _BuildListener({required this.child});

  @override
  Widget build(BuildContext context) {
    _l10n = context.i18n;

    return child;
  }
}
