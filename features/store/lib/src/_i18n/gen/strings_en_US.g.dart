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
		  $meta = meta ?? TranslationMetadata(
		    locale: SlangAppLocale.enUs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en-US>.
	@override final TranslationMetadata<SlangAppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<SlangAppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en-US: '{initialTime} - {endTime} min'
	String tempo_abreviado({required Object initialTime, required Object endTime}) => '${initialTime} - ${endTime} min';

	/// en-US: 'Open'
	String get aberto => 'Open';

	/// en-US: 'Closed'
	String get fechado => 'Closed';

	/// en-US: 'Closed in {minutes} minutes'
	String fecha_ate({required Object minutes}) => 'Closed in ${minutes} minutes';

	/// en-US: 'From {price}'
	String a_partir_de({required Object price}) => 'From ${price}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'tempo_abreviado': return ({required Object initialTime, required Object endTime}) => '${initialTime} - ${endTime} min';
			case 'aberto': return 'Open';
			case 'fechado': return 'Closed';
			case 'fecha_ate': return ({required Object minutes}) => 'Closed in ${minutes} minutes';
			case 'a_partir_de': return ({required Object price}) => 'From ${price}';
			default: return null;
		}
	}
}

