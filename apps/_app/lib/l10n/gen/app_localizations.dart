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

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'PaipFood'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo ao PaipFood'**
  String get welcome;

  /// No description provided for @currency.
  ///
  /// In pt, this message translates to:
  /// **'£'**
  String get currency;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @senha.
  ///
  /// In pt, this message translates to:
  /// **'Palavra-passe'**
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
  /// **'Registar-se'**
  String get registrese;

  /// No description provided for @esqueciSenha.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci a minha palavra-passe.'**
  String get esqueciSenha;

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
  /// **'Escolha uma cor para ser a cor principal da sua app.'**
  String get descCorPrimaria;

  /// No description provided for @imagens.
  ///
  /// In pt, this message translates to:
  /// **'Imagens'**
  String get imagens;

  /// No description provided for @descImagens.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma imagem de capa e um logotipo para a sua loja.'**
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
  /// **'Endereço inválido'**
  String get enderecoInvalido;

  /// No description provided for @adicioneEnderecoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Adicione um endereço de entrega'**
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
  /// **'Pesquise o seu cliente por nome ou telefone'**
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
  /// **'Informações principais'**
  String get informacoesPrincipais;

  /// No description provided for @descInformacoesPrincipais.
  ///
  /// In pt, this message translates to:
  /// **'Defina um nome, valor mínimo de pedidos e as informações de contacto'**
  String get descInformacoesPrincipais;

  /// No description provided for @nomeLoja.
  ///
  /// In pt, this message translates to:
  /// **'Nome da loja'**
  String get nomeLoja;

  /// No description provided for @descricao.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get descricao;

  /// No description provided for @cnpj.
  ///
  /// In pt, this message translates to:
  /// **'NIF'**
  String get cnpj;

  /// No description provided for @razaoSocial.
  ///
  /// In pt, this message translates to:
  /// **'Razão social'**
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
  /// **'Copie o link da sua loja e envie para os seus clientes (Não é permitido alterar).'**
  String get descLinkLoja;

  /// No description provided for @redesSociais.
  ///
  /// In pt, this message translates to:
  /// **'Redes sociais'**
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
  /// **'Guardar'**
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
  /// **'Pré-selecionado'**
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
  /// **'Tamanho - fatias'**
  String get tamanhoLabel;

  /// No description provided for @adicionais.
  ///
  /// In pt, this message translates to:
  /// **'Adicionais'**
  String get adicionais;

  /// No description provided for @pizzaGrandeNome.
  ///
  /// In pt, this message translates to:
  /// **'Pizza grande - 8 fatias'**
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
  /// **'Café'**
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
  /// **'Comida caseira'**
  String get comidaCaseira;

  /// No description provided for @fastFood.
  ///
  /// In pt, this message translates to:
  /// **'Fast food'**
  String get fastFood;

  /// No description provided for @comidaSaudavel.
  ///
  /// In pt, this message translates to:
  /// **'Comida saudável'**
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
  /// **'Frutos do mar'**
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
  /// **'Gelataria'**
  String get sorveteria;

  /// No description provided for @padaria.
  ///
  /// In pt, this message translates to:
  /// **'Padaria'**
  String get padaria;

  /// No description provided for @sanduiches.
  ///
  /// In pt, this message translates to:
  /// **'Sandes'**
  String get sanduiches;

  /// No description provided for @sucos.
  ///
  /// In pt, this message translates to:
  /// **'Sumos & Vitaminas'**
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
  /// **'A partir de'**
  String get aPartirDe;

  /// No description provided for @deletar.
  ///
  /// In pt, this message translates to:
  /// **'Eliminar'**
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
  /// **'Mozzarella'**
  String get saborMussarela;

  /// No description provided for @descMussarela.
  ///
  /// In pt, this message translates to:
  /// **'Molho de tomate caseiro, mozzarella, catupiry, azeitonas e orégãos.'**
  String get descMussarela;

  /// No description provided for @saborCalabresa.
  ///
  /// In pt, this message translates to:
  /// **'Calabresa'**
  String get saborCalabresa;

  /// No description provided for @descCalabresa.
  ///
  /// In pt, this message translates to:
  /// **'Molho de tomate caseiro, calabresa, catupiry, cebola, azeitonas e orégãos.'**
  String get descCalabresa;

  /// No description provided for @pizzaGrandeDefault.
  ///
  /// In pt, this message translates to:
  /// **'Pizza grande - 8 fatias'**
  String get pizzaGrandeDefault;

  /// No description provided for @pizzaPequenaDefault.
  ///
  /// In pt, this message translates to:
  /// **'Pizza pequena - individual'**
  String get pizzaPequenaDefault;

  /// No description provided for @massaTradicional.
  ///
  /// In pt, this message translates to:
  /// **'Massa tradicional'**
  String get massaTradicional;

  /// No description provided for @emptySateteProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não adicionou nenhum produto.'**
  String get emptySateteProdutos;

  /// No description provided for @emptySateteCategorias.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não adicionou nenhuma categoria.'**
  String get emptySateteCategorias;

  /// No description provided for @emptySateteComplementos.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não adicionou nenhum complemento.'**
  String get emptySateteComplementos;

  /// No description provided for @emptySateteSaborPizza.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não adicionou nenhum sabor.'**
  String get emptySateteSaborPizza;

  /// No description provided for @adicionarSaborPizzaA.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar sabor a {name}'**
  String adicionarSaborPizzaA(Object name);

  /// No description provided for @emptyStateItens.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não adicionou nenhum item.'**
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
  /// **'O preço promocional deve ser menor que o preço'**
  String get precoPromocionalDeveSerMenorQuePreco;

  /// No description provided for @imagemExcluidaSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Imagem eliminada com sucesso!'**
  String get imagemExcluidaSucesso;

  /// No description provided for @deletarImagem.
  ///
  /// In pt, this message translates to:
  /// **'Eliminar imagem'**
  String get deletarImagem;

  /// No description provided for @uploadImagem.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar imagem'**
  String get uploadImagem;

  /// No description provided for @descZoomImagem.
  ///
  /// In pt, this message translates to:
  /// **'Utilize o scroll do seu rato para dar zoom +- na sua imagem'**
  String get descZoomImagem;

  /// No description provided for @imagemSalvaComSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Imagem guardada com sucesso!'**
  String get imagemSalvaComSucesso;

  /// No description provided for @vocePrecisaSelecionarUmaImagem.
  ///
  /// In pt, this message translates to:
  /// **'Precisa de selecionar uma imagem'**
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
  /// **'Editar a sua categoria.'**
  String get tituloEditarCategoria;

  /// No description provided for @tituloEditarComplemento.
  ///
  /// In pt, this message translates to:
  /// **'Editar o seu complemento.'**
  String get tituloEditarComplemento;

  /// No description provided for @tituloComplemento.
  ///
  /// In pt, this message translates to:
  /// **'Registar e definir as regras do seu complemento'**
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
  /// **'Produtos no geral, ex: lanches, doces, marmitas, etc...'**
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
  /// **'Este campo aparece para o cliente\nno cardápio'**
  String get tooltipNomeComplemento;

  /// No description provided for @tooltipIdentificador.
  ///
  /// In pt, this message translates to:
  /// **'Este campo aparece apenas para si \npara ajudar a identificar o complemento'**
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
  /// **'Quantidade mínima'**
  String get quantidadeMinima;

  /// No description provided for @hintQuantidadeMinima.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 0'**
  String get hintQuantidadeMinima;

  /// No description provided for @quantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade máxima'**
  String get quantidadeMaxima;

  /// No description provided for @hintQuantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 5'**
  String get hintQuantidadeMaxima;

  /// No description provided for @validatorQuantidadeMaxima.
  ///
  /// In pt, this message translates to:
  /// **'A quantidade máxima deve ser maior que a quantidade mínima.'**
  String get validatorQuantidadeMaxima;

  /// No description provided for @tipoDoSeletor.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de seletor'**
  String get tipoDoSeletor;

  /// No description provided for @seletorUnico.
  ///
  /// In pt, this message translates to:
  /// **'Seletor único'**
  String get seletorUnico;

  /// No description provided for @descSeletorUnico.
  ///
  /// In pt, this message translates to:
  /// **'Permite selecionar apenas uma vez o mesmo item.'**
  String get descSeletorUnico;

  /// No description provided for @seletorMultiplo.
  ///
  /// In pt, this message translates to:
  /// **'Seletor múltiplo'**
  String get seletorMultiplo;

  /// No description provided for @descSeletorMultiplo.
  ///
  /// In pt, this message translates to:
  /// **'Permite selecionar várias vezes o mesmo item.'**
  String get descSeletorMultiplo;

  /// No description provided for @obrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Obrigatório'**
  String get obrigatorio;

  /// No description provided for @feedbackSucessImagemDeletada.
  ///
  /// In pt, this message translates to:
  /// **'Imagem eliminada com sucesso!'**
  String get feedbackSucessImagemDeletada;

  /// No description provided for @bordasEMassas.
  ///
  /// In pt, this message translates to:
  /// **'Bordas & Massas'**
  String get bordasEMassas;

  /// No description provided for @tituloBordasEMassas.
  ///
  /// In pt, this message translates to:
  /// **'Defina as opções de bordas e massa das suas pizzas'**
  String get tituloBordasEMassas;

  /// No description provided for @descSelecionarImage.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma nova imagem para o seu item'**
  String get descSelecionarImage;

  /// No description provided for @tituloConfirmacaoExclusao.
  ///
  /// In pt, this message translates to:
  /// **'Tem a certeza que deseja eliminar?'**
  String get tituloConfirmacaoExclusao;

  /// No description provided for @descConfirmacaoExclusao.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita. Digite {sim} para confirmar.'**
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
  /// **'Escolha pelo menos {qty} opção'**
  String descComplementObrigatio(Object qty);

  /// No description provided for @descComplementObrigatioPlural.
  ///
  /// In pt, this message translates to:
  /// **'Escolha pelo menos {qty} opções'**
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
  /// **'Escreva as suas observações aqui...'**
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

  /// No description provided for @subtota.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal'**
  String get subtota;

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
  /// **'Crédito'**
  String get credito;

  /// No description provided for @debito.
  ///
  /// In pt, this message translates to:
  /// **'Débito'**
  String get debito;

  /// No description provided for @voucher.
  ///
  /// In pt, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @foodTicket.
  ///
  /// In pt, this message translates to:
  /// **'Vale Refeição'**
  String get foodTicket;

  /// No description provided for @mealTicket.
  ///
  /// In pt, this message translates to:
  /// **'Vale Alimentação'**
  String get mealTicket;

  /// No description provided for @cash.
  ///
  /// In pt, this message translates to:
  /// **'Dinheiro'**
  String get cash;

  /// No description provided for @entrega.
  ///
  /// In pt, this message translates to:
  /// **'Entrega'**
  String get entrega;

  /// No description provided for @retirada.
  ///
  /// In pt, this message translates to:
  /// **'Recolha'**
  String get retirada;

  /// No description provided for @consumo.
  ///
  /// In pt, this message translates to:
  /// **'Consumo'**
  String get consumo;

  /// No description provided for @kiosk.
  ///
  /// In pt, this message translates to:
  /// **'Quiosque'**
  String get kiosk;

  /// No description provided for @mesa.
  ///
  /// In pt, this message translates to:
  /// **'Mesa'**
  String get mesa;

  /// No description provided for @trocop.
  ///
  /// In pt, this message translates to:
  /// **'Troco para'**
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
  /// **'Aceite'**
  String get accepted;

  /// No description provided for @inDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Em entrega'**
  String get inDelivery;

  /// No description provided for @awaitingPickup.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando recolha'**
  String get awaitingPickup;

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
  /// **'Segunda-feira'**
  String get segunda;

  /// No description provided for @terca.
  ///
  /// In pt, this message translates to:
  /// **'Terça-feira'**
  String get terca;

  /// No description provided for @quarta.
  ///
  /// In pt, this message translates to:
  /// **'Quarta-feira'**
  String get quarta;

  /// No description provided for @quinta.
  ///
  /// In pt, this message translates to:
  /// **'Quinta-feira'**
  String get quinta;

  /// No description provided for @sexta.
  ///
  /// In pt, this message translates to:
  /// **'Sexta-feira'**
  String get sexta;

  /// No description provided for @sabado.
  ///
  /// In pt, this message translates to:
  /// **'Sábado'**
  String get sabado;

  /// No description provided for @domingo.
  ///
  /// In pt, this message translates to:
  /// **'Domingo'**
  String get domingo;

  /// No description provided for @pix.
  ///
  /// In pt, this message translates to:
  /// **'Pix'**
  String get pix;

  /// No description provided for @tempoAbreviado.
  ///
  /// In pt, this message translates to:
  /// **'{from} a {to} min'**
  String tempoAbreviado(Object from, Object to);

  /// No description provided for @pedidoMinimoAbreviado.
  ///
  /// In pt, this message translates to:
  /// **'Pedido min {value}'**
  String pedidoMinimoAbreviado(Object value);

  /// No description provided for @ate.
  ///
  /// In pt, this message translates to:
  /// **'Até as {time}'**
  String ate(Object time);

  /// No description provided for @copiarCodigo.
  ///
  /// In pt, this message translates to:
  /// **'Copiar código'**
  String get copiarCodigo;

  /// No description provided for @codigoCopiadoSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Código copiado com sucesso!'**
  String get codigoCopiadoSucesso;

  /// No description provided for @gerandoQrCode.
  ///
  /// In pt, this message translates to:
  /// **'A gerar QR Code'**
  String get gerandoQrCode;

  /// No description provided for @aguardandoPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando pagamento'**
  String get aguardandoPagamento;

  /// No description provided for @pagamentoRealizado.
  ///
  /// In pt, this message translates to:
  /// **'Pagamento realizado'**
  String get pagamentoRealizado;

  /// No description provided for @qtyMaisLabelBotaoVerCarrinho.
  ///
  /// In pt, this message translates to:
  /// **'{qty} - Itens | Ver carrinho'**
  String qtyMaisLabelBotaoVerCarrinho(Object qty);

  /// No description provided for @estabelecimentoNaoEstaAbertoNoMomento.
  ///
  /// In pt, this message translates to:
  /// **'O estabelecimento não está aberto no momento.'**
  String get estabelecimentoNaoEstaAbertoNoMomento;

  /// No description provided for @resumoPedido.
  ///
  /// In pt, this message translates to:
  /// **'Resumo do pedido'**
  String get resumoPedido;

  /// No description provided for @itensPedido.
  ///
  /// In pt, this message translates to:
  /// **'Itens do pedido'**
  String get itensPedido;

  /// No description provided for @adicionarMaisItens.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar mais itens'**
  String get adicionarMaisItens;

  /// No description provided for @dadosContato.
  ///
  /// In pt, this message translates to:
  /// **'Dados de contacto'**
  String get dadosContato;

  /// No description provided for @gratuita.
  ///
  /// In pt, this message translates to:
  /// **'Gratuita'**
  String get gratuita;

  /// No description provided for @cliqueParaAdicionarEnderecoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Clique para adicionar um endereço de entrega'**
  String get cliqueParaAdicionarEnderecoEntrega;

  /// No description provided for @naoEPossivelRetirar.
  ///
  /// In pt, this message translates to:
  /// **'Não é possível recolher'**
  String get naoEPossivelRetirar;

  /// No description provided for @comoDesejaReceberSeuPedido.
  ///
  /// In pt, this message translates to:
  /// **'Como deseja receber o seu pedido?'**
  String get comoDesejaReceberSeuPedido;

  /// No description provided for @desejaRemoverEsteItemDoCarrinho.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover este item do carrinho?'**
  String get desejaRemoverEsteItemDoCarrinho;

  /// No description provided for @removerItemDoCarrinho.
  ///
  /// In pt, this message translates to:
  /// **'Remover item do carrinho'**
  String get removerItemDoCarrinho;

  /// No description provided for @escolherFormaPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Escolher forma de pagamento'**
  String get escolherFormaPagamento;

  /// No description provided for @selecioneUmaOpcaoParaReceberSeuPedido.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma opção para receber o seu pedido, \'Entrega ou Recolha\'.'**
  String get selecioneUmaOpcaoParaReceberSeuPedido;

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

  /// No description provided for @localizacaoDoEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Localização do estabelecimento'**
  String get localizacaoDoEstabelecimento;

  /// No description provided for @confirmeSeuEnderecoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Confirme o seu endereço de entrega.'**
  String get confirmeSeuEnderecoEntrega;

  /// No description provided for @confirmarEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar endereço'**
  String get confirmarEndereco;

  /// No description provided for @vocePrecisaDeTroco.
  ///
  /// In pt, this message translates to:
  /// **'Precisa de troco?'**
  String get vocePrecisaDeTroco;

  /// No description provided for @trocoP.
  ///
  /// In pt, this message translates to:
  /// **'Troco para'**
  String get trocoP;

  /// No description provided for @confirmar.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirmar;

  /// No description provided for @comoDesejaPagar.
  ///
  /// In pt, this message translates to:
  /// **'Como deseja pagar?'**
  String get comoDesejaPagar;

  /// No description provided for @oEstabelecimentoSeEncontraFechadoNoMomento.
  ///
  /// In pt, this message translates to:
  /// **'O estabelecimento encontra-se fechado no momento, tente mais tarde.'**
  String get oEstabelecimentoSeEncontraFechadoNoMomento;

  /// No description provided for @fazerUmNovoPedido.
  ///
  /// In pt, this message translates to:
  /// **'Fazer um novo pedido'**
  String get fazerUmNovoPedido;

  /// No description provided for @copiarChave.
  ///
  /// In pt, this message translates to:
  /// **'Copiar chave'**
  String get copiarChave;

  /// No description provided for @chavePixNaoCadastradaEntreContatoEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Chave PIX não cadastrada. Entre em contacto com o estabelecimento.'**
  String get chavePixNaoCadastradaEntreContatoEstabelecimento;

  /// No description provided for @chaveCopiaComSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Chave copiada com sucesso!'**
  String get chaveCopiaComSucesso;

  /// No description provided for @para.
  ///
  /// In pt, this message translates to:
  /// **'Para'**
  String get para;

  /// No description provided for @data.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @enderecoDeEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Endereço de entrega'**
  String get enderecoDeEntrega;

  /// No description provided for @codigo.
  ///
  /// In pt, this message translates to:
  /// **'Código'**
  String get codigo;

  /// No description provided for @ou.
  ///
  /// In pt, this message translates to:
  /// **'ou'**
  String get ou;

  /// No description provided for @desejaIrAte.
  ///
  /// In pt, this message translates to:
  /// **'Deseja ir até {name}'**
  String desejaIrAte(Object name);

  /// No description provided for @tracarRotaNoMapa.
  ///
  /// In pt, this message translates to:
  /// **'Traçar rota no mapa'**
  String get tracarRotaNoMapa;

  /// No description provided for @enderecoParaFazerRetirada.
  ///
  /// In pt, this message translates to:
  /// **'Endereço para fazer a recolha'**
  String get enderecoParaFazerRetirada;

  /// No description provided for @pedidoCanceladoPeloEstabelecimento.
  ///
  /// In pt, this message translates to:
  /// **'Pedido cancelado pelo estabelecimento.'**
  String get pedidoCanceladoPeloEstabelecimento;

  /// No description provided for @tempoExpirado.
  ///
  /// In pt, this message translates to:
  /// **'Tempo expirado'**
  String get tempoExpirado;

  /// No description provided for @naoSePreocupeExtornoSeuPagamento.
  ///
  /// In pt, this message translates to:
  /// **'Não se preocupe, já reembolsamos o seu pagamento.'**
  String get naoSePreocupeExtornoSeuPagamento;

  /// No description provided for @aguarandoAprovacaoRestaurante.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando aprovação do restaurante'**
  String get aguarandoAprovacaoRestaurante;

  /// No description provided for @preparando.
  ///
  /// In pt, this message translates to:
  /// **'A preparar'**
  String get preparando;

  /// No description provided for @saiuParaEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Saiu para entrega'**
  String get saiuParaEntrega;

  /// No description provided for @entregue.
  ///
  /// In pt, this message translates to:
  /// **'Entregue'**
  String get entregue;

  /// No description provided for @aguardandoRetirada.
  ///
  /// In pt, this message translates to:
  /// **'Pronto, aguardando recolha.'**
  String get aguardandoRetirada;

  /// No description provided for @estabelecimentoTemEsteTempoParaAceitarSeuPedido.
  ///
  /// In pt, this message translates to:
  /// **'{name} tem este tempo para aceitar o seu pedido.'**
  String estabelecimentoTemEsteTempoParaAceitarSeuPedido(Object name);

  /// No description provided for @entreContatoEstabelecimentoReembolso.
  ///
  /// In pt, this message translates to:
  /// **'Entre em contacto com o estabelecimento para obter o seu reembolso {phone}'**
  String entreContatoEstabelecimentoReembolso(Object phone);

  /// No description provided for @deUmApelidoParaSeuEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Dê um apelido para o seu endereço'**
  String get deUmApelidoParaSeuEndereco;

  /// No description provided for @apelidoEnderecoHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Casa, Trabalho, Casa da sogra...'**
  String get apelidoEnderecoHint;

  /// No description provided for @qualESeuNome.
  ///
  /// In pt, this message translates to:
  /// **'Qual é o seu nome?'**
  String get qualESeuNome;

  /// No description provided for @digiteSeuNome.
  ///
  /// In pt, this message translates to:
  /// **'Digite o seu nome'**
  String get digiteSeuNome;

  /// No description provided for @codigoInvalido.
  ///
  /// In pt, this message translates to:
  /// **'Código inválido'**
  String get codigoInvalido;

  /// No description provided for @numeroAtualizadoSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Número atualizado com sucesso!'**
  String get numeroAtualizadoSucesso;

  /// No description provided for @insiraTelefoneContato.
  ///
  /// In pt, this message translates to:
  /// **'Insira o seu telefone de contacto.'**
  String get insiraTelefoneContato;

  /// No description provided for @codigoEnviadoWpp.
  ///
  /// In pt, this message translates to:
  /// **'Código enviado para o seu WhatsApp.'**
  String get codigoEnviadoWpp;

  /// No description provided for @verifiqueSeuWhatsapp.
  ///
  /// In pt, this message translates to:
  /// **'Verifique o seu WhatsApp.'**
  String get verifiqueSeuWhatsapp;

  /// No description provided for @codigoEnviadoSms.
  ///
  /// In pt, this message translates to:
  /// **'Código enviado via SMS.'**
  String get codigoEnviadoSms;

  /// No description provided for @verifiqueSuasMensagens.
  ///
  /// In pt, this message translates to:
  /// **'Verifique as suas mensagens.'**
  String get verifiqueSuasMensagens;

  /// No description provided for @digiteSeuEnderecoEntrega.
  ///
  /// In pt, this message translates to:
  /// **'Digite o seu endereço de entrega.'**
  String get digiteSeuEnderecoEntrega;

  /// No description provided for @naoAbrevieSeuEnderecoParaEvitarErros.
  ///
  /// In pt, this message translates to:
  /// **'Não abrevie o seu endereço para evitar erros.'**
  String get naoAbrevieSeuEnderecoParaEvitarErros;

  /// No description provided for @enderecoInvalidoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Verifique se não esqueceu nenhum campo, ou se o endereço foi digitado corretamente.'**
  String get enderecoInvalidoDesc;

  /// No description provided for @cep.
  ///
  /// In pt, this message translates to:
  /// **'Código postal'**
  String get cep;

  /// No description provided for @erroBuscaCep.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao buscar código postal'**
  String get erroBuscaCep;

  /// No description provided for @pago.
  ///
  /// In pt, this message translates to:
  /// **'Pago'**
  String get pago;

  /// No description provided for @meusEnderecos.
  ///
  /// In pt, this message translates to:
  /// **'Meus endereços'**
  String get meusEnderecos;

  /// No description provided for @temCerteza.
  ///
  /// In pt, this message translates to:
  /// **'Tem a certeza'**
  String get temCerteza;

  /// No description provided for @excluirEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Excluir endereço'**
  String get excluirEndereco;

  /// No description provided for @queDesejaExcluirEsteEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Que deseja excluir este endereço?'**
  String get queDesejaExcluirEsteEndereco;

  /// No description provided for @hintBuscarEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Endereço: Praça do Comércio, Lisboa...'**
  String get hintBuscarEndereco;

  /// No description provided for @hintComplementoEndereco.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Apartamento 1'**
  String get hintComplementoEndereco;

  /// No description provided for @credit.
  ///
  /// In pt, this message translates to:
  /// **'Crédito'**
  String get credit;

  /// No description provided for @padrao.
  ///
  /// In pt, this message translates to:
  /// **'Padrão'**
  String get padrao;

  /// No description provided for @agendar.
  ///
  /// In pt, this message translates to:
  /// **'Agendar'**
  String get agendar;

  /// No description provided for @selecionarHorario.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar horário'**
  String get selecionarHorario;

  /// No description provided for @selecioneUmHorario.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um horário'**
  String get selecioneUmHorario;

  /// No description provided for @selecionarData.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar data'**
  String get selecionarData;

  /// No description provided for @tempoEstimado.
  ///
  /// In pt, this message translates to:
  /// **'Tempo estimado'**
  String get tempoEstimado;

  /// No description provided for @agendarPedido.
  ///
  /// In pt, this message translates to:
  /// **'Agendar pedido'**
  String get agendarPedido;

  /// No description provided for @confimarAgendamento.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar agendamento'**
  String get confimarAgendamento;

  /// No description provided for @hoje.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get hoje;

  /// No description provided for @amanha.
  ///
  /// In pt, this message translates to:
  /// **'Amanhã'**
  String get amanha;

  /// No description provided for @agendado.
  ///
  /// In pt, this message translates to:
  /// **'Agendado'**
  String get agendado;

  /// No description provided for @pedidoMinimoNaoAtingido.
  ///
  /// In pt, this message translates to:
  /// **'Pedido mínimo de {value} não atingido'**
  String pedidoMinimoNaoAtingido(Object value);

  /// No description provided for @erroOrderTypeVazio.
  ///
  /// In pt, this message translates to:
  /// **'Escolha entre entrega ou retirada para continuar.'**
  String get erroOrderTypeVazio;

  /// No description provided for @inserirEnderecoManualmente.
  ///
  /// In pt, this message translates to:
  /// **'Inserir endereço manualmente'**
  String get inserirEnderecoManualmente;

  /// No description provided for @pedidoCancelado.
  ///
  /// In pt, this message translates to:
  /// **'Pedido cancelado'**
  String get pedidoCancelado;

  /// No description provided for @pagar.
  ///
  /// In pt, this message translates to:
  /// **'Pagar'**
  String get pagar;

  /// No description provided for @distanciaMaximaExcedida.
  ///
  /// In pt, this message translates to:
  /// **'Distância máxima excedida, tente outro endereço.'**
  String get distanciaMaximaExcedida;

  /// No description provided for @infelizmenteOEstabelecimentoEstaFechado.
  ///
  /// In pt, this message translates to:
  /// **'Infelizmente o estabelecimento está fechado no momento.'**
  String get infelizmenteOEstabelecimentoEstaFechado;

  /// No description provided for @digiteUmEnderecoParaBuscar.
  ///
  /// In pt, this message translates to:
  /// **'Digite um endereço para buscar'**
  String get digiteUmEnderecoParaBuscar;
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
