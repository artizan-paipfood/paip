///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEnUs = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
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
	late final TranslationsErrosDeEnderecoEnUs erros_de_endereco = TranslationsErrosDeEnderecoEnUs.internal(_root);
	late final TranslationsErrosDeAutenticacaoEnUs erros_de_autenticacao = TranslationsErrosDeAutenticacaoEnUs.internal(_root);
	late final TranslationsErrosDeValidacaoEnUs erros_de_validacao = TranslationsErrosDeValidacaoEnUs.internal(_root);
	late final TranslationsErrosDeRedeEnUs erros_de_rede = TranslationsErrosDeRedeEnUs.internal(_root);
	late final TranslationsErrosDeServidorEnUs erros_de_servidor = TranslationsErrosDeServidorEnUs.internal(_root);
	late final TranslationsErrosDeBancoDeDadosEnUs erros_de_banco_de_dados = TranslationsErrosDeBancoDeDadosEnUs.internal(_root);
	late final TranslationsErrosDeArquivoEnUs erros_de_arquivo = TranslationsErrosDeArquivoEnUs.internal(_root);
	late final TranslationsErrosDeGenericoEnUs erros_de_generico = TranslationsErrosDeGenericoEnUs.internal(_root);
}

// Path: erros_de_endereco
class TranslationsErrosDeEnderecoEnUs {
	TranslationsErrosDeEnderecoEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Address out of delivery radius'
	String get k1401 => 'Address out of delivery radius';

	/// en-US: 'Address not found'
	String get k1402 => 'Address not found';

	/// en-US: 'Invalid ZIP/Postal code'
	String get k1403 => 'Invalid ZIP/Postal code';
}

// Path: erros_de_autenticacao
class TranslationsErrosDeAutenticacaoEnUs {
	TranslationsErrosDeAutenticacaoEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Invalid credentials'
	String get k1001 => 'Invalid credentials';

	/// en-US: 'Token expired'
	String get k1002 => 'Token expired';

	/// en-US: 'Invalid token'
	String get k1003 => 'Invalid token';

	/// en-US: 'Unauthorized user'
	String get k1004 => 'Unauthorized user';

	/// en-US: 'Session expired'
	String get k1005 => 'Session expired';

	/// en-US: 'Refresh token not found'
	String get k1006 => 'Refresh token not found';

	/// en-US: 'Refresh token expired'
	String get k1007 => 'Refresh token expired';

	/// en-US: 'Device authentication ID expired'
	String get k1008 => 'Device authentication ID expired';
}

// Path: erros_de_validacao
class TranslationsErrosDeValidacaoEnUs {
	TranslationsErrosDeValidacaoEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Invalid data'
	String get k2001 => 'Invalid data';
}

// Path: erros_de_rede
class TranslationsErrosDeRedeEnUs {
	TranslationsErrosDeRedeEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'No connection'
	String get k3001 => 'No connection';

	/// en-US: 'Timeout'
	String get k3002 => 'Timeout';

	/// en-US: 'Connection refused'
	String get k3003 => 'Connection refused';
}

// Path: erros_de_servidor
class TranslationsErrosDeServidorEnUs {
	TranslationsErrosDeServidorEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Internal server error'
	String get k4001 => 'Internal server error';
}

// Path: erros_de_banco_de_dados
class TranslationsErrosDeBancoDeDadosEnUs {
	TranslationsErrosDeBancoDeDadosEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Database error'
	String get k5001 => 'Database error';
}

// Path: erros_de_arquivo
class TranslationsErrosDeArquivoEnUs {
	TranslationsErrosDeArquivoEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'File not found'
	String get k6001 => 'File not found';

	/// en-US: 'File read error'
	String get k6002 => 'File read error';

	/// en-US: 'File write error'
	String get k6003 => 'File write error';

	/// en-US: 'Corrupted file'
	String get k6004 => 'Corrupted file';

	/// en-US: 'Permission denied'
	String get k6005 => 'Permission denied';
}

// Path: erros_de_generico
class TranslationsErrosDeGenericoEnUs {
	TranslationsErrosDeGenericoEnUs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en-US: 'Generic error'
	String get k9001 => 'Generic error';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'erros_de_endereco.k1401': return 'Address out of delivery radius';
			case 'erros_de_endereco.k1402': return 'Address not found';
			case 'erros_de_endereco.k1403': return 'Invalid ZIP/Postal code';
			case 'erros_de_autenticacao.k1001': return 'Invalid credentials';
			case 'erros_de_autenticacao.k1002': return 'Token expired';
			case 'erros_de_autenticacao.k1003': return 'Invalid token';
			case 'erros_de_autenticacao.k1004': return 'Unauthorized user';
			case 'erros_de_autenticacao.k1005': return 'Session expired';
			case 'erros_de_autenticacao.k1006': return 'Refresh token not found';
			case 'erros_de_autenticacao.k1007': return 'Refresh token expired';
			case 'erros_de_autenticacao.k1008': return 'Device authentication ID expired';
			case 'erros_de_validacao.k2001': return 'Invalid data';
			case 'erros_de_rede.k3001': return 'No connection';
			case 'erros_de_rede.k3002': return 'Timeout';
			case 'erros_de_rede.k3003': return 'Connection refused';
			case 'erros_de_servidor.k4001': return 'Internal server error';
			case 'erros_de_banco_de_dados.k5001': return 'Database error';
			case 'erros_de_arquivo.k6001': return 'File not found';
			case 'erros_de_arquivo.k6002': return 'File read error';
			case 'erros_de_arquivo.k6003': return 'File write error';
			case 'erros_de_arquivo.k6004': return 'Corrupted file';
			case 'erros_de_arquivo.k6005': return 'Permission denied';
			case 'erros_de_generico.k9001': return 'Generic error';
			default: return null;
		}
	}
}

