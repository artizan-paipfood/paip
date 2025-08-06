///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

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
	@override late final _TranslationsErrosDeEnderecoPtBr erros_de_endereco = _TranslationsErrosDeEnderecoPtBr._(_root);
	@override late final _TranslationsErrosDeAutenticacaoPtBr erros_de_autenticacao = _TranslationsErrosDeAutenticacaoPtBr._(_root);
	@override late final _TranslationsErrosDeValidacaoPtBr erros_de_validacao = _TranslationsErrosDeValidacaoPtBr._(_root);
	@override late final _TranslationsErrosDeRedePtBr erros_de_rede = _TranslationsErrosDeRedePtBr._(_root);
	@override late final _TranslationsErrosDeServidorPtBr erros_de_servidor = _TranslationsErrosDeServidorPtBr._(_root);
	@override late final _TranslationsErrosDeBancoDeDadosPtBr erros_de_banco_de_dados = _TranslationsErrosDeBancoDeDadosPtBr._(_root);
	@override late final _TranslationsErrosDeArquivoPtBr erros_de_arquivo = _TranslationsErrosDeArquivoPtBr._(_root);
	@override late final _TranslationsErrosDeGenericoPtBr erros_de_generico = _TranslationsErrosDeGenericoPtBr._(_root);
}

// Path: erros_de_endereco
class _TranslationsErrosDeEnderecoPtBr extends TranslationsErrosDeEnderecoEnUs {
	_TranslationsErrosDeEnderecoPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k1401 => 'Endereço fora do raio de entrega';
	@override String get k1402 => 'Endereço não encontrado';
	@override String get k1403 => 'CEP inválido';
}

// Path: erros_de_autenticacao
class _TranslationsErrosDeAutenticacaoPtBr extends TranslationsErrosDeAutenticacaoEnUs {
	_TranslationsErrosDeAutenticacaoPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k1001 => 'Credenciais inválidas';
	@override String get k1002 => 'Token expirado';
	@override String get k1003 => 'Token inválido';
	@override String get k1004 => 'Usuário não autorizado';
	@override String get k1005 => 'Sessão expirada';
	@override String get k1006 => 'Refresh token não encontrado';
	@override String get k1007 => 'Refresh token expirado';
	@override String get k1008 => 'ID de dispositivo de autenticação expirado';
}

// Path: erros_de_validacao
class _TranslationsErrosDeValidacaoPtBr extends TranslationsErrosDeValidacaoEnUs {
	_TranslationsErrosDeValidacaoPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k2001 => 'Dados inválidos';
}

// Path: erros_de_rede
class _TranslationsErrosDeRedePtBr extends TranslationsErrosDeRedeEnUs {
	_TranslationsErrosDeRedePtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k3001 => 'Sem conexão';
	@override String get k3002 => 'Timeout';
	@override String get k3003 => 'Conexão recusada';
}

// Path: erros_de_servidor
class _TranslationsErrosDeServidorPtBr extends TranslationsErrosDeServidorEnUs {
	_TranslationsErrosDeServidorPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k4001 => 'Erro interno do servidor';
}

// Path: erros_de_banco_de_dados
class _TranslationsErrosDeBancoDeDadosPtBr extends TranslationsErrosDeBancoDeDadosEnUs {
	_TranslationsErrosDeBancoDeDadosPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k5001 => 'Erro de banco de dados';
}

// Path: erros_de_arquivo
class _TranslationsErrosDeArquivoPtBr extends TranslationsErrosDeArquivoEnUs {
	_TranslationsErrosDeArquivoPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k6001 => 'Arquivo não encontrado';
	@override String get k6002 => 'Erro de leitura do arquivo';
	@override String get k6003 => 'Erro de escrita do arquivo';
	@override String get k6004 => 'Arquivo corrompido';
	@override String get k6005 => 'Permissão negada';
}

// Path: erros_de_generico
class _TranslationsErrosDeGenericoPtBr extends TranslationsErrosDeGenericoEnUs {
	_TranslationsErrosDeGenericoPtBr._(TranslationsPtBr root) : this._root = root, super.internal(root);

	final TranslationsPtBr _root; // ignore: unused_field

	// Translations
	@override String get k9001 => 'Erro genérico';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPtBr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'erros_de_endereco.k1401': return 'Endereço fora do raio de entrega';
			case 'erros_de_endereco.k1402': return 'Endereço não encontrado';
			case 'erros_de_endereco.k1403': return 'CEP inválido';
			case 'erros_de_autenticacao.k1001': return 'Credenciais inválidas';
			case 'erros_de_autenticacao.k1002': return 'Token expirado';
			case 'erros_de_autenticacao.k1003': return 'Token inválido';
			case 'erros_de_autenticacao.k1004': return 'Usuário não autorizado';
			case 'erros_de_autenticacao.k1005': return 'Sessão expirada';
			case 'erros_de_autenticacao.k1006': return 'Refresh token não encontrado';
			case 'erros_de_autenticacao.k1007': return 'Refresh token expirado';
			case 'erros_de_autenticacao.k1008': return 'ID de dispositivo de autenticação expirado';
			case 'erros_de_validacao.k2001': return 'Dados inválidos';
			case 'erros_de_rede.k3001': return 'Sem conexão';
			case 'erros_de_rede.k3002': return 'Timeout';
			case 'erros_de_rede.k3003': return 'Conexão recusada';
			case 'erros_de_servidor.k4001': return 'Erro interno do servidor';
			case 'erros_de_banco_de_dados.k5001': return 'Erro de banco de dados';
			case 'erros_de_arquivo.k6001': return 'Arquivo não encontrado';
			case 'erros_de_arquivo.k6002': return 'Erro de leitura do arquivo';
			case 'erros_de_arquivo.k6003': return 'Erro de escrita do arquivo';
			case 'erros_de_arquivo.k6004': return 'Arquivo corrompido';
			case 'erros_de_arquivo.k6005': return 'Permissão negada';
			case 'erros_de_generico.k9001': return 'Erro genérico';
			default: return null;
		}
	}
}

