///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsPtBr extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [SlangAppLocale.build] is preferred.
	TranslationsPtBr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<SlangAppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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
	@override final TranslationMetadata<SlangAppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsPtBr _root = this; // ignore: unused_field

	@override 
	TranslationsPtBr $copyWith({TranslationMetadata<SlangAppLocale, Translations>? meta}) => TranslationsPtBr(meta: meta ?? this.$meta);

	// Translations
	@override String get welcome => 'Bem-vindo à feature Auth';
	@override String get title_name_page => 'Qual é o seu nome?';
	@override String get placeholder_input_name => 'Digite seu nome';
	@override String get title_phone_page => 'Qual é o seu número de telefone?';
	@override String get title_phone_confirm_page => 'Confirme seu número de telefone';
	@override String get subtitle_phone_confirm_page => 'Enviamos um código de verificação para o número';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPtBr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'welcome': return 'Bem-vindo à feature Auth';
			case 'title_name_page': return 'Qual é o seu nome?';
			case 'placeholder_input_name': return 'Digite seu nome';
			case 'title_phone_page': return 'Qual é o seu número de telefone?';
			case 'title_phone_confirm_page': return 'Confirme seu número de telefone';
			case 'subtitle_phone_confirm_page': return 'Enviamos um código de verificação para o número';
			default: return null;
		}
	}
}

