///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsPtBr extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [SlangAppLocale.build] is preferred.
  TranslationsPtBr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<SlangAppLocale, Translations>? meta})
      : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: SlangAppLocale.ptBr,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ),
        super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <pt-BR>.
  @override
  final TranslationMetadata<SlangAppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsPtBr _root = this; // ignore: unused_field

  @override
  TranslationsPtBr $copyWith({TranslationMetadata<SlangAppLocale, Translations>? meta}) => TranslationsPtBr(meta: meta ?? this.$meta);

  // Translations
  @override
  String get selecione_uma_linguagem => 'Selecione uma linguagem';
  @override
  String get salvar => 'Salvar';
  @override
  String get voltar => 'Voltar';
  @override
  String paip_language({required AppLanguage language}) {
    switch (language) {
      case AppLanguage.en_US:
        return 'Inglês';
      case AppLanguage.pt_BR:
        return 'Português Brasil';
    }
  }
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPtBr {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'selecione_uma_linguagem':
        return 'Selecione uma linguagem';
      case 'salvar':
        return 'Salvar';
      case 'voltar':
        return 'Voltar';
      case 'paip_language':
        return ({required AppLanguage language}) {
          switch (language) {
            case AppLanguage.en_US:
              return 'Inglês';
            case AppLanguage.pt_BR:
              return 'Português Brasil';
          }
        };
      default:
        return null;
    }
  }
}
