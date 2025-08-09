import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:i18n/src/_i18n/gen/strings.g.dart';
import 'package:i18n/src/domain/models/enums/languages.dart';

class LanguageCountryCard extends StatefulWidget {
  final AppLanguage language;
  final bool isSelected;
  final Function(AppLanguage language) onTap;
  const LanguageCountryCard({
    required this.language,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  State<LanguageCountryCard> createState() => _LanguageCountryCardState();
}

class _LanguageCountryCardState extends State<LanguageCountryCard> {
  Color get selectedColor => context.artColorScheme.primary;

  bool _isHovering = false;

  bool get _isSelected => widget.isSelected || _isHovering;

  Locale get locale => LocaleSettings.currentLocale.flutterLocale;

  void _onTap() {
    widget.onTap(widget.language);
  }

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      padding: const EdgeInsets.all(0),
      border: _isSelected ? Border.all(color: selectedColor, width: 1.5) : null,
      shadows: widget.isSelected
          ? [
              BoxShadow(
                color: selectedColor.withValues(alpha: .2),
                blurRadius: 29,
                spreadRadius: 0,
                offset: const Offset(
                  0,
                  7,
                ),
              ),
            ]
          : [],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onTap,
          hoverColor: Colors.transparent,
          splashColor: selectedColor.withValues(alpha: .2),
          onHover: (value) => setState(() => _isHovering = value),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Material(
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      widget.language.imagePath,
                      package: 'i18n',
                      height: 35,
                      fit: BoxFit.fitHeight,
                    )),
                Expanded(
                  child: Text(
                    t.paip_language(language: widget.language),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
