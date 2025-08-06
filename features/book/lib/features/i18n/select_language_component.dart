import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Select Language Component', type: SelectLanguageComponent, path: 'i18n')
Widget primaryButton(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SelectLanguageComponent(
            onSaveLanguage: (language) {},
          ),
        ),
      ),
    ),
  );
}
