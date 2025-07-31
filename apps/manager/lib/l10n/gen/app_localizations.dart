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

  /// No description provided for @wppGreetingsMessage.
  ///
  /// In pt, this message translates to:
  /// **'🤖 Olá! Eu sou o Atendente Virtual do(a) [establishment_name]. \n\nPara fazer um pedido com praticidade, clique no link abaixo: \n\n👇🏼 Toque para pedir 👇🏼 \n[link_company]'**
  String get wppGreetingsMessage;

  /// No description provided for @wppPending.
  ///
  /// In pt, this message translates to:
  /// **'Olá [name]👋, \nQue bom te ver por aqui! \n> Recebemos seu pedido, por favor, aguarde a confirmação. \n\n> Aqui está o link se quiser acompanhar:\n[link_order_status]'**
  String get wppPending;

  /// No description provided for @wppAccepted.
  ///
  /// In pt, this message translates to:
  /// **'[name]\nSeu pedido foi aceito!\n\nAqui está o link se quiser acompanhar:\n[link_order_status]'**
  String get wppAccepted;

  /// No description provided for @wppAwaitingDelivery.
  ///
  /// In pt, this message translates to:
  /// **'[name]\n> Seu pedido já está pronto. \nO entregador já está a caminho para coletar seu pedido aqui na loja!'**
  String get wppAwaitingDelivery;

  /// No description provided for @wppAwaitingPickup.
  ///
  /// In pt, this message translates to:
  /// **'Acabou a espera! 😍\n> Seu pedido já está pronto e esperando por você!'**
  String get wppAwaitingPickup;

  /// No description provided for @wppDelivered.
  ///
  /// In pt, this message translates to:
  /// **'Seu pedido foi entregue\nmuito obrigado pela confiança! 😊'**
  String get wppDelivered;

  /// No description provided for @wppInDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Temos uma ótima notícia para você!😀\n> Seu pedido saiu para entrega e logo chegará por aí, Qualquer dúvida, estamos à disposição.'**
  String get wppInDelivery;

  /// No description provided for @wppLocalOrderMessage.
  ///
  /// In pt, this message translates to:
  /// **'Olá [name] 👋\nQue bom te ver por aqui!\n\nSeu pedido foi realizado e já está sendo preparado.✅\n\n> Logo volto com novidades, sobre o status do mesmo.\n\nAqui está o link, se quiser acompanhar:\n[link_order_status]'**
  String get wppLocalOrderMessage;

  /// No description provided for @credit.
  ///
  /// In pt, this message translates to:
  /// **'Crédito'**
  String get credit;

  /// No description provided for @pago.
  ///
  /// In pt, this message translates to:
  /// **'Pago'**
  String get pago;

  /// No description provided for @debit.
  ///
  /// In pt, this message translates to:
  /// **'Débito'**
  String get debit;

  /// No description provided for @voucher.
  ///
  /// In pt, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @foodTicket.
  ///
  /// In pt, this message translates to:
  /// **'Vale Alimentação'**
  String get foodTicket;

  /// No description provided for @mealTicket.
  ///
  /// In pt, this message translates to:
  /// **'Vale Refeição'**
  String get mealTicket;

  /// No description provided for @cash.
  ///
  /// In pt, this message translates to:
  /// **'Dinheiro'**
  String get cash;

  /// No description provided for @pix.
  ///
  /// In pt, this message translates to:
  /// **'Pix'**
  String get pix;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @senha.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get senha;

  /// No description provided for @entrar.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get entrar;

  /// No description provided for @naoTemConta.
  ///
  /// In pt, this message translates to:
  /// **'Não tem conta?'**
  String get naoTemConta;

  /// No description provided for @registrese.
  ///
  /// In pt, this message translates to:
  /// **'Registe-se'**
  String get registrese;

  /// No description provided for @esqueceuSenha.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu sua senha?'**
  String get esqueceuSenha;

  /// No description provided for @definicoes.
  ///
  /// In pt, this message translates to:
  /// **'Definições'**
  String get definicoes;

  /// No description provided for @aparencia.
  ///
  /// In pt, this message translates to:
  /// **'Aparência'**
  String get aparencia;

  /// No description provided for @informacoes.
  ///
  /// In pt, this message translates to:
  /// **'Informações'**
  String get informacoes;

  /// No description provided for @horaioFuncionamento.
  ///
  /// In pt, this message translates to:
  /// **'Horário de funcionamento'**
  String get horaioFuncionamento;

  /// No description provided for @formasPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Formas de pagamento'**
  String get formasPagamento;

  /// No description provided for @menu.
  ///
  /// In pt, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @areasEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Áreas de entrega'**
  String get areasEntrega;

  /// No description provided for @cores.
  ///
  /// In pt, this message translates to:
  /// **'Cores'**
  String get cores;

  /// No description provided for @corPrimaria.
  ///
  /// In pt, this message translates to:
  /// **'Cor primária'**
  String get corPrimaria;

  /// No description provided for @descCorPrimaria.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma cor para ser a cor principal do seu app.'**
  String get descCorPrimaria;

  /// No description provided for @imagens.
  ///
  /// In pt, this message translates to:
  /// **'Imagens'**
  String get imagens;

  /// No description provided for @descImagens.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma imagem de capa e um logótipo para a sua loja.'**
  String get descImagens;

  /// No description provided for @endereco.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get endereco;

  /// No description provided for @adicionarEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar endereço'**
  String get adicionarEndereco;

  /// No description provided for @enderecoInvalido.
  ///
  /// In pt, this message translates to:
  /// **'Endreço inválido'**
  String get enderecoInvalido;

  /// No description provided for @adicioneEnderecoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Adicone um endereço de entrega'**
  String get adicioneEnderecoEntrega;

  /// No description provided for @selecioneEnderecoPadraoCliente.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o endereço de entrega padrão do cliente'**
  String get selecioneEnderecoPadraoCliente;

  /// No description provided for @enderecoCliente.
  ///
  /// In pt, this message translates to:
  /// **'Endereço do cliente'**
  String get enderecoCliente;

  /// No description provided for @selecioneClientePedido.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um cliente para efetuar o pedido'**
  String get selecioneClientePedido;

  /// No description provided for @selecionarCliente.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar cliente'**
  String get selecionarCliente;

  /// No description provided for @pesquiseClienteNomeTelefone.
  ///
  /// In pt, this message translates to:
  /// **'Pesquise seu cliente por nome ou telefone'**
  String get pesquiseClienteNomeTelefone;

  /// No description provided for @adicionarCliente.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar cliente'**
  String get adicionarCliente;

  /// No description provided for @novoCliente.
  ///
  /// In pt, this message translates to:
  /// **'Novo cliente'**
  String get novoCliente;

  /// No description provided for @nomeCompleto.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get nomeCompleto;

  /// No description provided for @descEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Informe o endereço do seu estabelecimento'**
  String get descEndereco;

  /// No description provided for @numero.
  ///
  /// In pt, this message translates to:
  /// **'Número'**
  String get numero;

  /// No description provided for @dataNascimento.
  ///
  /// In pt, this message translates to:
  /// **'Data de nascimento'**
  String get dataNascimento;

  /// No description provided for @complemento.
  ///
  /// In pt, this message translates to:
  /// **'Complemento'**
  String get complemento;

  /// No description provided for @informacoesPrincipais.
  ///
  /// In pt, this message translates to:
  /// **'Informações Principais'**
  String get informacoesPrincipais;

  /// No description provided for @descInformacoesPrincipais.
  ///
  /// In pt, this message translates to:
  /// **'Defina um nome, valor mínimo de pedidos e as informações de contacto'**
  String get descInformacoesPrincipais;

  /// No description provided for @nomeLoja.
  ///
  /// In pt, this message translates to:
  /// **'Nome da Loja'**
  String get nomeLoja;

  /// No description provided for @descricao.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get descricao;

  /// No description provided for @cnpj.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ'**
  String get cnpj;

  /// No description provided for @razaoSocial.
  ///
  /// In pt, this message translates to:
  /// **'Razão Social'**
  String get razaoSocial;

  /// No description provided for @pedidoMin.
  ///
  /// In pt, this message translates to:
  /// **'Pedido mínimo'**
  String get pedidoMin;

  /// No description provided for @loja.
  ///
  /// In pt, this message translates to:
  /// **'Loja'**
  String get loja;

  /// No description provided for @descLoja.
  ///
  /// In pt, this message translates to:
  /// **'Link da loja e modos de atendimento (Entrega, Recolha, Mesa, Quiosque)'**
  String get descLoja;

  /// No description provided for @linkLoja.
  ///
  /// In pt, this message translates to:
  /// **'Link da loja'**
  String get linkLoja;

  /// No description provided for @descLinkLoja.
  ///
  /// In pt, this message translates to:
  /// **'Copie o link da sua loja e envie para seus clientes (Não é permitido alterar).'**
  String get descLinkLoja;

  /// No description provided for @redesSociais.
  ///
  /// In pt, this message translates to:
  /// **'Redes Sociais'**
  String get redesSociais;

  /// No description provided for @descredesSociais.
  ///
  /// In pt, this message translates to:
  /// **'Complete com o link das redes sociais do seu negócio, caso tenha'**
  String get descredesSociais;

  /// No description provided for @adicionar.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get adicionar;

  /// No description provided for @pizzas.
  ///
  /// In pt, this message translates to:
  /// **'Pizzas'**
  String get pizzas;

  /// No description provided for @nome.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nome;

  /// No description provided for @preco.
  ///
  /// In pt, this message translates to:
  /// **'Preço'**
  String get preco;

  /// No description provided for @precoPromocional.
  ///
  /// In pt, this message translates to:
  /// **'Preço promocional'**
  String get precoPromocional;

  /// No description provided for @opcoes.
  ///
  /// In pt, this message translates to:
  /// **'Opções'**
  String get opcoes;

  /// No description provided for @opcao.
  ///
  /// In pt, this message translates to:
  /// **'Opção'**
  String get opcao;

  /// No description provided for @addOpcao.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar opção de tamanho'**
  String get addOpcao;

  /// No description provided for @cancelar.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @salvar.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get salvar;

  /// No description provided for @complementos.
  ///
  /// In pt, this message translates to:
  /// **'Complementos'**
  String get complementos;

  /// No description provided for @nomeItem.
  ///
  /// In pt, this message translates to:
  /// **'Informe um nome para este item'**
  String get nomeItem;

  /// No description provided for @preSelecionado.
  ///
  /// In pt, this message translates to:
  /// **'Pré selecionado'**
  String get preSelecionado;

  /// No description provided for @quantidadeSabores.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade de sabores'**
  String get quantidadeSabores;

  /// No description provided for @bordas.
  ///
  /// In pt, this message translates to:
  /// **'Bordas'**
  String get bordas;

  /// No description provided for @descPageTamnhosQuantidadePizza.
  ///
  /// In pt, this message translates to:
  /// **'Defina os tamanhos e quantidade de sabores das suas pizzas.'**
  String get descPageTamnhosQuantidadePizza;

  /// No description provided for @tamanhos.
  ///
  /// In pt, this message translates to:
  /// **'Tamanhos'**
  String get tamanhos;

  /// No description provided for @tamanhoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tamanho - fátias'**
  String get tamanhoLabel;

  /// No description provided for @adicionais.
  ///
  /// In pt, this message translates to:
  /// **'Adicionais'**
  String get adicionais;

  /// No description provided for @pizzaGrandeNome.
  ///
  /// In pt, this message translates to:
  /// **'Pizza grande - 8 Fátias'**
  String get pizzaGrandeNome;

  /// No description provided for @pizzaPequenaNome.
  ///
  /// In pt, this message translates to:
  /// **'Pizza pequena - individual'**
  String get pizzaPequenaNome;

  /// No description provided for @sabores.
  ///
  /// In pt, this message translates to:
  /// **'Sabores'**
  String get sabores;

  /// No description provided for @complementoBordasDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma borda para a sua pizza'**
  String get complementoBordasDesc;

  /// No description provided for @massas.
  ///
  /// In pt, this message translates to:
  /// **'Massas'**
  String get massas;

  /// No description provided for @complementoMassasDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma massa para a sua pizza'**
  String get complementoMassasDesc;

  /// No description provided for @bar.
  ///
  /// In pt, this message translates to:
  /// **'Bar & Restaurante'**
  String get bar;

  /// No description provided for @bistro.
  ///
  /// In pt, this message translates to:
  /// **'Bistrô francês'**
  String get bistro;

  /// No description provided for @buffet.
  ///
  /// In pt, this message translates to:
  /// **'Buffet'**
  String get buffet;

  /// No description provided for @cafe.
  ///
  /// In pt, this message translates to:
  /// **'Cafeteria'**
  String get cafe;

  /// No description provided for @italiana.
  ///
  /// In pt, this message translates to:
  /// **'Italiana'**
  String get italiana;

  /// No description provided for @churrascaria.
  ///
  /// In pt, this message translates to:
  /// **'Churrascaria'**
  String get churrascaria;

  /// No description provided for @comidaCaseira.
  ///
  /// In pt, this message translates to:
  /// **'Comida Caseira'**
  String get comidaCaseira;

  /// No description provided for @fastFood.
  ///
  /// In pt, this message translates to:
  /// **'Fast Food'**
  String get fastFood;

  /// No description provided for @comidaSaudavel.
  ///
  /// In pt, this message translates to:
  /// **'Comida Saudável'**
  String get comidaSaudavel;

  /// No description provided for @creperia.
  ///
  /// In pt, this message translates to:
  /// **'Creperia'**
  String get creperia;

  /// No description provided for @arabe.
  ///
  /// In pt, this message translates to:
  /// **'Árabe'**
  String get arabe;

  /// No description provided for @emporio.
  ///
  /// In pt, this message translates to:
  /// **'Empório'**
  String get emporio;

  /// No description provided for @mercado.
  ///
  /// In pt, this message translates to:
  /// **'Mercado'**
  String get mercado;

  /// No description provided for @oriental.
  ///
  /// In pt, this message translates to:
  /// **'Oriental'**
  String get oriental;

  /// No description provided for @japonesa.
  ///
  /// In pt, this message translates to:
  /// **'Japonesa'**
  String get japonesa;

  /// No description provided for @chinesa.
  ///
  /// In pt, this message translates to:
  /// **'Chinesa'**
  String get chinesa;

  /// No description provided for @frutosMar.
  ///
  /// In pt, this message translates to:
  /// **'Frutos do Mar'**
  String get frutosMar;

  /// No description provided for @hamburgueria.
  ///
  /// In pt, this message translates to:
  /// **'Hamburgueria'**
  String get hamburgueria;

  /// No description provided for @pizzaria.
  ///
  /// In pt, this message translates to:
  /// **'Pizzaria'**
  String get pizzaria;

  /// No description provided for @sorveteria.
  ///
  /// In pt, this message translates to:
  /// **'Sorveteria'**
  String get sorveteria;

  /// No description provided for @padaria.
  ///
  /// In pt, this message translates to:
  /// **'Padaria'**
  String get padaria;

  /// No description provided for @sanduiches.
  ///
  /// In pt, this message translates to:
  /// **'Sanduíches'**
  String get sanduiches;

  /// No description provided for @sucos.
  ///
  /// In pt, this message translates to:
  /// **'Sucos & Vitaminas'**
  String get sucos;

  /// No description provided for @farmacia.
  ///
  /// In pt, this message translates to:
  /// **'Farmácia'**
  String get farmacia;

  /// No description provided for @vegetariana.
  ///
  /// In pt, this message translates to:
  /// **'Vegetariana'**
  String get vegetariana;

  /// No description provided for @vegana.
  ///
  /// In pt, this message translates to:
  /// **'Vegana'**
  String get vegana;

  /// No description provided for @aPartirDe.
  ///
  /// In pt, this message translates to:
  /// **'A partir de {value}'**
  String aPartirDe(Object value);

  /// No description provided for @deletar.
  ///
  /// In pt, this message translates to:
  /// **'Deletar'**
  String get deletar;

  /// No description provided for @editar.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get editar;

  /// No description provided for @sim.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get sim;

  /// No description provided for @bordaCatupiry.
  ///
  /// In pt, this message translates to:
  /// **'Catupiry'**
  String get bordaCatupiry;

  /// No description provided for @bordaCheddar.
  ///
  /// In pt, this message translates to:
  /// **'Cheddar'**
  String get bordaCheddar;

  /// No description provided for @saborMussarela.
  ///
  /// In pt, this message translates to:
  /// **'Mussarela'**
  String get saborMussarela;

  /// No description provided for @descMussarela.
  ///
  /// In pt, this message translates to:
  /// **'Molho de tomate caseiro, mussarela, catupiry, azeitonas e orégano.'**
  String get descMussarela;

  /// No description provided for @saborCalabresa.
  ///
  /// In pt, this message translates to:
  /// **'Calabresa'**
  String get saborCalabresa;

  /// No description provided for @descCalabresa.
  ///
  /// In pt, this message translates to:
  /// **'Molho de tomate caseiro, calabresa, catupiry, cebola, azeitonas e orégano.'**
  String get descCalabresa;

  /// No description provided for @pizzaGrandeDefault.
  ///
  /// In pt, this message translates to:
  /// **'Pizza Grande - 8 fátias'**
  String get pizzaGrandeDefault;

  /// No description provided for @pizzaPequenaDefault.
  ///
  /// In pt, this message translates to:
  /// **'Pizza Pequena - Individual'**
  String get pizzaPequenaDefault;

  /// No description provided for @massaTradicional.
  ///
  /// In pt, this message translates to:
  /// **'Massa Tradicional'**
  String get massaTradicional;

  /// No description provided for @emptySateteProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Voce ainda não adicionou nenhum produto.'**
  String get emptySateteProdutos;

  /// No description provided for @emptySateteCategorias.
  ///
  /// In pt, this message translates to:
  /// **'Voce ainda não adicionou nenhuma categoria.'**
  String get emptySateteCategorias;

  /// No description provided for @emptySateteComplementos.
  ///
  /// In pt, this message translates to:
  /// **'Voce ainda não adicionou nenhum complemento.'**
  String get emptySateteComplementos;

  /// No description provided for @emptySateteSaborPizza.
  ///
  /// In pt, this message translates to:
  /// **'Voce ainda não adicionou nenhum sabor.'**
  String get emptySateteSaborPizza;

  /// No description provided for @adicionarSaborPizzaA.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar sabor a {name}'**
  String adicionarSaborPizzaA(Object name);

  /// No description provided for @emptyStateItens.
  ///
  /// In pt, this message translates to:
  /// **'Voce ainda não adicionou nenhum item.'**
  String get emptyStateItens;

  /// No description provided for @adicionarProdutoA.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar produto a {name}'**
  String adicionarProdutoA(Object name);

  /// No description provided for @adicionarItemA.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar item a {name}'**
  String adicionarItemA(Object name);

  /// No description provided for @precoPromocionalDeveSerMenorQuePreco.
  ///
  /// In pt, this message translates to:
  /// **'O preço promocional deve ser menor que o preço'**
  String get precoPromocionalDeveSerMenorQuePreco;

  /// No description provided for @imagemExcluidaSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Imagem excluida com sucesso!'**
  String get imagemExcluidaSucesso;

  /// No description provided for @deletarImagem.
  ///
  /// In pt, this message translates to:
  /// **'Excluir imagem'**
  String get deletarImagem;

  /// No description provided for @uploadImagem.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar imagem'**
  String get uploadImagem;

  /// No description provided for @descZoomImagem.
  ///
  /// In pt, this message translates to:
  /// **'Utilize o scroll do seu mouse para dar zoom +- na sua imagem'**
  String get descZoomImagem;

  /// No description provided for @imagemSalvaComSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Imagem salva com sucesso!'**
  String get imagemSalvaComSucesso;

  /// No description provided for @vocePrecisaSelecionarUmaImagem.
  ///
  /// In pt, this message translates to:
  /// **'Você precisa selecionar uma imagem'**
  String get vocePrecisaSelecionarUmaImagem;

  /// No description provided for @adicionarTamanho.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar tamanho'**
  String get adicionarTamanho;

  /// No description provided for @categorias.
  ///
  /// In pt, this message translates to:
  /// **'Categorias'**
  String get categorias;

  /// No description provided for @addCategoria.
  ///
  /// In pt, this message translates to:
  /// **'Para adicionar uma nova categoria basta clicar no botão ao lado'**
  String get addCategoria;

  /// No description provided for @descMenu.
  ///
  /// In pt, this message translates to:
  /// **'Faça a gestão dos seus produtos'**
  String get descMenu;

  /// No description provided for @sincronizar.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizar alterações'**
  String get sincronizar;

  /// No description provided for @tituloEditarCategoria.
  ///
  /// In pt, this message translates to:
  /// **'Edite sua categoria.'**
  String get tituloEditarCategoria;

  /// No description provided for @tituloEditarComplemento.
  ///
  /// In pt, this message translates to:
  /// **'Edite seu complemento.'**
  String get tituloEditarComplemento;

  /// No description provided for @tituloComplemento.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre e defina as regras do seu complemento'**
  String get tituloComplemento;

  /// No description provided for @tituloCategoria.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma opção de categoria.'**
  String get tituloCategoria;

  /// No description provided for @produtos.
  ///
  /// In pt, this message translates to:
  /// **'Produtos'**
  String get produtos;

  /// No description provided for @descCategoriaProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Produtos no geral ex: lanches, doces, marmitas, etc...'**
  String get descCategoriaProdutos;

  /// No description provided for @descCategoriaPizza.
  ///
  /// In pt, this message translates to:
  /// **'Categoria exclusiva para pizzas'**
  String get descCategoriaPizza;

  /// No description provided for @nomeDaCategoria.
  ///
  /// In pt, this message translates to:
  /// **'Nome da categoria*'**
  String get nomeDaCategoria;

  /// No description provided for @gratuito.
  ///
  /// In pt, this message translates to:
  /// **'Gratuito'**
  String get gratuito;

  /// No description provided for @extras.
  ///
  /// In pt, this message translates to:
  /// **'Extras'**
  String get extras;

  /// No description provided for @tooltipNomeComplemento.
  ///
  /// In pt, this message translates to:
  /// **'Este campo aparece para o cliente\nno cardapio'**
  String get tooltipNomeComplemento;

  /// No description provided for @tooltipIdentificador.
  ///
  /// In pt, this message translates to:
  /// **'Este campo aparece somente para você \npara ajudar a identificar o complemento'**
  String get tooltipIdentificador;

  /// No description provided for @identifier.
  ///
  /// In pt, this message translates to:
  /// **'Identificador'**
  String get identifier;

  /// No description provided for @hintIdentifier.
  ///
  /// In pt, this message translates to:
  /// **'Extras_lanches_simples_01'**
  String get hintIdentifier;

  /// No description provided for @quantidadeMinima.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade minima'**
  String get quantidadeMinima;

  /// No description provided for @hintQuantidadeMinima.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 0'**
  String get hintQuantidadeMinima;

  /// No description provided for @quantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade maxima'**
  String get quantidadeMaxima;

  /// No description provided for @hintQuantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 5'**
  String get hintQuantidadeMaxima;

  /// No description provided for @validatorQuantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade maxima deve ser maior que a quantidade minima.'**
  String get validatorQuantidadeMaxima;

  /// No description provided for @tipoDoSeletor.
  ///
  /// In pt, this message translates to:
  /// **'Tipo do seletor'**
  String get tipoDoSeletor;

  /// No description provided for @seletorUnico.
  ///
  /// In pt, this message translates to:
  /// **'Seletor unico'**
  String get seletorUnico;

  /// No description provided for @descSeletorUnico.
  ///
  /// In pt, this message translates to:
  /// **'Permite selecionar apenas uma vez o mesmo item.'**
  String get descSeletorUnico;

  /// No description provided for @seletorMultiplo.
  ///
  /// In pt, this message translates to:
  /// **'Seletor multiplo'**
  String get seletorMultiplo;

  /// No description provided for @descSeletorMultiplo.
  ///
  /// In pt, this message translates to:
  /// **'Permite selecionar varias vezes o mesmo item.'**
  String get descSeletorMultiplo;

  /// No description provided for @obrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Obrigatório'**
  String get obrigatorio;

  /// No description provided for @feedbackSucessImagemDeletada.
  ///
  /// In pt, this message translates to:
  /// **'Imagem deletada com sucesso!'**
  String get feedbackSucessImagemDeletada;

  /// No description provided for @bordasEMassas.
  ///
  /// In pt, this message translates to:
  /// **'Bordas & Massas'**
  String get bordasEMassas;

  /// No description provided for @tituloBordasEMassas.
  ///
  /// In pt, this message translates to:
  /// **'Definas as opções de bordas e massa da suas pizzas'**
  String get tituloBordasEMassas;

  /// No description provided for @descSelecionarImage.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma nova imagem para o seu item'**
  String get descSelecionarImage;

  /// No description provided for @tituloConfirmacaoExclusao.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir?'**
  String get tituloConfirmacaoExclusao;

  /// No description provided for @descConfirmacaoExclusao.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita digite {sim} para confirmar.'**
  String descConfirmacaoExclusao(Object sim);

  /// No description provided for @validatorConfirmacaoExclusao.
  ///
  /// In pt, this message translates to:
  /// **'Digite {sim} no campo para confirmar.'**
  String validatorConfirmacaoExclusao(Object sim);

  /// No description provided for @pedidos.
  ///
  /// In pt, this message translates to:
  /// **'Pedidos'**
  String get pedidos;

  /// No description provided for @pedido.
  ///
  /// In pt, this message translates to:
  /// **'Pedido'**
  String get pedido;

  /// No description provided for @descComplementRequiredObrigatio.
  ///
  /// In pt, this message translates to:
  /// **'Escolha {qty} opção'**
  String descComplementRequiredObrigatio(Object qty);

  /// No description provided for @descComplementRequiredObrigatioPlural.
  ///
  /// In pt, this message translates to:
  /// **'Escolha {qty} opções'**
  String descComplementRequiredObrigatioPlural(Object qty);

  /// No description provided for @descComplementObrigatio.
  ///
  /// In pt, this message translates to:
  /// **'Escolha ao menos {qty} opção'**
  String descComplementObrigatio(Object qty);

  /// No description provided for @descComplementObrigatioPlural.
  ///
  /// In pt, this message translates to:
  /// **'Escolha ao menos {qty} opções'**
  String descComplementObrigatioPlural(Object qty);

  /// No description provided for @descComplementLivre.
  ///
  /// In pt, this message translates to:
  /// **'Escolha até {qty} opção'**
  String descComplementLivre(Object qty);

  /// No description provided for @descComplementLivrePlural.
  ///
  /// In pt, this message translates to:
  /// **'Escolha até {qty} opções'**
  String descComplementLivrePlural(Object qty);

  /// No description provided for @descComplementLivreIlimitado.
  ///
  /// In pt, this message translates to:
  /// **'Escolha quantas opções quiser'**
  String get descComplementLivreIlimitado;

  /// No description provided for @descComplementPizza.
  ///
  /// In pt, this message translates to:
  /// **'Escolha {qty} sabor'**
  String descComplementPizza(Object qty);

  /// No description provided for @descComplementPizzaPlural.
  ///
  /// In pt, this message translates to:
  /// **'Escolha {qty} sabores'**
  String descComplementPizzaPlural(Object qty);

  /// No description provided for @descComplementAte.
  ///
  /// In pt, this message translates to:
  /// **'Até {qty}'**
  String descComplementAte(Object qty);

  /// No description provided for @observacoes.
  ///
  /// In pt, this message translates to:
  /// **'Observações'**
  String get observacoes;

  /// No description provided for @observacoesDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escreva suas Observações aqui...'**
  String get observacoesDesc;

  /// No description provided for @sabor.
  ///
  /// In pt, this message translates to:
  /// **'{qty} Sabor'**
  String sabor(Object qty);

  /// No description provided for @saborPlural.
  ///
  /// In pt, this message translates to:
  /// **'{qty} Sabores'**
  String saborPlural(Object qty);

  /// No description provided for @obs.
  ///
  /// In pt, this message translates to:
  /// **'Obs: {content}'**
  String obs(Object content);

  /// No description provided for @subTotalValor.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal {value}'**
  String subTotalValor(Object value);

  /// No description provided for @totalMaisPreco.
  ///
  /// In pt, this message translates to:
  /// **'Total {value}'**
  String totalMaisPreco(Object value);

  /// No description provided for @pdv.
  ///
  /// In pt, this message translates to:
  /// **'Pdv'**
  String get pdv;

  /// No description provided for @selecionarMesa.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar mesa'**
  String get selecionarMesa;

  /// No description provided for @clienteAvulso.
  ///
  /// In pt, this message translates to:
  /// **'Cliente avulso'**
  String get clienteAvulso;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @ola.
  ///
  /// In pt, this message translates to:
  /// **'Olá'**
  String get ola;

  /// No description provided for @pesquisarProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar produtos'**
  String get pesquisarProdutos;

  /// No description provided for @impressao.
  ///
  /// In pt, this message translates to:
  /// **'Impressão'**
  String get impressao;

  /// No description provided for @impressoras.
  ///
  /// In pt, this message translates to:
  /// **'Impressoras'**
  String get impressoras;

  /// No description provided for @taxaEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Taxa de entrega'**
  String get taxaEntrega;

  /// No description provided for @desconto.
  ///
  /// In pt, this message translates to:
  /// **'Desconto'**
  String get desconto;

  /// No description provided for @subtotal.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @total.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @troco.
  ///
  /// In pt, this message translates to:
  /// **'Troco'**
  String get troco;

  /// No description provided for @telefone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get telefone;

  /// No description provided for @bairro.
  ///
  /// In pt, this message translates to:
  /// **'Bairro'**
  String get bairro;

  /// No description provided for @credito.
  ///
  /// In pt, this message translates to:
  /// **'Credito'**
  String get credito;

  /// No description provided for @debito.
  ///
  /// In pt, this message translates to:
  /// **'Debito'**
  String get debito;

  /// No description provided for @money.
  ///
  /// In pt, this message translates to:
  /// **'Dinheiro'**
  String get money;

  /// No description provided for @entrega.
  ///
  /// In pt, this message translates to:
  /// **'Entrega'**
  String get entrega;

  /// No description provided for @retirada.
  ///
  /// In pt, this message translates to:
  /// **'Retirada'**
  String get retirada;

  /// No description provided for @consumo.
  ///
  /// In pt, this message translates to:
  /// **'retirada_consumo'**
  String get consumo;

  /// No description provided for @kiosk.
  ///
  /// In pt, this message translates to:
  /// **'Kiosk'**
  String get kiosk;

  /// No description provided for @mesa.
  ///
  /// In pt, this message translates to:
  /// **'Mesa'**
  String get mesa;

  /// No description provided for @trocop.
  ///
  /// In pt, this message translates to:
  /// **'Troco p/'**
  String get trocop;

  /// No description provided for @finalizar.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar'**
  String get finalizar;

  /// No description provided for @pending.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In pt, this message translates to:
  /// **'Aceito'**
  String get accepted;

  /// No description provided for @inDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Em entrega'**
  String get inDelivery;

  /// No description provided for @awaitingPickup.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando retirada'**
  String get awaitingPickup;

  /// No description provided for @awaitingDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando entregador'**
  String get awaitingDelivery;

  /// No description provided for @delivered.
  ///
  /// In pt, this message translates to:
  /// **'Entregue'**
  String get delivered;

  /// No description provided for @canceled.
  ///
  /// In pt, this message translates to:
  /// **'Cancelado'**
  String get canceled;

  /// No description provided for @lost.
  ///
  /// In pt, this message translates to:
  /// **'Perdido'**
  String get lost;

  /// No description provided for @segunda.
  ///
  /// In pt, this message translates to:
  /// **'Segunda'**
  String get segunda;

  /// No description provided for @terca.
  ///
  /// In pt, this message translates to:
  /// **'Terça'**
  String get terca;

  /// No description provided for @quarta.
  ///
  /// In pt, this message translates to:
  /// **'Quarta'**
  String get quarta;

  /// No description provided for @quinta.
  ///
  /// In pt, this message translates to:
  /// **'Quinta'**
  String get quinta;

  /// No description provided for @sexta.
  ///
  /// In pt, this message translates to:
  /// **'Sexta'**
  String get sexta;

  /// No description provided for @sabado.
  ///
  /// In pt, this message translates to:
  /// **'Sábado'**
  String get sabado;

  /// No description provided for @domingo.
  ///
  /// In pt, this message translates to:
  /// **'Domingo'**
  String get domingo;

  /// No description provided for @faturaDisponivel.
  ///
  /// In pt, this message translates to:
  /// **'Fatura disponível'**
  String get faturaDisponivel;

  /// No description provided for @faturaVencida.
  ///
  /// In pt, this message translates to:
  /// **'Fatura vencida'**
  String get faturaVencida;

  /// No description provided for @sistemaBloqueado.
  ///
  /// In pt, this message translates to:
  /// **'Sistema bloqueado'**
  String get sistemaBloqueado;

  /// No description provided for @faturaDescVencimento.
  ///
  /// In pt, this message translates to:
  /// **'Sua fatura vence em {date}'**
  String faturaDescVencimento(Object date);

  /// No description provided for @faturaAvisoBloqueio.
  ///
  /// In pt, this message translates to:
  /// **'Seu sistema será bloqueado em {days} dia'**
  String faturaAvisoBloqueio(Object days);

  /// No description provided for @faturaDescBloqueado.
  ///
  /// In pt, this message translates to:
  /// **'Seu sistema foi bloqueado, regularize a fatura para ativa-lo novamente.\nSua fatura venceu em {date}'**
  String faturaDescBloqueado(Object date);

  /// No description provided for @faturaDeMaisUmDia.
  ///
  /// In pt, this message translates to:
  /// **'Me de mais um dia'**
  String get faturaDeMaisUmDia;

  /// No description provided for @useWhatsappAutomatizarSistema.
  ///
  /// In pt, this message translates to:
  /// **'Use o WhatsApp para automatizar o seu sistema'**
  String get useWhatsappAutomatizarSistema;

  /// No description provided for @atualizeSeusClientesSobreOsStatusDosPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Atualize os seus clientes sobre os estados das encomendas, automatize o seu WhatsApp e não deixe os seus clientes à espera.'**
  String get atualizeSeusClientesSobreOsStatusDosPedidos;

  /// No description provided for @abrirSeuWhatsappNoSeuCelularNaJanelaConversas.
  ///
  /// In pt, this message translates to:
  /// **'Abra o seu WhatsApp no seu telemóvel, na janela de conversas.'**
  String get abrirSeuWhatsappNoSeuCelularNaJanelaConversas;

  /// No description provided for @toqueEm.
  ///
  /// In pt, this message translates to:
  /// **'Toque em'**
  String get toqueEm;

  /// No description provided for @maisOpcoes.
  ///
  /// In pt, this message translates to:
  /// **'Mais opções'**
  String get maisOpcoes;

  /// No description provided for @seEstiverNoAndroid.
  ///
  /// In pt, this message translates to:
  /// **'se estiver no Android, ou em'**
  String get seEstiverNoAndroid;

  /// No description provided for @configuracoes.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get configuracoes;

  /// No description provided for @seEstiverNoIos.
  ///
  /// In pt, this message translates to:
  /// **'se estiver no iOS.'**
  String get seEstiverNoIos;

  /// No description provided for @dispositivosConectados.
  ///
  /// In pt, this message translates to:
  /// **'Dispositivos ligados'**
  String get dispositivosConectados;

  /// No description provided for @eEmSeguidaEm.
  ///
  /// In pt, this message translates to:
  /// **'e, em seguida, em'**
  String get eEmSeguidaEm;

  /// No description provided for @conectarDispositivo.
  ///
  /// In pt, this message translates to:
  /// **'Ligar dispositivo.'**
  String get conectarDispositivo;

  /// No description provided for @aponteSeuCelularParaEstaTelaParaEscanear.
  ///
  /// In pt, this message translates to:
  /// **'Aponte o seu telemóvel para esta tela para digitalizar o código QR.'**
  String get aponteSeuCelularParaEstaTelaParaEscanear;

  /// No description provided for @conectado.
  ///
  /// In pt, this message translates to:
  /// **'Conectado'**
  String get conectado;

  /// No description provided for @desconectado.
  ///
  /// In pt, this message translates to:
  /// **'Desconectado'**
  String get desconectado;

  /// No description provided for @data.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @entregador.
  ///
  /// In pt, this message translates to:
  /// **'Entregador'**
  String get entregador;

  /// No description provided for @orderType.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de pedido'**
  String get orderType;

  /// No description provided for @comprouAMes.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há 1 mês'**
  String get comprouAMes;

  /// No description provided for @comprouAMeses.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há {qty} meses'**
  String comprouAMeses(Object qty);

  /// No description provided for @comprouASemana.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há 1 semana'**
  String get comprouASemana;

  /// No description provided for @comprouASemanas.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há {qty} semanas'**
  String comprouASemanas(Object qty);

  /// No description provided for @comprouAAno.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há 1 ano'**
  String get comprouAAno;

  /// No description provided for @comprouAAnos.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há {qty} anos'**
  String comprouAAnos(Object qty);

  /// No description provided for @comprouADia.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há 1 dia'**
  String get comprouADia;

  /// No description provided for @comprouADias.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há {qty} dias'**
  String comprouADias(Object qty);

  /// No description provided for @comprouAHora.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há 1 hora'**
  String get comprouAHora;

  /// No description provided for @comprouAHoras.
  ///
  /// In pt, this message translates to:
  /// **'Comprou há {qty} horas'**
  String comprouAHoras(Object qty);

  /// No description provided for @comprouAPouco.
  ///
  /// In pt, this message translates to:
  /// **'Comprou pouco'**
  String get comprouAPouco;

  /// No description provided for @status.
  ///
  /// In pt, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @agendado.
  ///
  /// In pt, this message translates to:
  /// **'Agendado'**
  String get agendado;

  /// No description provided for @agendamentos.
  ///
  /// In pt, this message translates to:
  /// **'Agendamentos'**
  String get agendamentos;

  /// No description provided for @ajustes.
  ///
  /// In pt, this message translates to:
  /// **'Ajustes'**
  String get ajustes;

  /// No description provided for @habilitarAgendamentos.
  ///
  /// In pt, this message translates to:
  /// **'Habilitar agendamentos'**
  String get habilitarAgendamentos;

  /// No description provided for @habilitarAgendamentosAmanha.
  ///
  /// In pt, this message translates to:
  /// **'Habilitar agendamentos para amanha'**
  String get habilitarAgendamentosAmanha;

  /// No description provided for @vendasDoDia.
  ///
  /// In pt, this message translates to:
  /// **'Vendas do dia'**
  String get vendasDoDia;

  /// No description provided for @relatorios.
  ///
  /// In pt, this message translates to:
  /// **'Relatórios'**
  String get relatorios;

  /// No description provided for @entregadores.
  ///
  /// In pt, this message translates to:
  /// **'Entregadores'**
  String get entregadores;

  /// No description provided for @automacoes.
  ///
  /// In pt, this message translates to:
  /// **'Automações'**
  String get automacoes;

  /// No description provided for @duplicar.
  ///
  /// In pt, this message translates to:
  /// **'Duplicar'**
  String get duplicar;

  /// No description provided for @available.
  ///
  /// In pt, this message translates to:
  /// **'Livre'**
  String get available;

  /// No description provided for @occupied.
  ///
  /// In pt, this message translates to:
  /// **'Ocupada'**
  String get occupied;

  /// No description provided for @reserved.
  ///
  /// In pt, this message translates to:
  /// **'Reservada'**
  String get reserved;

  /// No description provided for @closingAccount.
  ///
  /// In pt, this message translates to:
  /// **'Fechando conta'**
  String get closingAccount;

  /// No description provided for @cleaning.
  ///
  /// In pt, this message translates to:
  /// **'Limpando'**
  String get cleaning;

  /// No description provided for @inMaintenance.
  ///
  /// In pt, this message translates to:
  /// **'Em manutenção'**
  String get inMaintenance;

  /// No description provided for @fechar.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get fechar;

  /// No description provided for @pagar.
  ///
  /// In pt, this message translates to:
  /// **'Pagar'**
  String get pagar;

  /// No description provided for @encerrandoSistema.
  ///
  /// In pt, this message translates to:
  /// **'Encerrando o sistema'**
  String get encerrandoSistema;

  /// No description provided for @aguardandoPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando pagamento'**
  String get aguardandoPagamento;

  /// No description provided for @alteracoesSalvas.
  ///
  /// In pt, this message translates to:
  /// **'Alterações salvas'**
  String get alteracoesSalvas;

  /// No description provided for @necessarioReiniciar.
  ///
  /// In pt, this message translates to:
  /// **'Necessário reiniciar o sistema'**
  String get necessarioReiniciar;

  /// No description provided for @fecharSistema.
  ///
  /// In pt, this message translates to:
  /// **'Fechar sistema'**
  String get fecharSistema;

  /// No description provided for @restaurar.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar'**
  String get restaurar;

  /// No description provided for @restauracaoEfetuada.
  ///
  /// In pt, this message translates to:
  /// **'Restauração efetuada'**
  String get restauracaoEfetuada;

  /// No description provided for @salvo.
  ///
  /// In pt, this message translates to:
  /// **'Salvo'**
  String get salvo;

  /// No description provided for @opsModuloPermitidoApenasTermianlPrincipal.
  ///
  /// In pt, this message translates to:
  /// **'Ops! \nEste modulo so pode ser acessado pelo terminal principal'**
  String get opsModuloPermitidoApenasTermianlPrincipal;

  /// No description provided for @servidorWppIniciando.
  ///
  /// In pt, this message translates to:
  /// **'\'O Servidor do whatsapp está sendo inicializado... \nTente novamente daqui um minuto.\n se persistir reinicie o sistema e tente novamente.'**
  String get servidorWppIniciando;

  /// No description provided for @tentarNovamente.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get tentarNovamente;

  /// No description provided for @conectar.
  ///
  /// In pt, this message translates to:
  /// **'Conectar'**
  String get conectar;

  /// No description provided for @destro.
  ///
  /// In pt, this message translates to:
  /// **'Destro'**
  String get destro;

  /// No description provided for @descDestro.
  ///
  /// In pt, this message translates to:
  /// **'Opera com a mão direita ou esquerda'**
  String get descDestro;

  /// No description provided for @telefoneClienteAvulsoObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Telefone do cliente avulso obrigatório'**
  String get telefoneClienteAvulsoObrigatorio;

  /// No description provided for @terminalPrincipal.
  ///
  /// In pt, this message translates to:
  /// **'Terminal Principal'**
  String get terminalPrincipal;

  /// No description provided for @contagemPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Contagem de pedidos'**
  String get contagemPedidos;

  /// No description provided for @descContagemPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Numero base para contagem de pedidos'**
  String get descContagemPedidos;

  /// No description provided for @conflitoHorarioDiaSemana.
  ///
  /// In pt, this message translates to:
  /// **'Houve um conflito de horário na {weekDay}\nDelete o horário conflitante e tente novamente'**
  String conflitoHorarioDiaSemana(Object weekDay);

  /// No description provided for @iniciandoDownload.
  ///
  /// In pt, this message translates to:
  /// **'Iniciando download...'**
  String get iniciandoDownload;

  /// No description provided for @downloadDriverImpressoraConcluido.
  ///
  /// In pt, this message translates to:
  /// **'Download concluído, iniciando driver...'**
  String get downloadDriverImpressoraConcluido;

  /// No description provided for @idioma.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get idioma;

  /// No description provided for @copiadoParaAreaTransferencia.
  ///
  /// In pt, this message translates to:
  /// **'Copiado para area de transferência'**
  String get copiadoParaAreaTransferencia;

  /// No description provided for @editarHorarioFuncionamento.
  ///
  /// In pt, this message translates to:
  /// **'Editar horario de funcionamento'**
  String get editarHorarioFuncionamento;

  /// No description provided for @abertura.
  ///
  /// In pt, this message translates to:
  /// **'Abertura'**
  String get abertura;

  /// No description provided for @fechamento.
  ///
  /// In pt, this message translates to:
  /// **'Fechamento'**
  String get fechamento;

  /// No description provided for @horarioAberturaDeveSerMenorQueHorarioFechamento.
  ///
  /// In pt, this message translates to:
  /// **'O horário de abertura deve ser menor que o de fechamento'**
  String get horarioAberturaDeveSerMenorQueHorarioFechamento;

  /// No description provided for @horarioFechamentoDeveSerMaiorQueHorarioAbertura.
  ///
  /// In pt, this message translates to:
  /// **'O horário de fechamneto deve ser maior que o de abertura'**
  String get horarioFechamentoDeveSerMaiorQueHorarioAbertura;

  /// No description provided for @necessarioDefinirHorarios.
  ///
  /// In pt, this message translates to:
  /// **'Você precisa definir horario de abertura,horario de fechamento e dias da semana, antes de salvar.'**
  String get necessarioDefinirHorarios;

  /// No description provided for @descDefinirHorarios.
  ///
  /// In pt, this message translates to:
  /// **'Defina seus horários de funcionamento e dias da semana que se aplica a mesma regra.'**
  String get descDefinirHorarios;

  /// No description provided for @horariosFuncionamento.
  ///
  /// In pt, this message translates to:
  /// **'Horários de funcionamento'**
  String get horariosFuncionamento;

  /// No description provided for @descHorariosFuncionamento.
  ///
  /// In pt, this message translates to:
  /// **'Defina seus horários de funcionamento aqui'**
  String get descHorariosFuncionamento;

  /// No description provided for @adicionarHorario.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar horário'**
  String get adicionarHorario;

  /// No description provided for @conectarStripe.
  ///
  /// In pt, this message translates to:
  /// **'Conecte-se ao Stripe'**
  String get conectarStripe;

  /// No description provided for @descConectarStripe.
  ///
  /// In pt, this message translates to:
  /// **'Para receber pagamentos online com cartão de crédito e débito.'**
  String get descConectarStripe;

  /// No description provided for @quantidade.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade'**
  String get quantidade;

  /// No description provided for @ativa.
  ///
  /// In pt, this message translates to:
  /// **'Ativa'**
  String get ativa;

  /// No description provided for @canhotoEntregador.
  ///
  /// In pt, this message translates to:
  /// **'Canhoto entregador'**
  String get canhotoEntregador;

  /// No description provided for @beep.
  ///
  /// In pt, this message translates to:
  /// **'Beep'**
  String get beep;

  /// No description provided for @colunas.
  ///
  /// In pt, this message translates to:
  /// **'Colunas'**
  String get colunas;

  /// No description provided for @selecioneUmaImpressora.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma impressora'**
  String get selecioneUmaImpressora;

  /// No description provided for @impressora.
  ///
  /// In pt, this message translates to:
  /// **'Impressora'**
  String get impressora;

  /// No description provided for @downloadDriverImpressora.
  ///
  /// In pt, this message translates to:
  /// **'Download driver impressora'**
  String get downloadDriverImpressora;

  /// No description provided for @sincronizado.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizado'**
  String get sincronizado;

  /// No description provided for @mudarCor.
  ///
  /// In pt, this message translates to:
  /// **'Mudar cor'**
  String get mudarCor;

  /// No description provided for @distanciaMinimaEmKm.
  ///
  /// In pt, this message translates to:
  /// **'Distancia minima (km)'**
  String get distanciaMinimaEmKm;

  /// No description provided for @precoMinimo.
  ///
  /// In pt, this message translates to:
  /// **'Preco minimo'**
  String get precoMinimo;

  /// No description provided for @precoPorKmRodado.
  ///
  /// In pt, this message translates to:
  /// **'Preco por km rodado'**
  String get precoPorKmRodado;

  /// No description provided for @exemploDistanciaMinima.
  ///
  /// In pt, this message translates to:
  /// **'Exemplo: Grátis até (km)'**
  String get exemploDistanciaMinima;

  /// No description provided for @adicionarArea.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar area'**
  String get adicionarArea;

  /// No description provided for @descAreasEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Defina suas áreas de entrega por bairro desenhando no mapa ou por km rodado.'**
  String get descAreasEntrega;

  /// No description provided for @solicitarParceria.
  ///
  /// In pt, this message translates to:
  /// **'Solicitar parceria'**
  String get solicitarParceria;

  /// No description provided for @telefoneEntregador.
  ///
  /// In pt, this message translates to:
  /// **'Telefone do entregador'**
  String get telefoneEntregador;

  /// No description provided for @confirmar.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirmar;

  /// No description provided for @pendente.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pendente;

  /// No description provided for @parceiro.
  ///
  /// In pt, this message translates to:
  /// **'Parceiro'**
  String get parceiro;

  /// No description provided for @infoFecharSistemaEmMinutos.
  ///
  /// In pt, this message translates to:
  /// **'O Sistema será encerrado automaticamente em {minutes} minutos'**
  String infoFecharSistemaEmMinutos(Object minutes);

  /// No description provided for @fechado.
  ///
  /// In pt, this message translates to:
  /// **'Fechado'**
  String get fechado;

  /// No description provided for @aberto.
  ///
  /// In pt, this message translates to:
  /// **'Aberto'**
  String get aberto;

  /// No description provided for @descDialogLogout.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja sair?'**
  String get descDialogLogout;

  /// No description provided for @descDialogEncerrarSistema.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja encerrar o sistema?'**
  String get descDialogEncerrarSistema;

  /// No description provided for @descDialogBackupCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Deseja fazer backup dos seus clientes?'**
  String get descDialogBackupCustomer;

  /// No description provided for @backupRealizado.
  ///
  /// In pt, this message translates to:
  /// **'Backup realizado com sucesso.'**
  String get backupRealizado;

  /// No description provided for @selecioneUmaImagem.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma imagem'**
  String get selecioneUmaImagem;

  /// No description provided for @pedidoCancelado.
  ///
  /// In pt, this message translates to:
  /// **'Pedido cancelado'**
  String get pedidoCancelado;

  /// No description provided for @mensagemAbrirEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Já está na hora de abrir o estabelecimento'**
  String get mensagemAbrirEstabelecimento;

  /// No description provided for @mensagemFecharEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Já está na hora de fechar o estabelecimento'**
  String get mensagemFecharEstabelecimento;

  /// No description provided for @infoPedidoForaPeriodoAgendamento.
  ///
  /// In pt, this message translates to:
  /// **'Pedido fora do periodo de agendamento, tente novamente mais próximo do horário.'**
  String get infoPedidoForaPeriodoAgendamento;

  /// No description provided for @selecionarEntregador.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar entregador'**
  String get selecionarEntregador;

  /// No description provided for @carrinho.
  ///
  /// In pt, this message translates to:
  /// **'Carrinho'**
  String get carrinho;

  /// No description provided for @cancelarPedido.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar pedido'**
  String get cancelarPedido;

  /// No description provided for @imprimir.
  ///
  /// In pt, this message translates to:
  /// **'Imprimir'**
  String get imprimir;

  /// No description provided for @descrevaMotivoCancelamento.
  ///
  /// In pt, this message translates to:
  /// **'Descreva o motivo do cancelamento'**
  String get descrevaMotivoCancelamento;

  /// No description provided for @acabouProdutoX.
  ///
  /// In pt, this message translates to:
  /// **'Acabou o produto {product}'**
  String acabouProdutoX(Object product);

  /// No description provided for @voceNaoPossuiEntregadores.
  ///
  /// In pt, this message translates to:
  /// **'Você não possui entregadores disponíveis'**
  String get voceNaoPossuiEntregadores;

  /// No description provided for @mesas.
  ///
  /// In pt, this message translates to:
  /// **'Mesas'**
  String get mesas;

  /// No description provided for @comandas.
  ///
  /// In pt, this message translates to:
  /// **'Comandas'**
  String get comandas;

  /// No description provided for @venda.
  ///
  /// In pt, this message translates to:
  /// **'Venda'**
  String get venda;

  /// No description provided for @descEmptyStatePedido.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pedido por aqui.'**
  String get descEmptyStatePedido;

  /// No description provided for @tempoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de entrega'**
  String get tempoEntrega;

  /// No description provided for @tempoRetirada.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de retirada'**
  String get tempoRetirada;

  /// No description provided for @aceitarPedidosAutomaticamente.
  ///
  /// In pt, this message translates to:
  /// **'Aceitar pedidos automaticamente'**
  String get aceitarPedidosAutomaticamente;

  /// No description provided for @buscarPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Buscar pedidos'**
  String get buscarPedidos;

  /// No description provided for @pendentes.
  ///
  /// In pt, this message translates to:
  /// **'Pendentes 👋'**
  String get pendentes;

  /// No description provided for @emProducao.
  ///
  /// In pt, this message translates to:
  /// **'Em produção 🔥'**
  String get emProducao;

  /// No description provided for @emRota_aguardandoRetirada.
  ///
  /// In pt, this message translates to:
  /// **'Em rota 🛵/ aguardando retirada 📦'**
  String get emRota_aguardandoRetirada;

  /// No description provided for @concluidos.
  ///
  /// In pt, this message translates to:
  /// **'Concluídos ✅'**
  String get concluidos;

  /// No description provided for @cancelados.
  ///
  /// In pt, this message translates to:
  /// **'Cancelados ❌'**
  String get cancelados;

  /// No description provided for @perdidos.
  ///
  /// In pt, this message translates to:
  /// **'Perdidos 🚫'**
  String get perdidos;

  /// No description provided for @cep.
  ///
  /// In pt, this message translates to:
  /// **'CEP'**
  String get cep;

  /// No description provided for @sincronizarContatos.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizar contatos'**
  String get sincronizarContatos;

  /// No description provided for @fazerBackup.
  ///
  /// In pt, this message translates to:
  /// **'Fazer backup'**
  String get fazerBackup;

  /// No description provided for @importarContatos.
  ///
  /// In pt, this message translates to:
  /// **'Importar contatos'**
  String get importarContatos;

  /// No description provided for @contatosImportados.
  ///
  /// In pt, this message translates to:
  /// **'Contatos importados'**
  String get contatosImportados;

  /// No description provided for @descEmptyStateEnderecos.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum endereço cadastrado.'**
  String get descEmptyStateEnderecos;

  /// No description provided for @retirada_consumo.
  ///
  /// In pt, this message translates to:
  /// **'Retirada / Consumo'**
  String get retirada_consumo;

  /// No description provided for @infoSelecioneOuAdicioneEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Selecione ou adicione um endereço para continuar'**
  String get infoSelecioneOuAdicioneEndereco;

  /// No description provided for @item.
  ///
  /// In pt, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @itens.
  ///
  /// In pt, this message translates to:
  /// **'Itens'**
  String get itens;

  /// No description provided for @taxaServico.
  ///
  /// In pt, this message translates to:
  /// **'Taxa de serviço'**
  String get taxaServico;

  /// No description provided for @trocoPara.
  ///
  /// In pt, this message translates to:
  /// **'Troco para'**
  String get trocoPara;

  /// No description provided for @pagamentoRealizado.
  ///
  /// In pt, this message translates to:
  /// **'Pagamento realizado'**
  String get pagamentoRealizado;

  /// No description provided for @pagamentos.
  ///
  /// In pt, this message translates to:
  /// **'Pagamentos'**
  String get pagamentos;

  /// No description provided for @voltar.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get voltar;

  /// No description provided for @campoObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório.'**
  String get campoObrigatorio;

  /// No description provided for @valorPagamentoMaiorQueConta.
  ///
  /// In pt, this message translates to:
  /// **'Valor do pagamento maior que a conta.'**
  String get valorPagamentoMaiorQueConta;

  /// No description provided for @relatorioPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Relatório de pedidos'**
  String get relatorioPedidos;

  /// No description provided for @juntarMesas.
  ///
  /// In pt, this message translates to:
  /// **'Juntar mesas'**
  String get juntarMesas;

  /// No description provided for @separarMesas.
  ///
  /// In pt, this message translates to:
  /// **'Separar mesas'**
  String get separarMesas;

  /// No description provided for @transferirMesa.
  ///
  /// In pt, this message translates to:
  /// **'Transferir mesa'**
  String get transferirMesa;

  /// No description provided for @limparMesa.
  ///
  /// In pt, this message translates to:
  /// **'Limpar mesa'**
  String get limparMesa;

  /// No description provided for @adicionarItens.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar itens'**
  String get adicionarItens;

  /// No description provided for @fecharConta.
  ///
  /// In pt, this message translates to:
  /// **'Fechar conta'**
  String get fecharConta;

  /// No description provided for @nomeAmbiente.
  ///
  /// In pt, this message translates to:
  /// **'Nome do ambiente'**
  String get nomeAmbiente;

  /// No description provided for @adicionarAmbiente.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar ambiente'**
  String get adicionarAmbiente;

  /// No description provided for @numeroMesa.
  ///
  /// In pt, this message translates to:
  /// **'Número da mesa'**
  String get numeroMesa;

  /// No description provided for @desejaAbrirMesaParaVenda.
  ///
  /// In pt, this message translates to:
  /// **'Deseja abrir a mesa para venda?'**
  String get desejaAbrirMesaParaVenda;

  /// No description provided for @descartar.
  ///
  /// In pt, this message translates to:
  /// **'Descartar'**
  String get descartar;

  /// No description provided for @abrirMesa.
  ///
  /// In pt, this message translates to:
  /// **'Abrir mesa'**
  String get abrirMesa;

  /// No description provided for @transferir.
  ///
  /// In pt, this message translates to:
  /// **'Transferir'**
  String get transferir;

  /// No description provided for @separar.
  ///
  /// In pt, this message translates to:
  /// **'Separar'**
  String get separar;

  /// No description provided for @adicionarComanda.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar comanda'**
  String get adicionarComanda;

  /// No description provided for @removerComanda.
  ///
  /// In pt, this message translates to:
  /// **'Remover comanda'**
  String get removerComanda;

  /// No description provided for @numeroObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Número obrigatório'**
  String get numeroObrigatorio;

  /// No description provided for @numeroInvalido.
  ///
  /// In pt, this message translates to:
  /// **'Número inválido'**
  String get numeroInvalido;

  /// No description provided for @jaExiste.
  ///
  /// In pt, this message translates to:
  /// **'Já existe'**
  String get jaExiste;

  /// No description provided for @capacidade.
  ///
  /// In pt, this message translates to:
  /// **'Capacidade'**
  String get capacidade;

  /// No description provided for @ambiente.
  ///
  /// In pt, this message translates to:
  /// **'Ambiente'**
  String get ambiente;

  /// No description provided for @excluirMesa.
  ///
  /// In pt, this message translates to:
  /// **'Excluir mesa'**
  String get excluirMesa;

  /// No description provided for @area.
  ///
  /// In pt, this message translates to:
  /// **'Área'**
  String get area;

  /// No description provided for @selecioneUmaMesa.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma mesa'**
  String get selecioneUmaMesa;

  /// No description provided for @mesaXDisponivel.
  ///
  /// In pt, this message translates to:
  /// **'Mesa {table} disponível'**
  String mesaXDisponivel(Object table);

  /// No description provided for @agrupado.
  ///
  /// In pt, this message translates to:
  /// **'Agrupado'**
  String get agrupado;

  /// No description provided for @conexaoReestabelecida.
  ///
  /// In pt, this message translates to:
  /// **'Conexão reestabelecida'**
  String get conexaoReestabelecida;

  /// No description provided for @semConexaoInternet.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet.'**
  String get semConexaoInternet;

  /// No description provided for @concluido.
  ///
  /// In pt, this message translates to:
  /// **'Concluído'**
  String get concluido;

  /// No description provided for @novaVersaoDisponivel.
  ///
  /// In pt, this message translates to:
  /// **'Nova versão disponível'**
  String get novaVersaoDisponivel;

  /// No description provided for @atualizar.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get atualizar;

  /// No description provided for @iniciandoInstalador.
  ///
  /// In pt, this message translates to:
  /// **'Iniciando instalador...'**
  String get iniciandoInstalador;

  /// No description provided for @sair.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get sair;

  /// No description provided for @tutorial.
  ///
  /// In pt, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @bemVindo.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo!'**
  String get bemVindo;

  /// No description provided for @ativo.
  ///
  /// In pt, this message translates to:
  /// **'Ativo'**
  String get ativo;

  /// No description provided for @inativo.
  ///
  /// In pt, this message translates to:
  /// **'Inativo'**
  String get inativo;

  /// No description provided for @erroIniciarWpp.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao iniciar o whatsapp, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.'**
  String get erroIniciarWpp;

  /// No description provided for @erroEnviarMensagem.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao enviar mensagem, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.'**
  String get erroEnviarMensagem;

  /// No description provided for @bomDia.
  ///
  /// In pt, this message translates to:
  /// **'Bom dia'**
  String get bomDia;

  /// No description provided for @boaTarde.
  ///
  /// In pt, this message translates to:
  /// **'Boa tarde'**
  String get boaTarde;

  /// No description provided for @boaNoite.
  ///
  /// In pt, this message translates to:
  /// **'Boa noite'**
  String get boaNoite;

  /// No description provided for @raioEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Raio de entrega'**
  String get raioEntrega;

  /// No description provided for @infoselecioneAreaEntregaAntesAddPonto.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma área de entrega antes de adicionar um ponto'**
  String get infoselecioneAreaEntregaAntesAddPonto;

  /// No description provided for @layoutImpresssao.
  ///
  /// In pt, this message translates to:
  /// **'Layout de impressão'**
  String get layoutImpresssao;

  /// No description provided for @salvoComSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Salvo com sucesso!'**
  String get salvoComSucesso;

  /// No description provided for @trafegoPago.
  ///
  /// In pt, this message translates to:
  /// **'Anúncios pagos'**
  String get trafegoPago;

  /// No description provided for @trafegoPagoHandleErrorCode.
  ///
  /// In pt, this message translates to:
  /// **'Por favor adicione somente o codigo'**
  String get trafegoPagoHandleErrorCode;

  /// No description provided for @preferenciasDoUsuario.
  ///
  /// In pt, this message translates to:
  /// **'Preferências do usuário'**
  String get preferenciasDoUsuario;

  /// No description provided for @preferenciasDoEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Preferências do estabelecimento'**
  String get preferenciasDoEstabelecimento;

  /// No description provided for @resetContagemPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Reset contagem de pedidos'**
  String get resetContagemPedidos;

  /// No description provided for @periodo.
  ///
  /// In pt, this message translates to:
  /// **'Período'**
  String get periodo;

  /// No description provided for @preferencias.
  ///
  /// In pt, this message translates to:
  /// **'Preferências'**
  String get preferencias;

  /// No description provided for @nunca.
  ///
  /// In pt, this message translates to:
  /// **'Nunca'**
  String get nunca;

  /// No description provided for @diariamente.
  ///
  /// In pt, this message translates to:
  /// **'Diariamente'**
  String get diariamente;

  /// No description provided for @semanalmente.
  ///
  /// In pt, this message translates to:
  /// **'Semanalmente'**
  String get semanalmente;

  /// No description provided for @mensalmente.
  ///
  /// In pt, this message translates to:
  /// **'Mensalmente'**
  String get mensalmente;

  /// No description provided for @anualmente.
  ///
  /// In pt, this message translates to:
  /// **'Anualmente'**
  String get anualmente;

  /// No description provided for @espelharHorizontalmente.
  ///
  /// In pt, this message translates to:
  /// **'Espelhar horizontalmente'**
  String get espelharHorizontalmente;

  /// No description provided for @erroAoVerificarPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao verificar o pagamento. Tente novamente.'**
  String get erroAoVerificarPagamento;

  /// No description provided for @erroAoGerarPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao gerar o pagamento. Tente novamente.'**
  String get erroAoGerarPagamento;

  /// No description provided for @chatbotStatesDisableTitle.
  ///
  /// In pt, this message translates to:
  /// **'Habilite a integração com o WhatsApp para começar a usar o Chatbot'**
  String get chatbotStatesDisableTitle;

  /// No description provided for @chatbotStatesDisableSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Você precisa habilitar a integração com o WhatsApp para começar a usar o Chatbot'**
  String get chatbotStatesDisableSubtitle;

  /// No description provided for @chatbotStatesDisableAction.
  ///
  /// In pt, this message translates to:
  /// **'Habilitar'**
  String get chatbotStatesDisableAction;

  /// No description provided for @chatbotStatesConnectingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Conectando'**
  String get chatbotStatesConnectingTitle;

  /// No description provided for @chatbotStatesConnectingSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Aguarde alguns instantes...'**
  String get chatbotStatesConnectingSubtitle;

  /// No description provided for @chatbotStatesConnectingAction.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get chatbotStatesConnectingAction;

  /// No description provided for @chatbotStatesConnectedTitle.
  ///
  /// In pt, this message translates to:
  /// **'Conectado'**
  String get chatbotStatesConnectedTitle;

  /// No description provided for @chatbotStatesConnectedSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Personalize suas mensagens de status a baixo.'**
  String get chatbotStatesConnectedSubtitle;

  /// No description provided for @chatbotStatesConnectedAction.
  ///
  /// In pt, this message translates to:
  /// **'Desconectar'**
  String get chatbotStatesConnectedAction;

  /// No description provided for @chatbotStatesDisconnectedTitle.
  ///
  /// In pt, this message translates to:
  /// **'Desconectado'**
  String get chatbotStatesDisconnectedTitle;

  /// No description provided for @chatbotStatesDisconnectedSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Você precisa escanear o QRCode para conectar o WhatsApp'**
  String get chatbotStatesDisconnectedSubtitle;

  /// No description provided for @chatbotStatesDisconnectedAction.
  ///
  /// In pt, this message translates to:
  /// **'Conectar'**
  String get chatbotStatesDisconnectedAction;

  /// No description provided for @atencao.
  ///
  /// In pt, this message translates to:
  /// **'Atenção'**
  String get atencao;

  /// No description provided for @descWhatsappDesconectado.
  ///
  /// In pt, this message translates to:
  /// **'Seu whatsapp está desconectado'**
  String get descWhatsappDesconectado;
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
