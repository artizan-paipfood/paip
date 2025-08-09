import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Language Country Card', type: LanguageCountryCard, path: 'i18n')
Widget primaryButton(BuildContext context) {
  final isSelected = context.knobs.boolean(label: 'Is Selected', initialValue: false);
  final language = context.knobs.list(label: 'Language', options: AppLanguage.values);
  return Scaffold(
      body: Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: LanguageCountryCard(
              onTap: (language) => print(language),
              language: language,
              isSelected: isSelected,
            ))),
  ));
}
