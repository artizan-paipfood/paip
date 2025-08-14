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
	@override String tempo_abreviado({required Object initialTime, required Object endTime}) => '${initialTime} - ${endTime} min';
	@override String get aberto => 'Aberto';
	@override String get fechado => 'Fechado';
	@override String fecha_ate({required Object minutes}) => 'Fecha em ${minutes} minutos';
	@override String a_partir_de({required Object price}) => 'A partir de ${price}';
	@override String get pesquisar_produto => 'Pesquisar produto';
	@override String get pesquisar_produto_placeholder => 'Nome do produto ou descrição';
	@override String get nenhum_produto_encontrado => 'Nenhum produto encontrado.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPtBr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'tempo_abreviado': return ({required Object initialTime, required Object endTime}) => '${initialTime} - ${endTime} min';
			case 'aberto': return 'Aberto';
			case 'fechado': return 'Fechado';
			case 'fecha_ate': return ({required Object minutes}) => 'Fecha em ${minutes} minutos';
			case 'a_partir_de': return ({required Object price}) => 'A partir de ${price}';
			case 'pesquisar_produto': return 'Pesquisar produto';
			case 'pesquisar_produto_placeholder': return 'Nome do produto ou descrição';
			case 'nenhum_produto_encontrado': return 'Nenhum produto encontrado.';
			default: return null;
		}
	}
}

