import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18n/gen/strings.g.dart';

class SelectLanguageComponent extends StatefulWidget {
  final bool preSelected;
  final void Function(PaipLanguage language) onSaveLanguage;
  const SelectLanguageComponent({
    this.preSelected = false,
    super.key,
    required this.onSaveLanguage,
  });

  @override
  State<SelectLanguageComponent> createState() => _SelectLanguageComponentState();
}

class _SelectLanguageComponentState extends State<SelectLanguageComponent> {
  PaipLanguage? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    if (widget.preSelected) _selectedLanguage = PaipLanguage.values.firstWhere((element) => element.languageCode == AppI18n.locale.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Text(t.selecione_uma_linguagem, style: context.artTextTheme.h4),
            const ArtDivider.horizontal(),
            Expanded(
              child: Column(
                  children: PaipLanguage.values
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: LanguageCountryCard(
                              language: e,
                              isSelected: _selectedLanguage == e,
                              onTap: (language) {
                                setState(() {
                                  _selectedLanguage = language;
                                });
                              }),
                        ),
                      )
                      .toList()),
            ),
            Row(
              children: [
                Expanded(
                  child: ArtButton(
                    enabled: _selectedLanguage != null,
                    onPressed: () {
                      // AppI18n.setLanguage(_selectedLanguage?.languageCode ?? 'en_US');
                      widget.onSaveLanguage(_selectedLanguage!);
                    },
                    child: Text(t.salvar),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
