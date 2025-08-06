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

	/// en-US: 'Required field'
	String get campo_obrigatorio => 'Required field';

	/// en-US: 'Invalid CNPJ'
	String get cnpj_invalido => 'Invalid CNPJ';

	/// en-US: 'Invalid CPF'
	String get cpf_invalido => 'Invalid CPF';

	/// en-US: 'Invalid email'
	String get email_invalido => 'Invalid email';

	/// en-US: 'Invalid password, minimum 8 characters'
	String get senha_invalida_minimo_caracteres => 'Invalid password, minimum 8 characters';

	/// en-US: 'Invalid phone number'
	String get telefone_invalido => 'Invalid phone number';

	/// en-US: 'Invalid ZIP/Postal Code'
	String get cep_invalido => 'Invalid ZIP/Postal Code';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'campo_obrigatorio': return 'Required field';
			case 'cnpj_invalido': return 'Invalid CNPJ';
			case 'cpf_invalido': return 'Invalid CPF';
			case 'email_invalido': return 'Invalid email';
			case 'senha_invalida_minimo_caracteres': return 'Invalid password, minimum 8 characters';
			case 'telefone_invalido': return 'Invalid phone number';
			case 'cep_invalido': return 'Invalid ZIP/Postal Code';
			default: return null;
		}
	}
}

