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

	/// en-US: 'Delivery addresses'
	String get enderecos_de_entrega => 'Delivery addresses';

	/// en-US: 'Address and number'
	String get endereco_e_numero => 'Address and number';

	/// en-US: 'Use current location'
	String get usar_localizacao_atual => 'Use current location';

	/// en-US: 'Edit'
	String get editar => 'Edit';

	/// en-US: 'Delete'
	String get excluir => 'Delete';

	/// en-US: 'Location services disabled'
	String get servicos_de_localizacao_desativados => 'Location services disabled';

	/// en-US: 'Location permission denied'
	String get permissao_de_localizacao_negada => 'Location permission denied';

	/// en-US: 'Location permission permanently denied'
	String get permissao_de_localizacao_negada_permanentemente => 'Location permission permanently denied';

	/// en-US: 'Street'
	String get rua => 'Street';

	/// en-US: 'Number'
	String get numero => 'Number';

	/// en-US: 'Address without number'
	String get endereco_sem_numero => 'Address without number';

	/// en-US: 'Complement'
	String get complemento => 'Complement';

	/// en-US: 'Address without complement'
	String get endereco_sem_complemento => 'Address without complement';

	/// en-US: 'Neighborhood'
	String get bairro => 'Neighborhood';

	/// en-US: 'ZIP/ Postcode'
	String get cep => 'ZIP/ Postcode';

	/// en-US: 'Nickname'
	String get apelido => 'Nickname';

	/// en-US: 'Eg. Home, Work...'
	String get apelido_placeholder => 'Eg. Home, Work...';

	/// en-US: 'Home'
	String get casa => 'Home';

	/// en-US: 'Work'
	String get trabalho => 'Work';

	/// en-US: 'Complete your address'
	String get complete_seu_endereco => 'Complete your address';

	/// en-US: 'Save address'
	String get salvar_endereco => 'Save address';

	/// en-US: 'Confirm position'
	String get confirmar_posicao => 'Confirm position';

	/// en-US: 'Select your position'
	String get selecione_sua_posicao => 'Select your position';

	/// en-US: 'The street cannot be changed'
	String get a_rua_nao_pode_ser_alterada => 'The street cannot be changed';

	/// en-US: 'Try to adjust your position on the map.'
	String get a_rua_nao_pode_ser_alterada_descricao => 'Try to adjust your position on the map.';

	/// en-US: 'Address and number'
	String get buscar_endereco_placeholder => 'Address and number';

	/// en-US: 'Search by ZIP/ Postcode'
	String get buscar_por_cep => 'Search by ZIP/ Postcode';

	/// en-US: 'Search address'
	String get buscar_endereco => 'Search address';

	/// en-US: 'Enter your address above'
	String get insira_seu_endereco_no_campo_acima => 'Enter your address above';

	/// en-US: 'No address found'
	String get nenhum_endereco_encontrado => 'No address found';

	/// en-US: 'Enter the ZIP/ Postcode above'
	String get insira_o_cep_no_campo_acima => 'Enter the ZIP/ Postcode above';

	/// en-US: 'Enter your ZIP/ Postcode'
	String get insira_seu_cep => 'Enter your ZIP/ Postcode';

	/// en-US: 'Delete address'
	String get excluir_endereco => 'Delete address';

	/// en-US: 'This action cannot be undone. This will permanently delete the address.'
	String get excluir_endereco_descricao => 'This action cannot be undone. This will permanently delete the address.';
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
			case 'rua': return 'Street';
			case 'numero': return 'Number';
			case 'endereco_sem_numero': return 'Address without number';
			case 'complemento': return 'Complement';
			case 'endereco_sem_complemento': return 'Address without complement';
			case 'bairro': return 'Neighborhood';
			case 'cep': return 'ZIP/ Postcode';
			case 'apelido': return 'Nickname';
			case 'apelido_placeholder': return 'Eg. Home, Work...';
			case 'casa': return 'Home';
			case 'trabalho': return 'Work';
			case 'complete_seu_endereco': return 'Complete your address';
			case 'salvar_endereco': return 'Save address';
			case 'confirmar_posicao': return 'Confirm position';
			case 'selecione_sua_posicao': return 'Select your position';
			case 'a_rua_nao_pode_ser_alterada': return 'The street cannot be changed';
			case 'a_rua_nao_pode_ser_alterada_descricao': return 'Try to adjust your position on the map.';
			case 'buscar_endereco_placeholder': return 'Address and number';
			case 'buscar_por_cep': return 'Search by ZIP/ Postcode';
			case 'buscar_endereco': return 'Search address';
			case 'insira_seu_endereco_no_campo_acima': return 'Enter your address above';
			case 'nenhum_endereco_encontrado': return 'No address found';
			case 'insira_o_cep_no_campo_acima': return 'Enter the ZIP/ Postcode above';
			case 'insira_seu_cep': return 'Enter your ZIP/ Postcode';
			case 'excluir_endereco': return 'Delete address';
			case 'excluir_endereco_descricao': return 'This action cannot be undone. This will permanently delete the address.';
			default: return null;
		}
	}
}

