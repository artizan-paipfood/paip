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
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPtBr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ptBr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt-BR>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsPtBr _root = this; // ignore: unused_field

	@override 
	TranslationsPtBr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPtBr(meta: meta ?? this.$meta);

	// Translations
	@override String get enderecos_de_entrega => 'Endereços de entrega';
	@override String get endereco_e_numero => 'Endereço e número';
	@override String get usar_localizacao_atual => 'Usar localização atual';
	@override String get editar => 'Editar';
	@override String get excluir => 'Excluir';
	@override String get servicos_de_localizacao_desativados => 'Serviços de localização desativados';
	@override String get permissao_de_localizacao_negada => 'Permissão de localização negada';
	@override String get permissao_de_localizacao_negada_permanentemente => 'Permissão de localização negada permanentemente';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPtBr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'enderecos_de_entrega': return 'Endereços de entrega';
			case 'endereco_e_numero': return 'Endereço e número';
			case 'usar_localizacao_atual': return 'Usar localização atual';
			case 'editar': return 'Editar';
			case 'excluir': return 'Excluir';
			case 'servicos_de_localizacao_desativados': return 'Serviços de localização desativados';
			case 'permissao_de_localizacao_negada': return 'Permissão de localização negada';
			case 'permissao_de_localizacao_negada_permanentemente': return 'Permissão de localização negada permanentemente';
			default: return null;
		}
	}
}

