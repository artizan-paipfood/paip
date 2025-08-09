import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 400),
            child: SelectLanguageComponent(
              onSaveLanguage: (language) {
                ModularEvent.fire(SaveLanguage(language));
              },
            ),
          ),
        ),
      ),
    );
  }
}
