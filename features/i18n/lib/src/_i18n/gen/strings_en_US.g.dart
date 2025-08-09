///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEnUs = Translations; // ignore: unused_element

class Translations implements BaseTranslations<SlangAppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) => InheritedLocaleData.of<SlangAppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [SlangAppLocale.build] is preferred.
  Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<SlangAppLocale, Translations>? meta})
      : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: SlangAppLocale.enUs,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en-US>.
  @override
  final TranslationMetadata<SlangAppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<SlangAppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

  // Translations

  /// en-US: 'Select a language'
  String get selecione_uma_linguagem => 'Select a language';

  /// en-US: 'Save'
  String get salvar => 'Save';

  /// en-US: 'Back'
  String get voltar => 'Back';

  /// en-US: '(en_US) {English} (pt_BR) {Português Brazil}'
  String paip_language({required AppLanguage language}) {
    switch (language) {
      case AppLanguage.en_US:
        return 'English';
      case AppLanguage.pt_BR:
        return 'Português Brazil';
    }
  }
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'selecione_uma_linguagem':
        return 'Select a language';
      case 'salvar':
        return 'Save';
      case 'voltar':
        return 'Back';
      case 'paip_language':
        return ({required AppLanguage language}) {
          switch (language) {
            case AppLanguage.en_US:
              return 'English';
            case AppLanguage.pt_BR:
              return 'Português Brazil';
          }
        };
      default:
        return null;
    }
  }
}
