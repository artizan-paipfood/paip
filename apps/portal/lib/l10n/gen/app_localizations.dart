import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR')
  ];

  /// No description provided for @currency.
  ///
  /// In pt, this message translates to:
  /// **'£'**
  String get currency;

  /// No description provided for @troqueSuaSenha.
  ///
  /// In pt, this message translates to:
  /// **'Troque sua senha'**
  String get troqueSuaSenha;

  /// No description provided for @confirmeSenha.
  ///
  /// In pt, this message translates to:
  /// **'Confirme sua senha'**
  String get confirmeSenha;

  /// No description provided for @confirmar.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirmar;

  /// No description provided for @telefone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get telefone;

  /// No description provided for @planosEprecos.
  ///
  /// In pt, this message translates to:
  /// **'Planos e preços'**
  String get planosEprecos;

  /// No description provided for @funcionalidades.
  ///
  /// In pt, this message translates to:
  /// **'Funcionalidades'**
  String get funcionalidades;

  /// No description provided for @login.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @titleHome.
  ///
  /// In pt, this message translates to:
  /// **'Gestão Completa para Restaurantes com Integração WhatsApp'**
  String get titleHome;

  /// No description provided for @subtitleHome.
  ///
  /// In pt, this message translates to:
  /// **'Do atendimento à mesa até a entrega, automatize todas as operações do seu restaurante com nossa plataforma completa.'**
  String get subtitleHome;

  /// No description provided for @comecarAUsar.
  ///
  /// In pt, this message translates to:
  /// **'Começar a usar'**
  String get comecarAUsar;

  /// No description provided for @facilidadeDeUso.
  ///
  /// In pt, this message translates to:
  /// **'Facilidade de Uso'**
  String get facilidadeDeUso;

  /// No description provided for @descFacilidadeDeUso.
  ///
  /// In pt, this message translates to:
  /// **'Nosso app é tão fácil de usar que qualquer pessoa consegue fazer um pedido em poucos cliques. Simplicidade e eficiência ao seu alcance.'**
  String get descFacilidadeDeUso;

  /// No description provided for @sistemaDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Sistema Delivery'**
  String get sistemaDelivery;

  /// No description provided for @descSistemaDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Garanta uma operação de delivery rápida e eficiente. Acompanhe o status dos pedidos e ofereça um serviço de qualidade aos seus clientes.'**
  String get descSistemaDelivery;

  /// No description provided for @automatizeSeuWhatsApp.
  ///
  /// In pt, this message translates to:
  /// **'Automatize seu WhatsApp'**
  String get automatizeSeuWhatsApp;

  /// No description provided for @descAutomatizeSeuWhatsApp.
  ///
  /// In pt, this message translates to:
  /// **'Responda seus clientes de forma rápida e automática pelo WhatsApp. Facilite o atendimento e aumente a satisfação dos seus clientes com respostas imediatas.'**
  String get descAutomatizeSeuWhatsApp;

  /// No description provided for @imprimaSeusPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Imprima seus pedidos'**
  String get imprimaSeusPedidos;

  /// No description provided for @descImprimaSeusPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Tenha todos os pedidos impressos de forma rápida e organizada. Facilite o gerenciamento e o controle dos pedidos do seu negócio.'**
  String get descImprimaSeusPedidos;

  /// No description provided for @gerencieSeusEntregadores.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie seus Entregadores'**
  String get gerencieSeusEntregadores;

  /// No description provided for @descGerencieSeusEntregadores.
  ///
  /// In pt, this message translates to:
  /// **'Defina facilmente as áreas de entrega e gerencie seus entregadores de forma eficiente. Garanta que seus pedidos cheguem aos clientes no prazo certo.'**
  String get descGerencieSeusEntregadores;

  /// No description provided for @porMes.
  ///
  /// In pt, this message translates to:
  /// **'/Por mês'**
  String get porMes;

  /// No description provided for @selecionar.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar'**
  String get selecionar;

  /// No description provided for @automacaoComWhatsApp.
  ///
  /// In pt, this message translates to:
  /// **'Automação com Whatsapp'**
  String get automacaoComWhatsApp;

  /// No description provided for @aplicativoDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Aplicativo Delivery'**
  String get aplicativoDelivery;

  /// No description provided for @relatorios.
  ///
  /// In pt, this message translates to:
  /// **'Relatórios'**
  String get relatorios;

  /// No description provided for @atePedidosMes.
  ///
  /// In pt, this message translates to:
  /// **'Até {qty} pedidos por mês'**
  String atePedidosMes(Object qty);

  /// No description provided for @appEntregador.
  ///
  /// In pt, this message translates to:
  /// **'App para entregadores'**
  String get appEntregador;

  /// No description provided for @facebookPixel.
  ///
  /// In pt, this message translates to:
  /// **'Facebook Pixel'**
  String get facebookPixel;

  /// No description provided for @planos.
  ///
  /// In pt, this message translates to:
  /// **'Planos'**
  String get planos;

  /// No description provided for @pedidosIlimitados.
  ///
  /// In pt, this message translates to:
  /// **'Pedidos ilimitados'**
  String get pedidosIlimitados;

  /// No description provided for @download.
  ///
  /// In pt, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @pdv.
  ///
  /// In pt, this message translates to:
  /// **'PDV'**
  String get pdv;

  /// No description provided for @comeceGratuitamente.
  ///
  /// In pt, this message translates to:
  /// **'Comece gratuitamente'**
  String get comeceGratuitamente;

  /// No description provided for @tituloFeatures.
  ///
  /// In pt, this message translates to:
  /// **'Solução completa para Restaurantes'**
  String get tituloFeatures;

  /// No description provided for @featureTitleWhatsapp.
  ///
  /// In pt, this message translates to:
  /// **'Integração com WhatsApp'**
  String get featureTitleWhatsapp;

  /// No description provided for @featureDescWhatsapp.
  ///
  /// In pt, this message translates to:
  /// **'Confirmações automáticas de pedidos, atualizações e comunicação com clientes via WhatsApp'**
  String get featureDescWhatsapp;

  /// No description provided for @featureTitleImpressao.
  ///
  /// In pt, this message translates to:
  /// **'Impressão Inteligente'**
  String get featureTitleImpressao;

  /// No description provided for @featureDescImpressao.
  ///
  /// In pt, this message translates to:
  /// **'Impressão automática de pedidos na cozinha, bar e estações de serviço'**
  String get featureDescImpressao;

  /// No description provided for @featureTitlePdv.
  ///
  /// In pt, this message translates to:
  /// **'Sistema PDV'**
  String get featureTitlePdv;

  /// No description provided for @featureDescPdv.
  ///
  /// In pt, this message translates to:
  /// **'Ponto de venda moderno com controle de caixa e relatórios.'**
  String get featureDescPdv;

  /// No description provided for @featureTitleMesa.
  ///
  /// In pt, this message translates to:
  /// **'Serviço de Mesa'**
  String get featureTitleMesa;

  /// No description provided for @featureDescMesa.
  ///
  /// In pt, this message translates to:
  /// **'Gestão digital de mesas com pedidos por QR code e acompanhamento de status'**
  String get featureDescMesa;

  /// No description provided for @featureTitleAppGarcom.
  ///
  /// In pt, this message translates to:
  /// **'App para Garçons'**
  String get featureTitleAppGarcom;

  /// No description provided for @featureDescAppGarcom.
  ///
  /// In pt, this message translates to:
  /// **'Aplicativo móvel para equipe gerenciar pedidos, mesas e solicitações'**
  String get featureDescAppGarcom;

  /// No description provided for @featureTitleEntregadores.
  ///
  /// In pt, this message translates to:
  /// **'Rede de Entrega'**
  String get featureTitleEntregadores;

  /// No description provided for @featureDescEntregadores.
  ///
  /// In pt, this message translates to:
  /// **'Sistema automatizado de despacho e disponibilidade de entregadores em tempo real'**
  String get featureDescEntregadores;

  /// No description provided for @planosTitle.
  ///
  /// In pt, this message translates to:
  /// **'Preços Simples e Transparentes'**
  String get planosTitle;

  /// No description provided for @avaliacoesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes que confiam em nós'**
  String get avaliacoesTitle;

  /// No description provided for @callTitleAssinar.
  ///
  /// In pt, this message translates to:
  /// **'Pronto para Modernizar seu Restaurante?'**
  String get callTitleAssinar;

  /// No description provided for @callDescAssinar.
  ///
  /// In pt, this message translates to:
  /// **'Comece seu teste gratuito de 14 dias. Sem necessidade de cartão de crédito.'**
  String get callDescAssinar;

  /// No description provided for @callButtonAssinar.
  ///
  /// In pt, this message translates to:
  /// **'Começar Agora'**
  String get callButtonAssinar;

  /// No description provided for @vendaMuitoMaisComNossasSolucoesDigitais.
  ///
  /// In pt, this message translates to:
  /// **'Venda muito mais com \nnossas soluções digitais'**
  String get vendaMuitoMaisComNossasSolucoesDigitais;

  /// No description provided for @callTermosUso.
  ///
  /// In pt, this message translates to:
  /// **'Ao avançar aceito que a PaipFood entre em contato para fins comerciais e concordo com os '**
  String get callTermosUso;

  /// No description provided for @termosUso.
  ///
  /// In pt, this message translates to:
  /// **'Termos de Uso'**
  String get termosUso;

  /// No description provided for @e.
  ///
  /// In pt, this message translates to:
  /// **'e'**
  String get e;

  /// No description provided for @politicaPrivacidade.
  ///
  /// In pt, this message translates to:
  /// **'Política de Privacidade'**
  String get politicaPrivacidade;

  /// No description provided for @cadastrar.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get cadastrar;

  /// No description provided for @proximo.
  ///
  /// In pt, this message translates to:
  /// **'Próximo'**
  String get proximo;

  /// No description provided for @voltar.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get voltar;

  /// No description provided for @precisaAjuda.
  ///
  /// In pt, this message translates to:
  /// **'Precisa de ajuda?'**
  String get precisaAjuda;

  /// No description provided for @nomeCompleto.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get nomeCompleto;

  /// No description provided for @telefoneContato.
  ///
  /// In pt, this message translates to:
  /// **'Telefone de Contato'**
  String get telefoneContato;

  /// No description provided for @paisesAtuamos.
  ///
  /// In pt, this message translates to:
  /// **'Países em que atuamos'**
  String get paisesAtuamos;

  /// No description provided for @solicitarAtendimentoPaises.
  ///
  /// In pt, this message translates to:
  /// **'Solicitar atendimento para o meu país'**
  String get solicitarAtendimentoPaises;

  /// No description provided for @olaBoasVindasPaip.
  ///
  /// In pt, this message translates to:
  /// **'Olá, bem-vindo à PaipFood'**
  String get olaBoasVindasPaip;

  /// No description provided for @vamosConfigurarSuaConta.
  ///
  /// In pt, this message translates to:
  /// **'Vamos configurar sua conta, leva só um minuto.'**
  String get vamosConfigurarSuaConta;

  /// No description provided for @prazer.
  ///
  /// In pt, this message translates to:
  /// **'Prazer'**
  String get prazer;

  /// No description provided for @nomeEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Nome do Estabelecimento'**
  String get nomeEstabelecimento;

  /// No description provided for @cpf.
  ///
  /// In pt, this message translates to:
  /// **'CPF'**
  String get cpf;

  /// No description provided for @cnpj.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ'**
  String get cnpj;

  /// No description provided for @estiloCulinario.
  ///
  /// In pt, this message translates to:
  /// **'Estilo Culinário'**
  String get estiloCulinario;

  /// No description provided for @conteUmPoucoSobreSeuEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Conte um pouco sobre seu estabelecimento'**
  String get conteUmPoucoSobreSeuEstabelecimento;

  /// No description provided for @qualEnderecoEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Qual o endereço do(a)'**
  String get qualEnderecoEstabelecimento;

  /// No description provided for @enderecoEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Endereço do Estabelecimento'**
  String get enderecoEstabelecimento;

  /// No description provided for @vamosLocalizarSeuEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Vamos localizar seu estabelecimento'**
  String get vamosLocalizarSeuEstabelecimento;

  /// No description provided for @novaSenha.
  ///
  /// In pt, this message translates to:
  /// **'Nova Senha'**
  String get novaSenha;

  /// No description provided for @confirmeNovaSenha.
  ///
  /// In pt, this message translates to:
  /// **'Confirme a Nova Senha'**
  String get confirmeNovaSenha;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt': {
  switch (locale.countryCode) {
    case 'BR': return AppLocalizationsPtBr();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
