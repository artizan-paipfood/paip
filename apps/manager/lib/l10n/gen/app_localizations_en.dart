// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get wppGreetingsMessage => '🤖 Hello! I am the Virtual Attendant of [establishment_name]. \n\nTo place an order conveniently, click the link below: \n\n👇🏼 Tap to order 👇🏼 \n[link_company]';

  @override
  String get wppPending => 'Hello [name]👋, \nGreat to see you here! \n> We have received your order, please wait for confirmation. \n\n> Here is the link if you want to track it:\n[link_order_status]';

  @override
  String get wppAccepted => '[name]\nYour order has been accepted!\n\nHere is the link if you want to track it:\n[link_order_status]';

  @override
  String get wppAwaitingDelivery => '[name]\n> Your order is ready. \nThe delivery man is on his way to collect your order here in [establishment_name]!';

  @override
  String get wppAwaitingPickup => 'The wait is over! 😍\n> Your order is ready and waiting for you!';

  @override
  String get wppDelivered => 'Your order has been delivered\nthank you very much for your trust! 😊';

  @override
  String get wppInDelivery => 'We have great news for you!😀\n> Your order is out for delivery and will arrive soon. If you have any questions, we are here to help.';

  @override
  String get wppLocalOrderMessage => 'Hello [name] 👋\nGreat to see you here!\n\nYour order has been placed and is already being prepared.✅\n\n> I will be back soon with updates on its status.\n\nHere is the link if you want to track it:\n[link_order_status]';

  @override
  String get credit => 'Credit';

  @override
  String get pago => 'Paid';

  @override
  String get debit => 'Debit';

  @override
  String get voucher => 'Voucher';

  @override
  String get foodTicket => 'Food Ticket';

  @override
  String get mealTicket => 'Meal Ticket';

  @override
  String get cash => 'Cash';

  @override
  String get pix => 'Pix';

  @override
  String get email => 'Email';

  @override
  String get senha => 'Password';

  @override
  String get entrar => 'Login';

  @override
  String get naoTemConta => 'Don\'t have an account?';

  @override
  String get registrese => 'Register';

  @override
  String get esqueceuSenha => 'Forgot your password?';

  @override
  String get definicoes => 'Settings';

  @override
  String get aparencia => 'Appearance';

  @override
  String get informacoes => 'Information';

  @override
  String get horaioFuncionamento => 'Business hours';

  @override
  String get formasPagamento => 'Payment methods';

  @override
  String get menu => 'Menu';

  @override
  String get areasEntrega => 'Delivery areas';

  @override
  String get cores => 'Colors';

  @override
  String get corPrimaria => 'Primary color';

  @override
  String get descCorPrimaria => 'Choose a color to be the primary color of your app.';

  @override
  String get imagens => 'Images';

  @override
  String get descImagens => 'Choose a cover image and a logo for your store.';

  @override
  String get endereco => 'Address';

  @override
  String get adicionarEndereco => 'Add address';

  @override
  String get enderecoInvalido => 'Invalid address';

  @override
  String get adicioneEnderecoEntrega => 'Add a delivery address';

  @override
  String get selecioneEnderecoPadraoCliente => 'Select the customer\'s default delivery address';

  @override
  String get enderecoCliente => 'Customer address';

  @override
  String get selecioneClientePedido => 'Select a customer to place the order';

  @override
  String get selecionarCliente => 'Select customer';

  @override
  String get pesquiseClienteNomeTelefone => 'Search your customer by name or phone';

  @override
  String get adicionarCliente => 'Add customer';

  @override
  String get novoCliente => 'New customer';

  @override
  String get nomeCompleto => 'Full name';

  @override
  String get descEndereco => 'Enter your establishment\'s address';

  @override
  String get numero => 'Number';

  @override
  String get dataNascimento => 'Date of birth';

  @override
  String get complemento => 'Additional info';

  @override
  String get informacoesPrincipais => 'Main Information';

  @override
  String get descInformacoesPrincipais => 'Set a name, minimum order value, and contact information';

  @override
  String get nomeLoja => 'Store Name';

  @override
  String get descricao => 'Description';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get razaoSocial => 'Corporate Name';

  @override
  String get pedidoMin => 'Minimum order';

  @override
  String get loja => 'Store';

  @override
  String get descLoja => 'Store link and service modes (Delivery, Pickup, Table, Kiosk)';

  @override
  String get linkLoja => 'Store link';

  @override
  String get descLinkLoja => 'Copy your store link and send it to your customers (Cannot be changed).';

  @override
  String get redesSociais => 'Social Media';

  @override
  String get descredesSociais => 'Fill in the social media links of your business, if any';

  @override
  String get adicionar => 'Add';

  @override
  String get pizzas => 'Pizzas';

  @override
  String get nome => 'Name';

  @override
  String get preco => 'Price';

  @override
  String get precoPromocional => 'Promotional price';

  @override
  String get opcoes => 'Options';

  @override
  String get opcao => 'Option';

  @override
  String get addOpcao => 'Add size option';

  @override
  String get cancelar => 'Cancel';

  @override
  String get salvar => 'Save';

  @override
  String get complementos => 'Add-ons';

  @override
  String get nomeItem => 'Enter a name for this item';

  @override
  String get preSelecionado => 'Pre-selected';

  @override
  String get quantidadeSabores => 'Number of flavors';

  @override
  String get bordas => 'Edges';

  @override
  String get descPageTamnhosQuantidadePizza => 'Define the sizes and number of flavors for your pizzas.';

  @override
  String get tamanhos => 'Sizes';

  @override
  String get tamanhoLabel => 'Size - slices';

  @override
  String get adicionais => 'Extras';

  @override
  String get pizzaGrandeNome => 'Large pizza - 8 slices';

  @override
  String get pizzaPequenaNome => 'Small pizza - individual';

  @override
  String get sabores => 'Flavors';

  @override
  String get complementoBordasDesc => 'Choose an edge for your pizza';

  @override
  String get massas => 'Doughs';

  @override
  String get complementoMassasDesc => 'Choose a dough for your pizza';

  @override
  String get bar => 'Bar & Restaurant';

  @override
  String get bistro => 'French Bistro';

  @override
  String get buffet => 'Buffet';

  @override
  String get cafe => 'Coffee shop';

  @override
  String get italiana => 'Italian';

  @override
  String get churrascaria => 'Steakhouse';

  @override
  String get comidaCaseira => 'Homemade food';

  @override
  String get fastFood => 'Fast Food';

  @override
  String get comidaSaudavel => 'Healthy food';

  @override
  String get creperia => 'Creperie';

  @override
  String get arabe => 'Arabian';

  @override
  String get emporio => 'Emporium';

  @override
  String get mercado => 'Market';

  @override
  String get oriental => 'Oriental';

  @override
  String get japonesa => 'Japanese';

  @override
  String get chinesa => 'Chinese';

  @override
  String get frutosMar => 'Seafood';

  @override
  String get hamburgueria => 'Burger joint';

  @override
  String get pizzaria => 'Pizzeria';

  @override
  String get sorveteria => 'Ice cream parlor';

  @override
  String get padaria => 'Bakery';

  @override
  String get sanduiches => 'Sandwiches';

  @override
  String get sucos => 'Juices & Vitamins';

  @override
  String get farmacia => 'Pharmacy';

  @override
  String get vegetariana => 'Vegetarian';

  @override
  String get vegana => 'Vegan';

  @override
  String aPartirDe(Object value) {
    return 'Starting from $value';
  }

  @override
  String get deletar => 'Delete';

  @override
  String get editar => 'Edit';

  @override
  String get sim => 'Yes';

  @override
  String get bordaCatupiry => 'Catupiry';

  @override
  String get bordaCheddar => 'Cheddar';

  @override
  String get saborMussarela => 'Mozzarella';

  @override
  String get descMussarela => 'Homemade tomato sauce, mozzarella, catupiry, olives, and oregano.';

  @override
  String get saborCalabresa => 'Calabrese';

  @override
  String get descCalabresa => 'Homemade tomato sauce, calabrese sausage, catupiry, onion, olives, and oregano.';

  @override
  String get pizzaGrandeDefault => 'Large Pizza - 8 slices';

  @override
  String get pizzaPequenaDefault => 'Small Pizza - Individual';

  @override
  String get massaTradicional => 'Traditional Dough';

  @override
  String get emptySateteProdutos => 'You haven\'t added any products yet.';

  @override
  String get emptySateteCategorias => 'You haven\'t added any categories yet.';

  @override
  String get emptySateteComplementos => 'You haven\'t added any add-ons yet.';

  @override
  String get emptySateteSaborPizza => 'You haven\'t added any flavor yet.';

  @override
  String adicionarSaborPizzaA(Object name) {
    return 'Add flavor to $name';
  }

  @override
  String get emptyStateItens => 'You haven\'t added any items yet.';

  @override
  String adicionarProdutoA(Object name) {
    return 'Add product to $name';
  }

  @override
  String adicionarItemA(Object name) {
    return 'Add item to $name';
  }

  @override
  String get precoPromocionalDeveSerMenorQuePreco => 'The promotional price must be less than the price';

  @override
  String get imagemExcluidaSucesso => 'Image successfully deleted!';

  @override
  String get deletarImagem => 'Delete image';

  @override
  String get uploadImagem => 'Select image';

  @override
  String get descZoomImagem => 'Use your mouse scroll to zoom +- on your image';

  @override
  String get imagemSalvaComSucesso => 'Image successfully saved!';

  @override
  String get vocePrecisaSelecionarUmaImagem => 'You need to select an image';

  @override
  String get adicionarTamanho => 'Add size';

  @override
  String get categorias => 'Categories';

  @override
  String get addCategoria => 'To add a new category just click the button next to it';

  @override
  String get descMenu => 'Manage your products';

  @override
  String get sincronizar => 'Sync changes';

  @override
  String get tituloEditarCategoria => 'Edit your category.';

  @override
  String get tituloEditarComplemento => 'Edit your add-on.';

  @override
  String get tituloComplemento => 'Register and define your add-on rules';

  @override
  String get tituloCategoria => 'Choose a category option.';

  @override
  String get produtos => 'Products';

  @override
  String get descCategoriaProdutos => 'General products, e.g., snacks, sweets, meals, etc.';

  @override
  String get descCategoriaPizza => 'Exclusive category for pizzas';

  @override
  String get nomeDaCategoria => 'Category name*';

  @override
  String get gratuito => 'Free';

  @override
  String get extras => 'Extras';

  @override
  String get tooltipNomeComplemento => 'This field appears for the customer\nin the menu';

  @override
  String get tooltipIdentificador => 'This field appears only for you\nto help identify the add-on';

  @override
  String get identifier => 'Identifier';

  @override
  String get hintIdentifier => 'Extras_snacks_simple_01';

  @override
  String get quantidadeMinima => 'Minimum quantity';

  @override
  String get hintQuantidadeMinima => 'e.g., 0';

  @override
  String get quantidadeMaxima => 'Maximum quantity';

  @override
  String get hintQuantidadeMaxima => 'e.g., 5';

  @override
  String get validatorQuantidadeMaxima => 'Maximum quantity must be greater than the minimum quantity.';

  @override
  String get tipoDoSeletor => 'Selector type';

  @override
  String get seletorUnico => 'Single selector';

  @override
  String get descSeletorUnico => 'Allows selecting the same item only once.';

  @override
  String get seletorMultiplo => 'Multiple selector';

  @override
  String get descSeletorMultiplo => 'Allows selecting the same item multiple times.';

  @override
  String get obrigatorio => 'Required';

  @override
  String get feedbackSucessImagemDeletada => 'Image successfully deleted!';

  @override
  String get bordasEMassas => 'Edges & Doughs';

  @override
  String get tituloBordasEMassas => 'Define the options for edges and doughs for your pizzas';

  @override
  String get descSelecionarImage => 'Select a new image for your item';

  @override
  String get tituloConfirmacaoExclusao => 'Are you sure you want to delete?';

  @override
  String descConfirmacaoExclusao(Object sim) {
    return 'This action cannot be undone. Type $sim to confirm.';
  }

  @override
  String validatorConfirmacaoExclusao(Object sim) {
    return 'Type $sim in the field to confirm.';
  }

  @override
  String get pedidos => 'Orders';

  @override
  String get pedido => 'Order';

  @override
  String descComplementRequiredObrigatio(Object qty) {
    return 'Choose $qty option';
  }

  @override
  String descComplementRequiredObrigatioPlural(Object qty) {
    return 'Choose $qty options';
  }

  @override
  String descComplementObrigatio(Object qty) {
    return 'Choose at least $qty option';
  }

  @override
  String descComplementObrigatioPlural(Object qty) {
    return 'Choose at least $qty options';
  }

  @override
  String descComplementLivre(Object qty) {
    return 'Choose up to $qty option';
  }

  @override
  String descComplementLivrePlural(Object qty) {
    return 'Choose up to $qty options';
  }

  @override
  String get descComplementLivreIlimitado => 'Choose as many options as you want';

  @override
  String descComplementPizza(Object qty) {
    return 'Choose $qty flavor';
  }

  @override
  String descComplementPizzaPlural(Object qty) {
    return 'Choose $qty flavors';
  }

  @override
  String descComplementAte(Object qty) {
    return 'To $qty';
  }

  @override
  String get observacoes => 'Notes';

  @override
  String get observacoesDesc => 'Write your notes here...';

  @override
  String sabor(Object qty) {
    return '$qty Flavor';
  }

  @override
  String saborPlural(Object qty) {
    return '$qty Flavors';
  }

  @override
  String obs(Object content) {
    return 'Note: $content';
  }

  @override
  String subTotalValor(Object value) {
    return 'Subtotal $value';
  }

  @override
  String totalMaisPreco(Object value) {
    return 'Total $value';
  }

  @override
  String get pdv => 'POS';

  @override
  String get selecionarMesa => 'Select table';

  @override
  String get clienteAvulso => 'Guest customer';

  @override
  String get ok => 'Ok';

  @override
  String get ola => 'Hello';

  @override
  String get pesquisarProdutos => 'Search products';

  @override
  String get impressao => 'Print';

  @override
  String get impressoras => 'Printers';

  @override
  String get taxaEntrega => 'Delivery fee';

  @override
  String get desconto => 'Discount';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get total => 'Total';

  @override
  String get troco => 'Change';

  @override
  String get telefone => 'Phone';

  @override
  String get bairro => 'Neighborhood';

  @override
  String get credito => 'Credit';

  @override
  String get debito => 'Debit';

  @override
  String get money => 'Cash';

  @override
  String get entrega => 'Delivery';

  @override
  String get retirada => 'Pickup';

  @override
  String get consumo => 'Consume';

  @override
  String get kiosk => 'Kiosk';

  @override
  String get mesa => 'Table';

  @override
  String get trocop => 'Change for';

  @override
  String get finalizar => 'Finish';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String get inDelivery => 'In delivery';

  @override
  String get awaitingPickup => 'Awaiting pickup';

  @override
  String get awaitingDelivery => 'Awaiting delivery man';

  @override
  String get delivered => 'Delivered';

  @override
  String get canceled => 'Canceled';

  @override
  String get lost => 'Lost';

  @override
  String get segunda => 'Monday';

  @override
  String get terca => 'Tuesday';

  @override
  String get quarta => 'Wednesday';

  @override
  String get quinta => 'Thursday';

  @override
  String get sexta => 'Friday';

  @override
  String get sabado => 'Saturday';

  @override
  String get domingo => 'Sunday';

  @override
  String get faturaDisponivel => 'Invoice available';

  @override
  String get faturaVencida => 'Invoice overdue';

  @override
  String get sistemaBloqueado => 'System blocked';

  @override
  String faturaDescVencimento(Object date) {
    return 'Your invoice is due on $date';
  }

  @override
  String faturaAvisoBloqueio(Object days) {
    return 'Your system will be blocked in $days days';
  }

  @override
  String faturaDescBloqueado(Object date) {
    return 'Your system has been blocked, please settle the invoice to reactivate it.\nYour invoice was due on $date';
  }

  @override
  String get faturaDeMaisUmDia => 'Give me one more day';

  @override
  String get useWhatsappAutomatizarSistema => 'Use WhatsApp to automate your system';

  @override
  String get atualizeSeusClientesSobreOsStatusDosPedidos => 'Update your customers on order statuses, automate your WhatsApp and keep your customers informed.';

  @override
  String get abrirSeuWhatsappNoSeuCelularNaJanelaConversas => 'Open your WhatsApp on your phone, in the chats window.';

  @override
  String get toqueEm => 'Tap on';

  @override
  String get maisOpcoes => 'More options';

  @override
  String get seEstiverNoAndroid => 'if you are on Android, or';

  @override
  String get configuracoes => 'Settings';

  @override
  String get seEstiverNoIos => 'if you are on iOS.';

  @override
  String get dispositivosConectados => 'Linked devices';

  @override
  String get eEmSeguidaEm => 'and then on';

  @override
  String get conectarDispositivo => 'Link a device.';

  @override
  String get aponteSeuCelularParaEstaTelaParaEscanear => 'Point your phone at this screen to scan the QR code.';

  @override
  String get conectado => 'Connected';

  @override
  String get desconectado => 'Disconnected';

  @override
  String get data => 'Date';

  @override
  String get entregador => 'Delivery person';

  @override
  String get orderType => 'Order type';

  @override
  String get comprouAMes => 'Bought 1 month ago';

  @override
  String comprouAMeses(Object qty) {
    return 'Bought $qty months ago';
  }

  @override
  String get comprouASemana => 'Bought 1 week ago';

  @override
  String comprouASemanas(Object qty) {
    return 'Bought $qty weeks ago';
  }

  @override
  String get comprouAAno => 'Bought 1 year ago';

  @override
  String comprouAAnos(Object qty) {
    return 'Bought $qty years ago';
  }

  @override
  String get comprouADia => 'Bought 1 day ago';

  @override
  String comprouADias(Object qty) {
    return 'Bought $qty days ago';
  }

  @override
  String get comprouAHora => 'Bought 1 hour ago';

  @override
  String comprouAHoras(Object qty) {
    return 'Bought $qty hours ago';
  }

  @override
  String get comprouAPouco => 'Bought a little ago';

  @override
  String get status => 'Status';

  @override
  String get agendado => 'Scheduled';

  @override
  String get agendamentos => 'Appointments';

  @override
  String get ajustes => 'Settings';

  @override
  String get habilitarAgendamentos => 'Enable appointments';

  @override
  String get habilitarAgendamentosAmanha => 'Enable appointments tomorrow';

  @override
  String get vendasDoDia => 'Sales of the day';

  @override
  String get relatorios => 'Reports';

  @override
  String get entregadores => 'Drivers';

  @override
  String get automacoes => 'Automations';

  @override
  String get duplicar => 'Duplicate';

  @override
  String get available => 'Available';

  @override
  String get occupied => 'Occupied';

  @override
  String get reserved => 'Reserved';

  @override
  String get closingAccount => 'Closing account';

  @override
  String get cleaning => 'Cleaning';

  @override
  String get inMaintenance => 'In maintenance';

  @override
  String get fechar => 'Close';

  @override
  String get pagar => 'Pay';

  @override
  String get encerrandoSistema => 'Closing system';

  @override
  String get aguardandoPagamento => 'Waiting payment';

  @override
  String get alteracoesSalvas => 'Changes saved';

  @override
  String get necessarioReiniciar => 'It is necessary to restart';

  @override
  String get fecharSistema => 'Close system';

  @override
  String get restaurar => 'Restore';

  @override
  String get restauracaoEfetuada => 'Restoration performed';

  @override
  String get salvo => 'Saved';

  @override
  String get opsModuloPermitidoApenasTermianlPrincipal => 'Ops! \nThis module can only be accessed from the main terminal';

  @override
  String get servidorWppIniciando => 'The WhatsApp server is being initialized... \nTry again in a minute.\n if it persists, restart the system and try again.';

  @override
  String get tentarNovamente => 'Try again';

  @override
  String get conectar => 'Connect';

  @override
  String get destro => 'Right-handed';

  @override
  String get descDestro => 'Operate with the right or left hand';

  @override
  String get telefoneClienteAvulsoObrigatorio => 'Customer phone required';

  @override
  String get terminalPrincipal => 'Main terminal';

  @override
  String get contagemPedidos => 'Order count';

  @override
  String get descContagemPedidos => 'Base count for order count';

  @override
  String conflitoHorarioDiaSemana(Object weekDay) {
    return 'There was a scheduling conflict on $weekDay\nDelete the conflicting schedule and try again';
  }

  @override
  String get iniciandoDownload => 'Starting download...';

  @override
  String get downloadDriverImpressoraConcluido => 'Download completed, starting printer driver...';

  @override
  String get idioma => 'Language';

  @override
  String get copiadoParaAreaTransferencia => 'Copied to transfer area';

  @override
  String get editarHorarioFuncionamento => 'Edit working hours';

  @override
  String get abertura => 'Opening';

  @override
  String get fechamento => 'Closing';

  @override
  String get horarioAberturaDeveSerMenorQueHorarioFechamento => 'The opening time must be less than the closing time';

  @override
  String get horarioFechamentoDeveSerMaiorQueHorarioAbertura => 'The closing time must be greater than the opening time';

  @override
  String get necessarioDefinirHorarios => 'You must define opening and closing hours before saving.';

  @override
  String get descDefinirHorarios => 'Define working hours and days of the week that apply to the same rule.';

  @override
  String get horariosFuncionamento => 'Working hours';

  @override
  String get descHorariosFuncionamento => 'Define working hours here';

  @override
  String get adicionarHorario => 'Add opening hours';

  @override
  String get conectarStripe => 'Connect to Stripe';

  @override
  String get descConectarStripe => 'To receive online payments with credit card and debit card.';

  @override
  String get quantidade => 'Quantity';

  @override
  String get ativa => 'Active';

  @override
  String get canhotoEntregador => 'Part of Drive';

  @override
  String get beep => 'Beep';

  @override
  String get colunas => 'Columns';

  @override
  String get selecioneUmaImpressora => 'Select a printer';

  @override
  String get impressora => 'Printer';

  @override
  String get downloadDriverImpressora => 'Download printer driver';

  @override
  String get sincronizado => 'Synchronized';

  @override
  String get mudarCor => 'Change color';

  @override
  String get distanciaMinimaEmKm => 'Minimum distance (km)';

  @override
  String get precoMinimo => 'Minimum price';

  @override
  String get precoPorKmRodado => 'Price per km driven';

  @override
  String get exemploDistanciaMinima => 'Example: free until 1.5 km';

  @override
  String get adicionarArea => 'Add Area';

  @override
  String get descAreasEntrega => 'Define your delivery areas by drawing on the map or by km driven.';

  @override
  String get solicitarParceria => 'Request partnership';

  @override
  String get telefoneEntregador => 'Driver phone';

  @override
  String get confirmar => 'Confirm';

  @override
  String get pendente => 'Pending';

  @override
  String get parceiro => 'Partner';

  @override
  String infoFecharSistemaEmMinutos(Object minutes) {
    return 'The system will be closed in $minutes minutes';
  }

  @override
  String get fechado => 'Closed';

  @override
  String get aberto => 'Open';

  @override
  String get descDialogLogout => 'Are you sure you want to log out?';

  @override
  String get descDialogEncerrarSistema => 'Are you sure you want to close the system?';

  @override
  String get descDialogBackupCustomer => 'Are you sure you want to back up the customer?';

  @override
  String get backupRealizado => 'Backup performed.';

  @override
  String get selecioneUmaImagem => 'Select an image';

  @override
  String get pedidoCancelado => 'Order canceled';

  @override
  String get mensagemAbrirEstabelecimento => 'It\'s time to open the establishment';

  @override
  String get mensagemFecharEstabelecimento => 'It\'s time to close the establishment';

  @override
  String get infoPedidoForaPeriodoAgendamento => 'The order is out of the scheduled period';

  @override
  String get selecionarEntregador => 'Select driver';

  @override
  String get carrinho => 'Cart';

  @override
  String get cancelarPedido => 'Cancel order';

  @override
  String get imprimir => 'Print';

  @override
  String get descrevaMotivoCancelamento => 'Describe the reason for cancellation';

  @override
  String acabouProdutoX(Object product) {
    return 'Out of stock of $product';
  }

  @override
  String get voceNaoPossuiEntregadores => 'You don\'t have any drivers available';

  @override
  String get mesas => 'Tables';

  @override
  String get comandas => 'Tabs';

  @override
  String get venda => 'Sale';

  @override
  String get descEmptyStatePedido => 'You don\'t have any orders yet.';

  @override
  String get tempoEntrega => 'Delivery time';

  @override
  String get tempoRetirada => 'Pickup time';

  @override
  String get aceitarPedidosAutomaticamente => 'Accept orders automatically';

  @override
  String get buscarPedidos => 'Search orders';

  @override
  String get pendentes => 'Pending 👋';

  @override
  String get emProducao => 'In production 🔥';

  @override
  String get emRota_aguardandoRetirada => 'On the way 🛵/ awaiting pickup 📦';

  @override
  String get concluidos => 'Completed ✅';

  @override
  String get cancelados => 'Canceled ❌';

  @override
  String get perdidos => 'Lost 🚫';

  @override
  String get cep => 'Zip code';

  @override
  String get sincronizarContatos => 'Sync contacts';

  @override
  String get fazerBackup => 'Backup';

  @override
  String get importarContatos => 'Import contacts';

  @override
  String get contatosImportados => 'Contacts imported';

  @override
  String get descEmptyStateEnderecos => 'You haven\'t added any addresses yet.';

  @override
  String get retirada_consumo => 'Pickup / Consumption';

  @override
  String get infoSelecioneOuAdicioneEndereco => 'Select or add an address to continue';

  @override
  String get item => 'Item';

  @override
  String get itens => 'Items';

  @override
  String get taxaServico => 'Service fee';

  @override
  String get trocoPara => 'Change for';

  @override
  String get pagamentoRealizado => 'Payment made';

  @override
  String get pagamentos => 'Payments';

  @override
  String get voltar => 'Back';

  @override
  String get campoObrigatorio => 'Required field.';

  @override
  String get valorPagamentoMaiorQueConta => 'Payment amount greater than the bill.';

  @override
  String get relatorioPedidos => 'Order report';

  @override
  String get juntarMesas => 'Join tables';

  @override
  String get separarMesas => 'Separate tables';

  @override
  String get transferirMesa => 'Transfer table';

  @override
  String get limparMesa => 'Clean table';

  @override
  String get adicionarItens => 'Add items';

  @override
  String get fecharConta => 'Close account';

  @override
  String get nomeAmbiente => 'Environment name';

  @override
  String get adicionarAmbiente => 'Add environment';

  @override
  String get numeroMesa => 'Table number';

  @override
  String get desejaAbrirMesaParaVenda => 'Do you want to open the table for sale?';

  @override
  String get descartar => 'Discard';

  @override
  String get abrirMesa => 'Open table';

  @override
  String get transferir => 'Transfer';

  @override
  String get separar => 'Separate';

  @override
  String get adicionarComanda => 'Add tab';

  @override
  String get removerComanda => 'Remove tab';

  @override
  String get numeroObrigatorio => 'Number required';

  @override
  String get numeroInvalido => 'Invalid number';

  @override
  String get jaExiste => 'Already exists';

  @override
  String get capacidade => 'Capacity';

  @override
  String get ambiente => 'Environment';

  @override
  String get excluirMesa => 'Delete table';

  @override
  String get area => 'Area';

  @override
  String get selecioneUmaMesa => 'Select a table';

  @override
  String mesaXDisponivel(Object table) {
    return 'Table $table available';
  }

  @override
  String get agrupado => 'Grouped';

  @override
  String get conexaoReestabelecida => 'Connection reestablished';

  @override
  String get semConexaoInternet => 'No internet connection.';

  @override
  String get concluido => 'Completed';

  @override
  String get novaVersaoDisponivel => 'New version available';

  @override
  String get atualizar => 'Update';

  @override
  String get iniciandoInstalador => 'Starting installer...';

  @override
  String get sair => 'Exit';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get bemVindo => 'Welcome!';

  @override
  String get ativo => 'Active';

  @override
  String get inativo => 'Inactive';

  @override
  String get erroIniciarWpp => 'Error starting WhatsApp, try restarting the system. If the problem persists, contact support.';

  @override
  String get erroEnviarMensagem => 'Error sending message, try restarting the system. If the problem persists, contact support.';

  @override
  String get bomDia => 'Good morning';

  @override
  String get boaTarde => 'Good afternoon';

  @override
  String get boaNoite => 'Good evening';

  @override
  String get raioEntrega => 'Delivery radius';

  @override
  String get infoselecioneAreaEntregaAntesAddPonto => 'Select the delivery area before adding a point';

  @override
  String get layoutImpresssao => 'Print layout';

  @override
  String get salvoComSucesso => 'Saved successfully';

  @override
  String get trafegoPago => 'Paid Advertisements';

  @override
  String get trafegoPagoHandleErrorCode => 'Please enter only the code';

  @override
  String get preferenciasDoUsuario => 'User preferences';

  @override
  String get preferenciasDoEstabelecimento => 'Establishment preferences';

  @override
  String get resetContagemPedidos => 'Reset order count';

  @override
  String get periodo => 'Period';

  @override
  String get preferencias => 'Preferences';

  @override
  String get nunca => 'Never';

  @override
  String get diariamente => 'Daily';

  @override
  String get semanalmente => 'Weekly';

  @override
  String get mensalmente => 'Monthly';

  @override
  String get anualmente => 'Yearly';

  @override
  String get espelharHorizontalmente => 'Mirror horizontally';

  @override
  String get erroAoVerificarPagamento => 'Error checking payment. Please try again.';

  @override
  String get erroAoGerarPagamento => 'Error generating payment. Please try again.';

  @override
  String get chatbotStatesDisableTitle => 'Enable WhatsApp integration to start using the Chatbot';

  @override
  String get chatbotStatesDisableSubtitle => 'You need to enable WhatsApp integration to start using the Chatbot';

  @override
  String get chatbotStatesDisableAction => 'Enable';

  @override
  String get chatbotStatesConnectingTitle => 'Connecting';

  @override
  String get chatbotStatesConnectingSubtitle => 'Please wait a moment...';

  @override
  String get chatbotStatesConnectingAction => 'Cancel';

  @override
  String get chatbotStatesConnectedTitle => 'Connected';

  @override
  String get chatbotStatesConnectedSubtitle => 'Customize your status messages below.';

  @override
  String get chatbotStatesConnectedAction => 'Disconnect';

  @override
  String get chatbotStatesDisconnectedTitle => 'Disconnected';

  @override
  String get chatbotStatesDisconnectedSubtitle => 'You need to scan the QR code to connect WhatsApp';

  @override
  String get chatbotStatesDisconnectedAction => 'Connect';

  @override
  String get atencao => 'Attention';

  @override
  String get descWhatsappDesconectado => 'Your WhatsApp is disconnected';
}
