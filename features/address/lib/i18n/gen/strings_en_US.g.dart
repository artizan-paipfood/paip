///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEnUs = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.enUs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en-US>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get enderecos_de_entrega => 'Delivery addresses';
	String get endereco_e_numero => 'Address and number';
	String get usar_localizacao_atual => 'Use current location';
	String get editar => 'Edit';
	String get excluir => 'Delete';
	String get servicos_de_localizacao_desativados => 'Location services disabled';
	String get permissao_de_localizacao_negada => 'Location permission denied';
	String get permissao_de_localizacao_negada_permanentemente => 'Location permission permanently denied';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'enderecos_de_entrega': return 'Delivery addresses';
			case 'endereco_e_numero': return 'Address and number';
			case 'usar_localizacao_atual': return 'Use current location';
			case 'editar': return 'Edit';
			case 'excluir': return 'Delete';
			case 'servicos_de_localizacao_desativados': return 'Location services disabled';
			case 'permissao_de_localizacao_negada': return 'Location permission denied';
			case 'permissao_de_localizacao_negada_permanentemente': return 'Location permission permanently denied';
			default: return null;
		}
	}
}

