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
/// import 'l10n/app_localizations.dart';
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
  /// In en, this message translates to:
  /// **'PaipFood'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to PaipFood'**
  String get welcome;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'£'**
  String get currency;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @senha.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get senha;

  /// No description provided for @entrar.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get entrar;

  /// No description provided for @naoTemConta.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get naoTemConta;

  /// No description provided for @registrese.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registrese;

  /// No description provided for @esqueciSenha.
  ///
  /// In en, this message translates to:
  /// **'Forgot my password.'**
  String get esqueciSenha;

  /// No description provided for @definicoes.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get definicoes;

  /// No description provided for @aparencia.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get aparencia;

  /// No description provided for @informacoes.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get informacoes;

  /// No description provided for @horaioFuncionamento.
  ///
  /// In en, this message translates to:
  /// **'Business hours'**
  String get horaioFuncionamento;

  /// No description provided for @formasPagamento.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get formasPagamento;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @areasEntrega.
  ///
  /// In en, this message translates to:
  /// **'Delivery areas'**
  String get areasEntrega;

  /// No description provided for @cores.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get cores;

  /// No description provided for @corPrimaria.
  ///
  /// In en, this message translates to:
  /// **'Primary color'**
  String get corPrimaria;

  /// No description provided for @descCorPrimaria.
  ///
  /// In en, this message translates to:
  /// **'Choose a color to be the main color of your app.'**
  String get descCorPrimaria;

  /// No description provided for @imagens.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get imagens;

  /// No description provided for @descImagens.
  ///
  /// In en, this message translates to:
  /// **'Choose a cover image and a logo for your store.'**
  String get descImagens;

  /// No description provided for @endereco.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get endereco;

  /// No description provided for @enderecoInvalido.
  ///
  /// In en, this message translates to:
  /// **'Invalid address'**
  String get enderecoInvalido;

  /// No description provided for @adicioneEnderecoEntrega.
  ///
  /// In en, this message translates to:
  /// **'Add a delivery address'**
  String get adicioneEnderecoEntrega;

  /// No description provided for @selecioneEnderecoPadraoCliente.
  ///
  /// In en, this message translates to:
  /// **'Select the customer\'s default delivery address'**
  String get selecioneEnderecoPadraoCliente;

  /// No description provided for @enderecoCliente.
  ///
  /// In en, this message translates to:
  /// **'Customer address'**
  String get enderecoCliente;

  /// No description provided for @selecioneClientePedido.
  ///
  /// In en, this message translates to:
  /// **'Select a customer to place the order'**
  String get selecioneClientePedido;

  /// No description provided for @selecionarCliente.
  ///
  /// In en, this message translates to:
  /// **'Select customer'**
  String get selecionarCliente;

  /// No description provided for @pesquiseClienteNomeTelefone.
  ///
  /// In en, this message translates to:
  /// **'Search for your customer by name or phone'**
  String get pesquiseClienteNomeTelefone;

  /// No description provided for @adicionarCliente.
  ///
  /// In en, this message translates to:
  /// **'Add customer'**
  String get adicionarCliente;

  /// No description provided for @novoCliente.
  ///
  /// In en, this message translates to:
  /// **'New customer'**
  String get novoCliente;

  /// No description provided for @nomeCompleto.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get nomeCompleto;

  /// No description provided for @descEndereco.
  ///
  /// In en, this message translates to:
  /// **'Enter the address of your establishment'**
  String get descEndereco;

  /// No description provided for @numero.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get numero;

  /// No description provided for @dataNascimento.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dataNascimento;

  /// No description provided for @complemento.
  ///
  /// In en, this message translates to:
  /// **'Complement'**
  String get complemento;

  /// No description provided for @informacoesPrincipais.
  ///
  /// In en, this message translates to:
  /// **'Main information'**
  String get informacoesPrincipais;

  /// No description provided for @descInformacoesPrincipais.
  ///
  /// In en, this message translates to:
  /// **'Set a name, minimum order value, and contact information'**
  String get descInformacoesPrincipais;

  /// No description provided for @nomeLoja.
  ///
  /// In en, this message translates to:
  /// **'Store name'**
  String get nomeLoja;

  /// No description provided for @descricao.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descricao;

  /// No description provided for @cnpj.
  ///
  /// In en, this message translates to:
  /// **'NIF'**
  String get cnpj;

  /// No description provided for @razaoSocial.
  ///
  /// In en, this message translates to:
  /// **'Corporate name'**
  String get razaoSocial;

  /// No description provided for @pedidoMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum order'**
  String get pedidoMin;

  /// No description provided for @loja.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get loja;

  /// No description provided for @descLoja.
  ///
  /// In en, this message translates to:
  /// **'Store link and service modes (Delivery, Pickup, Table, Kiosk)'**
  String get descLoja;

  /// No description provided for @linkLoja.
  ///
  /// In en, this message translates to:
  /// **'Store link'**
  String get linkLoja;

  /// No description provided for @descLinkLoja.
  ///
  /// In en, this message translates to:
  /// **'Copy your store link and send it to your customers (Not allowed to change).'**
  String get descLinkLoja;

  /// No description provided for @redesSociais.
  ///
  /// In en, this message translates to:
  /// **'Social media'**
  String get redesSociais;

  /// No description provided for @descredesSociais.
  ///
  /// In en, this message translates to:
  /// **'Complete with the link of your business social media, if you have'**
  String get descredesSociais;

  /// No description provided for @adicionar.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get adicionar;

  /// No description provided for @pizzas.
  ///
  /// In en, this message translates to:
  /// **'Pizzas'**
  String get pizzas;

  /// No description provided for @nome.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nome;

  /// No description provided for @preco.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get preco;

  /// No description provided for @precoPromocional.
  ///
  /// In en, this message translates to:
  /// **'Promotional price'**
  String get precoPromocional;

  /// No description provided for @opcoes.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get opcoes;

  /// No description provided for @opcao.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get opcao;

  /// No description provided for @addOpcao.
  ///
  /// In en, this message translates to:
  /// **'Add size option'**
  String get addOpcao;

  /// No description provided for @cancelar.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelar;

  /// No description provided for @salvar.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get salvar;

  /// No description provided for @complementos.
  ///
  /// In en, this message translates to:
  /// **'Complements'**
  String get complementos;

  /// No description provided for @nomeItem.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for this item'**
  String get nomeItem;

  /// No description provided for @preSelecionado.
  ///
  /// In en, this message translates to:
  /// **'Pre-selected'**
  String get preSelecionado;

  /// No description provided for @quantidadeSabores.
  ///
  /// In en, this message translates to:
  /// **'Number of flavors'**
  String get quantidadeSabores;

  /// No description provided for @bordas.
  ///
  /// In en, this message translates to:
  /// **'Borders'**
  String get bordas;

  /// No description provided for @descPageTamnhosQuantidadePizza.
  ///
  /// In en, this message translates to:
  /// **'Define the sizes and number of flavors of your pizzas.'**
  String get descPageTamnhosQuantidadePizza;

  /// No description provided for @tamanhos.
  ///
  /// In en, this message translates to:
  /// **'Sizes'**
  String get tamanhos;

  /// No description provided for @tamanhoLabel.
  ///
  /// In en, this message translates to:
  /// **'Size - slices'**
  String get tamanhoLabel;

  /// No description provided for @adicionais.
  ///
  /// In en, this message translates to:
  /// **'Additions'**
  String get adicionais;

  /// No description provided for @pizzaGrandeNome.
  ///
  /// In en, this message translates to:
  /// **'Large pizza - 8 slices'**
  String get pizzaGrandeNome;

  /// No description provided for @pizzaPequenaNome.
  ///
  /// In en, this message translates to:
  /// **'Small pizza - individual'**
  String get pizzaPequenaNome;

  /// No description provided for @sabores.
  ///
  /// In en, this message translates to:
  /// **'Flavors'**
  String get sabores;

  /// No description provided for @complementoBordasDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose a border for your pizza'**
  String get complementoBordasDesc;

  /// No description provided for @massas.
  ///
  /// In en, this message translates to:
  /// **'Doughs'**
  String get massas;

  /// No description provided for @complementoMassasDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose a dough for your pizza'**
  String get complementoMassasDesc;

  /// No description provided for @bar.
  ///
  /// In en, this message translates to:
  /// **'Bar & Restaurant'**
  String get bar;

  /// No description provided for @bistro.
  ///
  /// In en, this message translates to:
  /// **'French bistro'**
  String get bistro;

  /// No description provided for @buffet.
  ///
  /// In en, this message translates to:
  /// **'Buffet'**
  String get buffet;

  /// No description provided for @cafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get cafe;

  /// No description provided for @italiana.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italiana;

  /// No description provided for @churrascaria.
  ///
  /// In en, this message translates to:
  /// **'Steakhouse'**
  String get churrascaria;

  /// No description provided for @comidaCaseira.
  ///
  /// In en, this message translates to:
  /// **'Homemade food'**
  String get comidaCaseira;

  /// No description provided for @fastFood.
  ///
  /// In en, this message translates to:
  /// **'Fast food'**
  String get fastFood;

  /// No description provided for @comidaSaudavel.
  ///
  /// In en, this message translates to:
  /// **'Healthy food'**
  String get comidaSaudavel;

  /// No description provided for @creperia.
  ///
  /// In en, this message translates to:
  /// **'Creperie'**
  String get creperia;

  /// No description provided for @arabe.
  ///
  /// In en, this message translates to:
  /// **'Arab'**
  String get arabe;

  /// No description provided for @emporio.
  ///
  /// In en, this message translates to:
  /// **'Emporium'**
  String get emporio;

  /// No description provided for @mercado.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get mercado;

  /// No description provided for @oriental.
  ///
  /// In en, this message translates to:
  /// **'Oriental'**
  String get oriental;

  /// No description provided for @japonesa.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japonesa;

  /// No description provided for @chinesa.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinesa;

  /// No description provided for @frutosMar.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get frutosMar;

  /// No description provided for @hamburgueria.
  ///
  /// In en, this message translates to:
  /// **'Burger joint'**
  String get hamburgueria;

  /// No description provided for @pizzaria.
  ///
  /// In en, this message translates to:
  /// **'Pizzeria'**
  String get pizzaria;

  /// No description provided for @sorveteria.
  ///
  /// In en, this message translates to:
  /// **'Ice cream parlor'**
  String get sorveteria;

  /// No description provided for @padaria.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get padaria;

  /// No description provided for @sanduiches.
  ///
  /// In en, this message translates to:
  /// **'Sandwiches'**
  String get sanduiches;

  /// No description provided for @sucos.
  ///
  /// In en, this message translates to:
  /// **'Juices & Vitamins'**
  String get sucos;

  /// No description provided for @farmacia.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get farmacia;

  /// No description provided for @vegetariana.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get vegetariana;

  /// No description provided for @vegana.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get vegana;

  /// No description provided for @aPartirDe.
  ///
  /// In en, this message translates to:
  /// **'Starting from'**
  String get aPartirDe;

  /// No description provided for @deletar.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deletar;

  /// No description provided for @editar.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editar;

  /// No description provided for @sim.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get sim;

  /// No description provided for @bordaCatupiry.
  ///
  /// In en, this message translates to:
  /// **'Catupiry'**
  String get bordaCatupiry;

  /// No description provided for @bordaCheddar.
  ///
  /// In en, this message translates to:
  /// **'Cheddar'**
  String get bordaCheddar;

  /// No description provided for @saborMussarela.
  ///
  /// In en, this message translates to:
  /// **'Mozzarella'**
  String get saborMussarela;

  /// No description provided for @descMussarela.
  ///
  /// In en, this message translates to:
  /// **'Homemade tomato sauce, mozzarella, catupiry, olives, and oregano.'**
  String get descMussarela;

  /// No description provided for @saborCalabresa.
  ///
  /// In en, this message translates to:
  /// **'Calabrese'**
  String get saborCalabresa;

  /// No description provided for @descCalabresa.
  ///
  /// In en, this message translates to:
  /// **'Homemade tomato sauce, calabrese, catupiry, onions, olives, and oregano.'**
  String get descCalabresa;

  /// No description provided for @pizzaGrandeDefault.
  ///
  /// In en, this message translates to:
  /// **'Large pizza - 8 slices'**
  String get pizzaGrandeDefault;

  /// No description provided for @pizzaPequenaDefault.
  ///
  /// In en, this message translates to:
  /// **'Small pizza - individual'**
  String get pizzaPequenaDefault;

  /// No description provided for @massaTradicional.
  ///
  /// In en, this message translates to:
  /// **'Traditional dough'**
  String get massaTradicional;

  /// No description provided for @emptySateteProdutos.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any products yet.'**
  String get emptySateteProdutos;

  /// No description provided for @emptySateteCategorias.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any categories yet.'**
  String get emptySateteCategorias;

  /// No description provided for @emptySateteComplementos.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any complements yet.'**
  String get emptySateteComplementos;

  /// No description provided for @emptySateteSaborPizza.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any flavors yet.'**
  String get emptySateteSaborPizza;

  /// No description provided for @adicionarSaborPizzaA.
  ///
  /// In en, this message translates to:
  /// **'Add flavor to {name}'**
  String adicionarSaborPizzaA(Object name);

  /// No description provided for @emptyStateItens.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any items yet.'**
  String get emptyStateItens;

  /// No description provided for @adicionarProdutoA.
  ///
  /// In en, this message translates to:
  /// **'Add product to {name}'**
  String adicionarProdutoA(Object name);

  /// No description provided for @adicionarItemA.
  ///
  /// In en, this message translates to:
  /// **'Add item to {name}'**
  String adicionarItemA(Object name);

  /// No description provided for @precoPromocionalDeveSerMenorQuePreco.
  ///
  /// In en, this message translates to:
  /// **'The promotional price must be lower than the regular price'**
  String get precoPromocionalDeveSerMenorQuePreco;

  /// No description provided for @imagemExcluidaSucesso.
  ///
  /// In en, this message translates to:
  /// **'Image successfully deleted!'**
  String get imagemExcluidaSucesso;

  /// No description provided for @deletarImagem.
  ///
  /// In en, this message translates to:
  /// **'Delete image'**
  String get deletarImagem;

  /// No description provided for @uploadImagem.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get uploadImagem;

  /// No description provided for @descZoomImagem.
  ///
  /// In en, this message translates to:
  /// **'Use your mouse scroll to zoom in/out of your image'**
  String get descZoomImagem;

  /// No description provided for @imagemSalvaComSucesso.
  ///
  /// In en, this message translates to:
  /// **'Image saved successfully!'**
  String get imagemSalvaComSucesso;

  /// No description provided for @vocePrecisaSelecionarUmaImagem.
  ///
  /// In en, this message translates to:
  /// **'You need to select an image'**
  String get vocePrecisaSelecionarUmaImagem;

  /// No description provided for @adicionarTamanho.
  ///
  /// In en, this message translates to:
  /// **'Add size'**
  String get adicionarTamanho;

  /// No description provided for @categorias.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categorias;

  /// No description provided for @addCategoria.
  ///
  /// In en, this message translates to:
  /// **'To add a new category just click the button next to it'**
  String get addCategoria;

  /// No description provided for @descMenu.
  ///
  /// In en, this message translates to:
  /// **'Manage your products'**
  String get descMenu;

  /// No description provided for @sincronizar.
  ///
  /// In en, this message translates to:
  /// **'Sync changes'**
  String get sincronizar;

  /// No description provided for @tituloEditarCategoria.
  ///
  /// In en, this message translates to:
  /// **'Edit your category.'**
  String get tituloEditarCategoria;

  /// No description provided for @tituloEditarComplemento.
  ///
  /// In en, this message translates to:
  /// **'Edit your complement.'**
  String get tituloEditarComplemento;

  /// No description provided for @tituloComplemento.
  ///
  /// In en, this message translates to:
  /// **'Register and define the rules for your complement'**
  String get tituloComplemento;

  /// No description provided for @tituloCategoria.
  ///
  /// In en, this message translates to:
  /// **'Choose a category option.'**
  String get tituloCategoria;

  /// No description provided for @produtos.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get produtos;

  /// No description provided for @descCategoriaProdutos.
  ///
  /// In en, this message translates to:
  /// **'Products in general, e.g., snacks, sweets, lunch boxes, etc...'**
  String get descCategoriaProdutos;

  /// No description provided for @descCategoriaPizza.
  ///
  /// In en, this message translates to:
  /// **'Exclusive category for pizzas'**
  String get descCategoriaPizza;

  /// No description provided for @nomeDaCategoria.
  ///
  /// In en, this message translates to:
  /// **'Category name*'**
  String get nomeDaCategoria;

  /// No description provided for @gratuito.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get gratuito;

  /// No description provided for @extras.
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get extras;

  /// No description provided for @tooltipNomeComplemento.
  ///
  /// In en, this message translates to:
  /// **'This field appears to the customer\non the menu'**
  String get tooltipNomeComplemento;

  /// No description provided for @tooltipIdentificador.
  ///
  /// In en, this message translates to:
  /// **'This field only appears to you \nto help identify the complement'**
  String get tooltipIdentificador;

  /// No description provided for @identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get identifier;

  /// No description provided for @hintIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Extras_snacks_simple_01'**
  String get hintIdentifier;

  /// No description provided for @quantidadeMinima.
  ///
  /// In en, this message translates to:
  /// **'Minimum quantity'**
  String get quantidadeMinima;

  /// No description provided for @hintQuantidadeMinima.
  ///
  /// In en, this message translates to:
  /// **'e.g.: 0'**
  String get hintQuantidadeMinima;

  /// No description provided for @quantidadeMaxima.
  ///
  /// In en, this message translates to:
  /// **'Maximum quantity'**
  String get quantidadeMaxima;

  /// No description provided for @hintQuantidadeMaxima.
  ///
  /// In en, this message translates to:
  /// **'e.g.: 5'**
  String get hintQuantidadeMaxima;

  /// No description provided for @validatorQuantidadeMaxima.
  ///
  /// In en, this message translates to:
  /// **'Maximum quantity must be greater than minimum quantity.'**
  String get validatorQuantidadeMaxima;

  /// No description provided for @tipoDoSeletor.
  ///
  /// In en, this message translates to:
  /// **'Selector type'**
  String get tipoDoSeletor;

  /// No description provided for @seletorUnico.
  ///
  /// In en, this message translates to:
  /// **'Single selector'**
  String get seletorUnico;

  /// No description provided for @descSeletorUnico.
  ///
  /// In en, this message translates to:
  /// **'Allows selecting the same item only once.'**
  String get descSeletorUnico;

  /// No description provided for @seletorMultiplo.
  ///
  /// In en, this message translates to:
  /// **'Multiple selector'**
  String get seletorMultiplo;

  /// No description provided for @descSeletorMultiplo.
  ///
  /// In en, this message translates to:
  /// **'Allows selecting the same item multiple times.'**
  String get descSeletorMultiplo;

  /// No description provided for @obrigatorio.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get obrigatorio;

  /// No description provided for @feedbackSucessImagemDeletada.
  ///
  /// In en, this message translates to:
  /// **'Image successfully deleted!'**
  String get feedbackSucessImagemDeletada;

  /// No description provided for @bordasEMassas.
  ///
  /// In en, this message translates to:
  /// **'Borders & Doughs'**
  String get bordasEMassas;

  /// No description provided for @tituloBordasEMassas.
  ///
  /// In en, this message translates to:
  /// **'Define the options for the borders and dough of your pizzas'**
  String get tituloBordasEMassas;

  /// No description provided for @descSelecionarImage.
  ///
  /// In en, this message translates to:
  /// **'Select a new image for your item'**
  String get descSelecionarImage;

  /// No description provided for @tituloConfirmacaoExclusao.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get tituloConfirmacaoExclusao;

  /// No description provided for @descConfirmacaoExclusao.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Type {sim} to confirm.'**
  String descConfirmacaoExclusao(Object sim);

  /// No description provided for @validatorConfirmacaoExclusao.
  ///
  /// In en, this message translates to:
  /// **'Type {sim} in the field to confirm.'**
  String validatorConfirmacaoExclusao(Object sim);

  /// No description provided for @pedidos.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get pedidos;

  /// No description provided for @pedido.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get pedido;

  /// No description provided for @descComplementRequiredObrigatio.
  ///
  /// In en, this message translates to:
  /// **'Choose {qty} option'**
  String descComplementRequiredObrigatio(Object qty);

  /// No description provided for @descComplementRequiredObrigatioPlural.
  ///
  /// In en, this message translates to:
  /// **'Choose {qty} options'**
  String descComplementRequiredObrigatioPlural(Object qty);

  /// No description provided for @descComplementObrigatio.
  ///
  /// In en, this message translates to:
  /// **'Choose at least {qty} option'**
  String descComplementObrigatio(Object qty);

  /// No description provided for @descComplementObrigatioPlural.
  ///
  /// In en, this message translates to:
  /// **'Choose at least {qty} options'**
  String descComplementObrigatioPlural(Object qty);

  /// No description provided for @descComplementLivre.
  ///
  /// In en, this message translates to:
  /// **'Choose up to {qty} option'**
  String descComplementLivre(Object qty);

  /// No description provided for @descComplementLivrePlural.
  ///
  /// In en, this message translates to:
  /// **'Choose up to {qty} options'**
  String descComplementLivrePlural(Object qty);

  /// No description provided for @descComplementLivreIlimitado.
  ///
  /// In en, this message translates to:
  /// **'Choose as many options as you want'**
  String get descComplementLivreIlimitado;

  /// No description provided for @descComplementPizza.
  ///
  /// In en, this message translates to:
  /// **'Choose {qty} flavor'**
  String descComplementPizza(Object qty);

  /// No description provided for @descComplementPizzaPlural.
  ///
  /// In en, this message translates to:
  /// **'Choose {qty} flavors'**
  String descComplementPizzaPlural(Object qty);

  /// No description provided for @descComplementAte.
  ///
  /// In en, this message translates to:
  /// **'To {qty}'**
  String descComplementAte(Object qty);

  /// No description provided for @observacoes.
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get observacoes;

  /// No description provided for @observacoesDesc.
  ///
  /// In en, this message translates to:
  /// **'Write your observations here...'**
  String get observacoesDesc;

  /// No description provided for @sabor.
  ///
  /// In en, this message translates to:
  /// **'{qty} Flavor'**
  String sabor(Object qty);

  /// No description provided for @saborPlural.
  ///
  /// In en, this message translates to:
  /// **'{qty} Flavors'**
  String saborPlural(Object qty);

  /// No description provided for @obs.
  ///
  /// In en, this message translates to:
  /// **'Obs: {content}'**
  String obs(Object content);

  /// No description provided for @subTotalValor.
  ///
  /// In en, this message translates to:
  /// **'Subtotal {value}'**
  String subTotalValor(Object value);

  /// No description provided for @totalMaisPreco.
  ///
  /// In en, this message translates to:
  /// **'Total {value}'**
  String totalMaisPreco(Object value);

  /// No description provided for @pdv.
  ///
  /// In en, this message translates to:
  /// **'Pdv'**
  String get pdv;

  /// No description provided for @selecionarMesa.
  ///
  /// In en, this message translates to:
  /// **'Select table'**
  String get selecionarMesa;

  /// No description provided for @clienteAvulso.
  ///
  /// In en, this message translates to:
  /// **'Walk-in customer'**
  String get clienteAvulso;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @ola.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get ola;

  /// No description provided for @pesquisarProdutos.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get pesquisarProdutos;

  /// No description provided for @impressao.
  ///
  /// In en, this message translates to:
  /// **'Printing'**
  String get impressao;

  /// No description provided for @taxaEntrega.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get taxaEntrega;

  /// No description provided for @desconto.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get desconto;

  /// No description provided for @subtota.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtota;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @troco.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get troco;

  /// No description provided for @telefone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get telefone;

  /// No description provided for @bairro.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood'**
  String get bairro;

  /// No description provided for @credito.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credito;

  /// No description provided for @debito.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debito;

  /// No description provided for @voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @foodTicket.
  ///
  /// In en, this message translates to:
  /// **'Meal ticket'**
  String get foodTicket;

  /// No description provided for @mealTicket.
  ///
  /// In en, this message translates to:
  /// **'Food voucher'**
  String get mealTicket;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @entrega.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get entrega;

  /// No description provided for @retirada.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get retirada;

  /// No description provided for @consumo.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get consumo;

  /// No description provided for @kiosk.
  ///
  /// In en, this message translates to:
  /// **'Kiosk'**
  String get kiosk;

  /// No description provided for @mesa.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get mesa;

  /// No description provided for @trocop.
  ///
  /// In en, this message translates to:
  /// **'Change for'**
  String get trocop;

  /// No description provided for @finalizar.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finalizar;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @inDelivery.
  ///
  /// In en, this message translates to:
  /// **'In delivery'**
  String get inDelivery;

  /// No description provided for @awaitingPickup.
  ///
  /// In en, this message translates to:
  /// **'Awaiting pickup'**
  String get awaitingPickup;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// No description provided for @segunda.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get segunda;

  /// No description provided for @terca.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get terca;

  /// No description provided for @quarta.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get quarta;

  /// No description provided for @quinta.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get quinta;

  /// No description provided for @sexta.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get sexta;

  /// No description provided for @sabado.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get sabado;

  /// No description provided for @domingo.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get domingo;

  /// No description provided for @pix.
  ///
  /// In en, this message translates to:
  /// **'Pix'**
  String get pix;

  /// No description provided for @tempoAbreviado.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to} min'**
  String tempoAbreviado(Object from, Object to);

  /// No description provided for @pedidoMinimoAbreviado.
  ///
  /// In en, this message translates to:
  /// **'Min order {value}'**
  String pedidoMinimoAbreviado(Object value);

  /// No description provided for @ate.
  ///
  /// In en, this message translates to:
  /// **'Until {time}'**
  String ate(Object time);

  /// No description provided for @copiarCodigo.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copiarCodigo;

  /// No description provided for @codigoCopiadoSucesso.
  ///
  /// In en, this message translates to:
  /// **'Code copied successfully!'**
  String get codigoCopiadoSucesso;

  /// No description provided for @gerandoQrCode.
  ///
  /// In en, this message translates to:
  /// **'Generating QR Code'**
  String get gerandoQrCode;

  /// No description provided for @aguardandoPagamento.
  ///
  /// In en, this message translates to:
  /// **'Awaiting payment'**
  String get aguardandoPagamento;

  /// No description provided for @pagamentoRealizado.
  ///
  /// In en, this message translates to:
  /// **'Payment made'**
  String get pagamentoRealizado;

  /// No description provided for @qtyMaisLabelBotaoVerCarrinho.
  ///
  /// In en, this message translates to:
  /// **'{qty} - Items | View Cart'**
  String qtyMaisLabelBotaoVerCarrinho(Object qty);

  /// No description provided for @estabelecimentoNaoEstaAbertoNoMomento.
  ///
  /// In en, this message translates to:
  /// **'The establishment is not open at the moment.'**
  String get estabelecimentoNaoEstaAbertoNoMomento;

  /// No description provided for @resumoPedido.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get resumoPedido;

  /// No description provided for @itensPedido.
  ///
  /// In en, this message translates to:
  /// **'Order items'**
  String get itensPedido;

  /// No description provided for @adicionarMaisItens.
  ///
  /// In en, this message translates to:
  /// **'Add more items'**
  String get adicionarMaisItens;

  /// No description provided for @dadosContato.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get dadosContato;

  /// No description provided for @gratuita.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get gratuita;

  /// No description provided for @cliqueParaAdicionarEnderecoEntrega.
  ///
  /// In en, this message translates to:
  /// **'Click to add a delivery address'**
  String get cliqueParaAdicionarEnderecoEntrega;

  /// No description provided for @naoEPossivelRetirar.
  ///
  /// In en, this message translates to:
  /// **'Cannot be picked up'**
  String get naoEPossivelRetirar;

  /// No description provided for @comoDesejaReceberSeuPedido.
  ///
  /// In en, this message translates to:
  /// **'How do you want to receive your order?'**
  String get comoDesejaReceberSeuPedido;

  /// No description provided for @desejaRemoverEsteItemDoCarrinho.
  ///
  /// In en, this message translates to:
  /// **'Do you want to remove this item from the cart?'**
  String get desejaRemoverEsteItemDoCarrinho;

  /// No description provided for @removerItemDoCarrinho.
  ///
  /// In en, this message translates to:
  /// **'Remove item from cart'**
  String get removerItemDoCarrinho;

  /// No description provided for @escolherFormaPagamento.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get escolherFormaPagamento;

  /// No description provided for @selecioneUmaOpcaoParaReceberSeuPedido.
  ///
  /// In en, this message translates to:
  /// **'Select an option to receive your order, \'Delivery or Pickup\'.'**
  String get selecioneUmaOpcaoParaReceberSeuPedido;

  /// No description provided for @fechado.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get fechado;

  /// No description provided for @aberto.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get aberto;

  /// No description provided for @localizacaoDoEstabelecimento.
  ///
  /// In en, this message translates to:
  /// **'Establishment location'**
  String get localizacaoDoEstabelecimento;

  /// No description provided for @confirmeSeuEnderecoEntrega.
  ///
  /// In en, this message translates to:
  /// **'Confirm your delivery address.'**
  String get confirmeSeuEnderecoEntrega;

  /// No description provided for @confirmarEndereco.
  ///
  /// In en, this message translates to:
  /// **'Confirm address'**
  String get confirmarEndereco;

  /// No description provided for @vocePrecisaDeTroco.
  ///
  /// In en, this message translates to:
  /// **'Do you need change?'**
  String get vocePrecisaDeTroco;

  /// No description provided for @trocoP.
  ///
  /// In en, this message translates to:
  /// **'Change for'**
  String get trocoP;

  /// No description provided for @confirmar.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmar;

  /// No description provided for @comoDesejaPagar.
  ///
  /// In en, this message translates to:
  /// **'How do you want to pay?'**
  String get comoDesejaPagar;

  /// No description provided for @oEstabelecimentoSeEncontraFechadoNoMomento.
  ///
  /// In en, this message translates to:
  /// **'The establishment is currently closed, try again later.'**
  String get oEstabelecimentoSeEncontraFechadoNoMomento;

  /// No description provided for @fazerUmNovoPedido.
  ///
  /// In en, this message translates to:
  /// **'Place a new order'**
  String get fazerUmNovoPedido;

  /// No description provided for @copiarChave.
  ///
  /// In en, this message translates to:
  /// **'Copy key'**
  String get copiarChave;

  /// No description provided for @chavePixNaoCadastradaEntreContatoEstabelecimento.
  ///
  /// In en, this message translates to:
  /// **'PIX key not registered. Contact the establishment.'**
  String get chavePixNaoCadastradaEntreContatoEstabelecimento;

  /// No description provided for @chaveCopiaComSucesso.
  ///
  /// In en, this message translates to:
  /// **'Key copied successfully!'**
  String get chaveCopiaComSucesso;

  /// No description provided for @para.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get para;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get data;

  /// No description provided for @enderecoDeEntrega.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get enderecoDeEntrega;

  /// No description provided for @codigo.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get codigo;

  /// No description provided for @ou.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get ou;

  /// No description provided for @desejaIrAte.
  ///
  /// In en, this message translates to:
  /// **'Do you want to go to {name}'**
  String desejaIrAte(Object name);

  /// No description provided for @tracarRotaNoMapa.
  ///
  /// In en, this message translates to:
  /// **'Plot route on the map'**
  String get tracarRotaNoMapa;

  /// No description provided for @enderecoParaFazerRetirada.
  ///
  /// In en, this message translates to:
  /// **'Address for pickup'**
  String get enderecoParaFazerRetirada;

  /// No description provided for @pedidoCanceladoPeloEstabelecimento.
  ///
  /// In en, this message translates to:
  /// **'Order canceled by the establishment.'**
  String get pedidoCanceladoPeloEstabelecimento;

  /// No description provided for @tempoExpirado.
  ///
  /// In en, this message translates to:
  /// **'Time expired'**
  String get tempoExpirado;

  /// No description provided for @naoSePreocupeExtornoSeuPagamento.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, we have already refunded your payment.'**
  String get naoSePreocupeExtornoSeuPagamento;

  /// No description provided for @aguarandoAprovacaoRestaurante.
  ///
  /// In en, this message translates to:
  /// **'Awaiting restaurant approval'**
  String get aguarandoAprovacaoRestaurante;

  /// No description provided for @preparando.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get preparando;

  /// No description provided for @saiuParaEntrega.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get saiuParaEntrega;

  /// No description provided for @entregue.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get entregue;

  /// No description provided for @aguardandoRetirada.
  ///
  /// In en, this message translates to:
  /// **'Ready, awaiting pickup.'**
  String get aguardandoRetirada;

  /// No description provided for @estabelecimentoTemEsteTempoParaAceitarSeuPedido.
  ///
  /// In en, this message translates to:
  /// **'{name} has this time to accept your order.'**
  String estabelecimentoTemEsteTempoParaAceitarSeuPedido(Object name);

  /// No description provided for @entreContatoEstabelecimentoReembolso.
  ///
  /// In en, this message translates to:
  /// **'Contact the establishment for your refund {phone}'**
  String entreContatoEstabelecimentoReembolso(Object phone);

  /// No description provided for @deUmApelidoParaSeuEndereco.
  ///
  /// In en, this message translates to:
  /// **'Give a nickname to your address'**
  String get deUmApelidoParaSeuEndereco;

  /// No description provided for @apelidoEnderecoHint.
  ///
  /// In en, this message translates to:
  /// **'e.g.: Home, Work, Mother-in-law\'s house...'**
  String get apelidoEnderecoHint;

  /// No description provided for @qualESeuNome.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get qualESeuNome;

  /// No description provided for @digiteSeuNome.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get digiteSeuNome;

  /// No description provided for @codigoInvalido.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get codigoInvalido;

  /// No description provided for @numeroAtualizadoSucesso.
  ///
  /// In en, this message translates to:
  /// **'Number successfully updated!'**
  String get numeroAtualizadoSucesso;

  /// No description provided for @insiraTelefoneContato.
  ///
  /// In en, this message translates to:
  /// **'Enter your contact phone.'**
  String get insiraTelefoneContato;

  /// No description provided for @codigoEnviadoWpp.
  ///
  /// In en, this message translates to:
  /// **'Code sent to your WhatsApp.'**
  String get codigoEnviadoWpp;

  /// No description provided for @verifiqueSeuWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Check your WhatsApp.'**
  String get verifiqueSeuWhatsapp;

  /// No description provided for @codigoEnviadoSms.
  ///
  /// In en, this message translates to:
  /// **'Code sent via SMS.'**
  String get codigoEnviadoSms;

  /// No description provided for @verifiqueSuasMensagens.
  ///
  /// In en, this message translates to:
  /// **'Check your messages.'**
  String get verifiqueSuasMensagens;

  /// No description provided for @digiteSeuEnderecoEntrega.
  ///
  /// In en, this message translates to:
  /// **'Enter your delivery address.'**
  String get digiteSeuEnderecoEntrega;

  /// No description provided for @naoAbrevieSeuEnderecoParaEvitarErros.
  ///
  /// In en, this message translates to:
  /// **'Do not abbreviate your address to avoid errors.'**
  String get naoAbrevieSeuEnderecoParaEvitarErros;

  /// No description provided for @enderecoInvalidoDesc.
  ///
  /// In en, this message translates to:
  /// **'Check that you haven\'t forgotten any fields, or that the address was entered correctly.'**
  String get enderecoInvalidoDesc;

  /// No description provided for @cep.
  ///
  /// In en, this message translates to:
  /// **'Post code'**
  String get cep;

  /// No description provided for @erroBuscaCep.
  ///
  /// In en, this message translates to:
  /// **'Error finding ZIP code'**
  String get erroBuscaCep;

  /// No description provided for @pago.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get pago;

  /// No description provided for @meusEnderecos.
  ///
  /// In en, this message translates to:
  /// **'My addresses'**
  String get meusEnderecos;

  /// No description provided for @adicionarEndereco.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get adicionarEndereco;

  /// No description provided for @temCerteza.
  ///
  /// In en, this message translates to:
  /// **'Are you sure'**
  String get temCerteza;

  /// No description provided for @excluirEndereco.
  ///
  /// In en, this message translates to:
  /// **'Delete address'**
  String get excluirEndereco;

  /// No description provided for @queDesejaExcluirEsteEndereco.
  ///
  /// In en, this message translates to:
  /// **'That you want to delete this address?'**
  String get queDesejaExcluirEsteEndereco;

  /// No description provided for @hintBuscarEndereco.
  ///
  /// In en, this message translates to:
  /// **'e.g. 9 Times Square, New York, NY...'**
  String get hintBuscarEndereco;

  /// No description provided for @hintComplementoEndereco.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4th floor - 201'**
  String get hintComplementoEndereco;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @padrao.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get padrao;

  /// No description provided for @agendar.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get agendar;

  /// No description provided for @selecionarHorario.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get selecionarHorario;

  /// No description provided for @selecioneUmHorario.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get selecioneUmHorario;

  /// No description provided for @selecionarData.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selecionarData;

  /// No description provided for @tempoEstimado.
  ///
  /// In en, this message translates to:
  /// **'Estimated time'**
  String get tempoEstimado;

  /// No description provided for @agendarPedido.
  ///
  /// In en, this message translates to:
  /// **'Scheadule order'**
  String get agendarPedido;

  /// No description provided for @confimarAgendamento.
  ///
  /// In en, this message translates to:
  /// **'Confirm scheduling'**
  String get confimarAgendamento;

  /// No description provided for @hoje.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get hoje;

  /// No description provided for @amanha.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get amanha;

  /// No description provided for @agendado.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get agendado;

  /// No description provided for @pedidoMinimoNaoAtingido.
  ///
  /// In en, this message translates to:
  /// **'Minimum order of {value} not reached'**
  String pedidoMinimoNaoAtingido(Object value);

  /// No description provided for @erroOrderTypeVazio.
  ///
  /// In en, this message translates to:
  /// **'Choose between delivery or pickup to continue.'**
  String get erroOrderTypeVazio;

  /// No description provided for @inserirEnderecoManualmente.
  ///
  /// In en, this message translates to:
  /// **'Insert address manually'**
  String get inserirEnderecoManualmente;

  /// No description provided for @pedidoCancelado.
  ///
  /// In en, this message translates to:
  /// **'Order canceled'**
  String get pedidoCancelado;

  /// No description provided for @pagar.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pagar;

  /// No description provided for @distanciaMaximaExcedida.
  ///
  /// In en, this message translates to:
  /// **'Maximum distance exceeded, try another address.'**
  String get distanciaMaximaExcedida;

  /// No description provided for @infelizmenteOEstabelecimentoEstaFechado.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, the establishment is currently closed.'**
  String get infelizmenteOEstabelecimentoEstaFechado;

  /// No description provided for @digiteUmEnderecoParaBuscar.
  ///
  /// In en, this message translates to:
  /// **'Enter an address to search'**
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
