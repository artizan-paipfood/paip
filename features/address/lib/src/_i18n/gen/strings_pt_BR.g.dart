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
	@override String get enderecos_de_entrega => 'Endereços de entrega';
	@override String get endereco_e_numero => 'Endereço e número';
	@override String get usar_localizacao_atual => 'Usar localização atual';
	@override String get editar => 'Editar';
	@override String get excluir => 'Excluir';
	@override String get servicos_de_localizacao_desativados => 'Serviços de localização desativados';
	@override String get permissao_de_localizacao_negada => 'Permissão de localização negada';
	@override String get permissao_de_localizacao_negada_permanentemente => 'Permissão de localização negada permanentemente';
	@override String get rua => 'Rua';
	@override String get numero => 'Número';
	@override String get endereco_sem_numero => 'Endereço sem número';
	@override String get complemento => 'Complemento';
	@override String get endereco_sem_complemento => 'Endereço sem complemento';
	@override String get bairro => 'Bairro';
	@override String get cep => 'CEP';
	@override String get apelido => 'Apelido';
	@override String get apelido_placeholder => 'Ex: Casa, Trabalho...';
	@override String get casa => 'Casa';
	@override String get trabalho => 'Trabalho';
	@override String get complete_seu_endereco => 'Complete seu endereço';
	@override String get salvar_endereco => 'Salvar endereço';
	@override String get confirmar_posicao => 'Confirmar posição';
	@override String get selecione_sua_posicao => 'Selecione sua posição';
	@override String get a_rua_nao_pode_ser_alterada => 'A rua não pode ser alterada';
	@override String get a_rua_nao_pode_ser_alterada_descricao => 'Tente reajustar sua posição no mapa.';
	@override String get buscar_endereco_placeholder => 'Endereço e número';
	@override String get buscar_por_cep => 'Buscar por CEP';
	@override String get buscar_endereco => 'Buscar endereço';
	@override String get insira_seu_endereco_no_campo_acima => 'Insira seu endereço no campo acima';
	@override String get nenhum_endereco_encontrado => 'Nenhum endereço encontrado';
	@override String get insira_o_cep_no_campo_acima => 'Insira o CEP no campo acima';
	@override String get insira_seu_cep => 'Insira seu CEP';
	@override String get excluir_endereco => 'Excluir endereço';
	@override String get excluir_endereco_descricao => 'Esta ação não pode ser desfeita. Isso irá excluir o endereço permanentemente.';
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
			case 'rua': return 'Rua';
			case 'numero': return 'Número';
			case 'endereco_sem_numero': return 'Endereço sem número';
			case 'complemento': return 'Complemento';
			case 'endereco_sem_complemento': return 'Endereço sem complemento';
			case 'bairro': return 'Bairro';
			case 'cep': return 'CEP';
			case 'apelido': return 'Apelido';
			case 'apelido_placeholder': return 'Ex: Casa, Trabalho...';
			case 'casa': return 'Casa';
			case 'trabalho': return 'Trabalho';
			case 'complete_seu_endereco': return 'Complete seu endereço';
			case 'salvar_endereco': return 'Salvar endereço';
			case 'confirmar_posicao': return 'Confirmar posição';
			case 'selecione_sua_posicao': return 'Selecione sua posição';
			case 'a_rua_nao_pode_ser_alterada': return 'A rua não pode ser alterada';
			case 'a_rua_nao_pode_ser_alterada_descricao': return 'Tente reajustar sua posição no mapa.';
			case 'buscar_endereco_placeholder': return 'Endereço e número';
			case 'buscar_por_cep': return 'Buscar por CEP';
			case 'buscar_endereco': return 'Buscar endereço';
			case 'insira_seu_endereco_no_campo_acima': return 'Insira seu endereço no campo acima';
			case 'nenhum_endereco_encontrado': return 'Nenhum endereço encontrado';
			case 'insira_o_cep_no_campo_acima': return 'Insira o CEP no campo acima';
			case 'insira_seu_cep': return 'Insira seu CEP';
			case 'excluir_endereco': return 'Excluir endereço';
			case 'excluir_endereco_descricao': return 'Esta ação não pode ser desfeita. Isso irá excluir o endereço permanentemente.';
			default: return null;
		}
	}
}

