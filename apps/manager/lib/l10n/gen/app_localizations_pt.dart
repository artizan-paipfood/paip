// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get wppGreetingsMessage =>
      '🤖 Olá! Eu sou o Atendente Virtual do(a) [establishment_name]. \n\nPara fazer um pedido com praticidade, clique no link abaixo: \n\n👇🏼 Toque para pedir 👇🏼 \n[link_company]';

  @override
  String get wppPending =>
      'Olá [name]👋, \nQue bom te ver por aqui! \n> Recebemos seu pedido, por favor, aguarde a confirmação. \n\n> Aqui está o link se quiser acompanhar:\n[link_order_status]';

  @override
  String get wppAccepted =>
      '[name]\nSeu pedido foi aceito!\n\nAqui está o link se quiser acompanhar:\n[link_order_status]';

  @override
  String get wppAwaitingDelivery =>
      '[name]\n> Seu pedido já está pronto. \nO entregador já está a caminho para coletar seu pedido aqui na loja!';

  @override
  String get wppAwaitingPickup =>
      'Acabou a espera! 😍\n> Seu pedido já está pronto e esperando por você!';

  @override
  String get wppDelivered =>
      'Seu pedido foi entregue\nmuito obrigado pela confiança! 😊';

  @override
  String get wppInDelivery =>
      'Temos uma ótima notícia para você!😀\n> Seu pedido saiu para entrega e logo chegará por aí, Qualquer dúvida, estamos à disposição.';

  @override
  String get wppLocalOrderMessage =>
      'Olá [name] 👋\nQue bom te ver por aqui!\n\nSeu pedido foi realizado e já está sendo preparado.✅\n\n> Logo volto com novidades, sobre o status do mesmo.\n\nAqui está o link, se quiser acompanhar:\n[link_order_status]';

  @override
  String get credit => 'Crédito';

  @override
  String get pago => 'Pago';

  @override
  String get debit => 'Débito';

  @override
  String get voucher => 'Voucher';

  @override
  String get foodTicket => 'Vale Alimentação';

  @override
  String get mealTicket => 'Vale Refeição';

  @override
  String get cash => 'Dinheiro';

  @override
  String get pix => 'Pix';

  @override
  String get email => 'Email';

  @override
  String get senha => 'Senha';

  @override
  String get entrar => 'Entrar';

  @override
  String get naoTemConta => 'Não tem conta?';

  @override
  String get registrese => 'Registe-se';

  @override
  String get esqueceuSenha => 'Esqueceu sua senha?';

  @override
  String get definicoes => 'Definições';

  @override
  String get aparencia => 'Aparência';

  @override
  String get informacoes => 'Informações';

  @override
  String get horaioFuncionamento => 'Horário de funcionamento';

  @override
  String get formasPagamento => 'Formas de pagamento';

  @override
  String get menu => 'Menu';

  @override
  String get areasEntrega => 'Áreas de entrega';

  @override
  String get cores => 'Cores';

  @override
  String get corPrimaria => 'Cor primária';

  @override
  String get descCorPrimaria =>
      'Escolha uma cor para ser a cor principal do seu app.';

  @override
  String get imagens => 'Imagens';

  @override
  String get descImagens =>
      'Escolha uma imagem de capa e um logótipo para a sua loja.';

  @override
  String get endereco => 'Endereço';

  @override
  String get adicionarEndereco => 'Adicionar endereço';

  @override
  String get enderecoInvalido => 'Endreço inválido';

  @override
  String get adicioneEnderecoEntrega => 'Adicone um endereço de entrega';

  @override
  String get selecioneEnderecoPadraoCliente =>
      'Selecione o endereço de entrega padrão do cliente';

  @override
  String get enderecoCliente => 'Endereço do cliente';

  @override
  String get selecioneClientePedido =>
      'Selecione um cliente para efetuar o pedido';

  @override
  String get selecionarCliente => 'Selecionar cliente';

  @override
  String get pesquiseClienteNomeTelefone =>
      'Pesquise seu cliente por nome ou telefone';

  @override
  String get adicionarCliente => 'Adicionar cliente';

  @override
  String get novoCliente => 'Novo cliente';

  @override
  String get nomeCompleto => 'Nome completo';

  @override
  String get descEndereco => 'Informe o endereço do seu estabelecimento';

  @override
  String get numero => 'Número';

  @override
  String get dataNascimento => 'Data de nascimento';

  @override
  String get complemento => 'Complemento';

  @override
  String get informacoesPrincipais => 'Informações Principais';

  @override
  String get descInformacoesPrincipais =>
      'Defina um nome, valor mínimo de pedidos e as informações de contacto';

  @override
  String get nomeLoja => 'Nome da Loja';

  @override
  String get descricao => 'Descrição';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get razaoSocial => 'Razão Social';

  @override
  String get pedidoMin => 'Pedido mínimo';

  @override
  String get loja => 'Loja';

  @override
  String get descLoja =>
      'Link da loja e modos de atendimento (Entrega, Recolha, Mesa, Quiosque)';

  @override
  String get linkLoja => 'Link da loja';

  @override
  String get descLinkLoja =>
      'Copie o link da sua loja e envie para seus clientes (Não é permitido alterar).';

  @override
  String get redesSociais => 'Redes Sociais';

  @override
  String get descredesSociais =>
      'Complete com o link das redes sociais do seu negócio, caso tenha';

  @override
  String get adicionar => 'Adicionar';

  @override
  String get pizzas => 'Pizzas';

  @override
  String get nome => 'Nome';

  @override
  String get preco => 'Preço';

  @override
  String get precoPromocional => 'Preço promocional';

  @override
  String get opcoes => 'Opções';

  @override
  String get opcao => 'Opção';

  @override
  String get addOpcao => 'Adicionar opção de tamanho';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get salvar => 'Salvar';

  @override
  String get complementos => 'Complementos';

  @override
  String get nomeItem => 'Informe um nome para este item';

  @override
  String get preSelecionado => 'Pré selecionado';

  @override
  String get quantidadeSabores => 'Quantidade de sabores';

  @override
  String get bordas => 'Bordas';

  @override
  String get descPageTamnhosQuantidadePizza =>
      'Defina os tamanhos e quantidade de sabores das suas pizzas.';

  @override
  String get tamanhos => 'Tamanhos';

  @override
  String get tamanhoLabel => 'Tamanho - fátias';

  @override
  String get adicionais => 'Adicionais';

  @override
  String get pizzaGrandeNome => 'Pizza grande - 8 Fátias';

  @override
  String get pizzaPequenaNome => 'Pizza pequena - individual';

  @override
  String get sabores => 'Sabores';

  @override
  String get complementoBordasDesc => 'Escolha uma borda para a sua pizza';

  @override
  String get massas => 'Massas';

  @override
  String get complementoMassasDesc => 'Escolha uma massa para a sua pizza';

  @override
  String get bar => 'Bar & Restaurante';

  @override
  String get bistro => 'Bistrô francês';

  @override
  String get buffet => 'Buffet';

  @override
  String get cafe => 'Cafeteria';

  @override
  String get italiana => 'Italiana';

  @override
  String get churrascaria => 'Churrascaria';

  @override
  String get comidaCaseira => 'Comida Caseira';

  @override
  String get fastFood => 'Fast Food';

  @override
  String get comidaSaudavel => 'Comida Saudável';

  @override
  String get creperia => 'Creperia';

  @override
  String get arabe => 'Árabe';

  @override
  String get emporio => 'Empório';

  @override
  String get mercado => 'Mercado';

  @override
  String get oriental => 'Oriental';

  @override
  String get japonesa => 'Japonesa';

  @override
  String get chinesa => 'Chinesa';

  @override
  String get frutosMar => 'Frutos do Mar';

  @override
  String get hamburgueria => 'Hamburgueria';

  @override
  String get pizzaria => 'Pizzaria';

  @override
  String get sorveteria => 'Sorveteria';

  @override
  String get padaria => 'Padaria';

  @override
  String get sanduiches => 'Sanduíches';

  @override
  String get sucos => 'Sucos & Vitaminas';

  @override
  String get farmacia => 'Farmácia';

  @override
  String get vegetariana => 'Vegetariana';

  @override
  String get vegana => 'Vegana';

  @override
  String aPartirDe(Object value) {
    return 'A partir de $value';
  }

  @override
  String get deletar => 'Deletar';

  @override
  String get editar => 'Editar';

  @override
  String get sim => 'Sim';

  @override
  String get bordaCatupiry => 'Catupiry';

  @override
  String get bordaCheddar => 'Cheddar';

  @override
  String get saborMussarela => 'Mussarela';

  @override
  String get descMussarela =>
      'Molho de tomate caseiro, mussarela, catupiry, azeitonas e orégano.';

  @override
  String get saborCalabresa => 'Calabresa';

  @override
  String get descCalabresa =>
      'Molho de tomate caseiro, calabresa, catupiry, cebola, azeitonas e orégano.';

  @override
  String get pizzaGrandeDefault => 'Pizza Grande - 8 fátias';

  @override
  String get pizzaPequenaDefault => 'Pizza Pequena - Individual';

  @override
  String get massaTradicional => 'Massa Tradicional';

  @override
  String get emptySateteProdutos => 'Voce ainda não adicionou nenhum produto.';

  @override
  String get emptySateteCategorias =>
      'Voce ainda não adicionou nenhuma categoria.';

  @override
  String get emptySateteComplementos =>
      'Voce ainda não adicionou nenhum complemento.';

  @override
  String get emptySateteSaborPizza => 'Voce ainda não adicionou nenhum sabor.';

  @override
  String adicionarSaborPizzaA(Object name) {
    return 'Adicionar sabor a $name';
  }

  @override
  String get emptyStateItens => 'Voce ainda não adicionou nenhum item.';

  @override
  String adicionarProdutoA(Object name) {
    return 'Adicionar produto a $name';
  }

  @override
  String adicionarItemA(Object name) {
    return 'Adicionar item a $name';
  }

  @override
  String get precoPromocionalDeveSerMenorQuePreco =>
      'O preço promocional deve ser menor que o preço';

  @override
  String get imagemExcluidaSucesso => 'Imagem excluida com sucesso!';

  @override
  String get deletarImagem => 'Excluir imagem';

  @override
  String get uploadImagem => 'Selecionar imagem';

  @override
  String get descZoomImagem =>
      'Utilize o scroll do seu mouse para dar zoom +- na sua imagem';

  @override
  String get imagemSalvaComSucesso => 'Imagem salva com sucesso!';

  @override
  String get vocePrecisaSelecionarUmaImagem =>
      'Você precisa selecionar uma imagem';

  @override
  String get adicionarTamanho => 'Adicionar tamanho';

  @override
  String get categorias => 'Categorias';

  @override
  String get addCategoria =>
      'Para adicionar uma nova categoria basta clicar no botão ao lado';

  @override
  String get descMenu => 'Faça a gestão dos seus produtos';

  @override
  String get sincronizar => 'Sincronizar alterações';

  @override
  String get tituloEditarCategoria => 'Edite sua categoria.';

  @override
  String get tituloEditarComplemento => 'Edite seu complemento.';

  @override
  String get tituloComplemento =>
      'Cadastre e defina as regras do seu complemento';

  @override
  String get tituloCategoria => 'Escolha uma opção de categoria.';

  @override
  String get produtos => 'Produtos';

  @override
  String get descCategoriaProdutos =>
      'Produtos no geral ex: lanches, doces, marmitas, etc...';

  @override
  String get descCategoriaPizza => 'Categoria exclusiva para pizzas';

  @override
  String get nomeDaCategoria => 'Nome da categoria*';

  @override
  String get gratuito => 'Gratuito';

  @override
  String get extras => 'Extras';

  @override
  String get tooltipNomeComplemento =>
      'Este campo aparece para o cliente\nno cardapio';

  @override
  String get tooltipIdentificador =>
      'Este campo aparece somente para você \npara ajudar a identificar o complemento';

  @override
  String get identifier => 'Identificador';

  @override
  String get hintIdentifier => 'Extras_lanches_simples_01';

  @override
  String get quantidadeMinima => 'Quantidade minima';

  @override
  String get hintQuantidadeMinima => 'Ex: 0';

  @override
  String get quantidadeMaxima => 'Quantidade maxima';

  @override
  String get hintQuantidadeMaxima => 'Ex: 5';

  @override
  String get validatorQuantidadeMaxima =>
      'Quantidade maxima deve ser maior que a quantidade minima.';

  @override
  String get tipoDoSeletor => 'Tipo do seletor';

  @override
  String get seletorUnico => 'Seletor unico';

  @override
  String get descSeletorUnico =>
      'Permite selecionar apenas uma vez o mesmo item.';

  @override
  String get seletorMultiplo => 'Seletor multiplo';

  @override
  String get descSeletorMultiplo =>
      'Permite selecionar varias vezes o mesmo item.';

  @override
  String get obrigatorio => 'Obrigatório';

  @override
  String get feedbackSucessImagemDeletada => 'Imagem deletada com sucesso!';

  @override
  String get bordasEMassas => 'Bordas & Massas';

  @override
  String get tituloBordasEMassas =>
      'Definas as opções de bordas e massa da suas pizzas';

  @override
  String get descSelecionarImage => 'Selecione uma nova imagem para o seu item';

  @override
  String get tituloConfirmacaoExclusao => 'Tem certeza que deseja excluir?';

  @override
  String descConfirmacaoExclusao(Object sim) {
    return 'Esta ação não pode ser desfeita digite $sim para confirmar.';
  }

  @override
  String validatorConfirmacaoExclusao(Object sim) {
    return 'Digite $sim no campo para confirmar.';
  }

  @override
  String get pedidos => 'Pedidos';

  @override
  String get pedido => 'Pedido';

  @override
  String descComplementRequiredObrigatio(Object qty) {
    return 'Escolha $qty opção';
  }

  @override
  String descComplementRequiredObrigatioPlural(Object qty) {
    return 'Escolha $qty opções';
  }

  @override
  String descComplementObrigatio(Object qty) {
    return 'Escolha ao menos $qty opção';
  }

  @override
  String descComplementObrigatioPlural(Object qty) {
    return 'Escolha ao menos $qty opções';
  }

  @override
  String descComplementLivre(Object qty) {
    return 'Escolha até $qty opção';
  }

  @override
  String descComplementLivrePlural(Object qty) {
    return 'Escolha até $qty opções';
  }

  @override
  String get descComplementLivreIlimitado => 'Escolha quantas opções quiser';

  @override
  String descComplementPizza(Object qty) {
    return 'Escolha $qty sabor';
  }

  @override
  String descComplementPizzaPlural(Object qty) {
    return 'Escolha $qty sabores';
  }

  @override
  String descComplementAte(Object qty) {
    return 'Até $qty';
  }

  @override
  String get observacoes => 'Observações';

  @override
  String get observacoesDesc => 'Escreva suas Observações aqui...';

  @override
  String sabor(Object qty) {
    return '$qty Sabor';
  }

  @override
  String saborPlural(Object qty) {
    return '$qty Sabores';
  }

  @override
  String obs(Object content) {
    return 'Obs: $content';
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
  String get pdv => 'Pdv';

  @override
  String get selecionarMesa => 'Selecionar mesa';

  @override
  String get clienteAvulso => 'Cliente avulso';

  @override
  String get ok => 'Ok';

  @override
  String get ola => 'Olá';

  @override
  String get pesquisarProdutos => 'Pesquisar produtos';

  @override
  String get impressao => 'Impressão';

  @override
  String get impressoras => 'Impressoras';

  @override
  String get taxaEntrega => 'Taxa de entrega';

  @override
  String get desconto => 'Desconto';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get total => 'Total';

  @override
  String get troco => 'Troco';

  @override
  String get telefone => 'Telefone';

  @override
  String get bairro => 'Bairro';

  @override
  String get credito => 'Credito';

  @override
  String get debito => 'Debito';

  @override
  String get money => 'Dinheiro';

  @override
  String get entrega => 'Entrega';

  @override
  String get retirada => 'Retirada';

  @override
  String get consumo => 'retirada_consumo';

  @override
  String get kiosk => 'Kiosk';

  @override
  String get mesa => 'Mesa';

  @override
  String get trocop => 'Troco p/';

  @override
  String get finalizar => 'Finalizar';

  @override
  String get pending => 'Pendente';

  @override
  String get accepted => 'Aceito';

  @override
  String get inDelivery => 'Em entrega';

  @override
  String get awaitingPickup => 'Aguardando retirada';

  @override
  String get awaitingDelivery => 'Aguardando entregador';

  @override
  String get delivered => 'Entregue';

  @override
  String get canceled => 'Cancelado';

  @override
  String get lost => 'Perdido';

  @override
  String get segunda => 'Segunda';

  @override
  String get terca => 'Terça';

  @override
  String get quarta => 'Quarta';

  @override
  String get quinta => 'Quinta';

  @override
  String get sexta => 'Sexta';

  @override
  String get sabado => 'Sábado';

  @override
  String get domingo => 'Domingo';

  @override
  String get faturaDisponivel => 'Fatura disponível';

  @override
  String get faturaVencida => 'Fatura vencida';

  @override
  String get sistemaBloqueado => 'Sistema bloqueado';

  @override
  String faturaDescVencimento(Object date) {
    return 'Sua fatura vence em $date';
  }

  @override
  String faturaAvisoBloqueio(Object days) {
    return 'Seu sistema será bloqueado em $days dia';
  }

  @override
  String faturaDescBloqueado(Object date) {
    return 'Seu sistema foi bloqueado, regularize a fatura para ativa-lo novamente.\nSua fatura venceu em $date';
  }

  @override
  String get faturaDeMaisUmDia => 'Me de mais um dia';

  @override
  String get useWhatsappAutomatizarSistema =>
      'Use o WhatsApp para automatizar o seu sistema';

  @override
  String get atualizeSeusClientesSobreOsStatusDosPedidos =>
      'Atualize os seus clientes sobre os estados das encomendas, automatize o seu WhatsApp e não deixe os seus clientes à espera.';

  @override
  String get abrirSeuWhatsappNoSeuCelularNaJanelaConversas =>
      'Abra o seu WhatsApp no seu telemóvel, na janela de conversas.';

  @override
  String get toqueEm => 'Toque em';

  @override
  String get maisOpcoes => 'Mais opções';

  @override
  String get seEstiverNoAndroid => 'se estiver no Android, ou em';

  @override
  String get configuracoes => 'Configurações';

  @override
  String get seEstiverNoIos => 'se estiver no iOS.';

  @override
  String get dispositivosConectados => 'Dispositivos ligados';

  @override
  String get eEmSeguidaEm => 'e, em seguida, em';

  @override
  String get conectarDispositivo => 'Ligar dispositivo.';

  @override
  String get aponteSeuCelularParaEstaTelaParaEscanear =>
      'Aponte o seu telemóvel para esta tela para digitalizar o código QR.';

  @override
  String get conectado => 'Conectado';

  @override
  String get desconectado => 'Desconectado';

  @override
  String get data => 'Data';

  @override
  String get entregador => 'Entregador';

  @override
  String get orderType => 'Tipo de pedido';

  @override
  String get comprouAMes => 'Comprou há 1 mês';

  @override
  String comprouAMeses(Object qty) {
    return 'Comprou há $qty meses';
  }

  @override
  String get comprouASemana => 'Comprou há 1 semana';

  @override
  String comprouASemanas(Object qty) {
    return 'Comprou há $qty semanas';
  }

  @override
  String get comprouAAno => 'Comprou há 1 ano';

  @override
  String comprouAAnos(Object qty) {
    return 'Comprou há $qty anos';
  }

  @override
  String get comprouADia => 'Comprou há 1 dia';

  @override
  String comprouADias(Object qty) {
    return 'Comprou há $qty dias';
  }

  @override
  String get comprouAHora => 'Comprou há 1 hora';

  @override
  String comprouAHoras(Object qty) {
    return 'Comprou há $qty horas';
  }

  @override
  String get comprouAPouco => 'Comprou pouco';

  @override
  String get status => 'Status';

  @override
  String get agendado => 'Agendado';

  @override
  String get agendamentos => 'Agendamentos';

  @override
  String get ajustes => 'Ajustes';

  @override
  String get habilitarAgendamentos => 'Habilitar agendamentos';

  @override
  String get habilitarAgendamentosAmanha =>
      'Habilitar agendamentos para amanha';

  @override
  String get vendasDoDia => 'Vendas do dia';

  @override
  String get relatorios => 'Relatórios';

  @override
  String get entregadores => 'Entregadores';

  @override
  String get automacoes => 'Automações';

  @override
  String get duplicar => 'Duplicar';

  @override
  String get available => 'Livre';

  @override
  String get occupied => 'Ocupada';

  @override
  String get reserved => 'Reservada';

  @override
  String get closingAccount => 'Fechando conta';

  @override
  String get cleaning => 'Limpando';

  @override
  String get inMaintenance => 'Em manutenção';

  @override
  String get fechar => 'Fechar';

  @override
  String get pagar => 'Pagar';

  @override
  String get encerrandoSistema => 'Encerrando o sistema';

  @override
  String get aguardandoPagamento => 'Aguardando pagamento';

  @override
  String get alteracoesSalvas => 'Alterações salvas';

  @override
  String get necessarioReiniciar => 'Necessário reiniciar o sistema';

  @override
  String get fecharSistema => 'Fechar sistema';

  @override
  String get restaurar => 'Restaurar';

  @override
  String get restauracaoEfetuada => 'Restauração efetuada';

  @override
  String get salvo => 'Salvo';

  @override
  String get opsModuloPermitidoApenasTermianlPrincipal =>
      'Ops! \nEste modulo so pode ser acessado pelo terminal principal';

  @override
  String get servidorWppIniciando =>
      '\'O Servidor do whatsapp está sendo inicializado... \nTente novamente daqui um minuto.\n se persistir reinicie o sistema e tente novamente.';

  @override
  String get tentarNovamente => 'Tentar novamente';

  @override
  String get conectar => 'Conectar';

  @override
  String get destro => 'Destro';

  @override
  String get descDestro => 'Opera com a mão direita ou esquerda';

  @override
  String get telefoneClienteAvulsoObrigatorio =>
      'Telefone do cliente avulso obrigatório';

  @override
  String get terminalPrincipal => 'Terminal Principal';

  @override
  String get contagemPedidos => 'Contagem de pedidos';

  @override
  String get descContagemPedidos => 'Numero base para contagem de pedidos';

  @override
  String conflitoHorarioDiaSemana(Object weekDay) {
    return 'Houve um conflito de horário na $weekDay\nDelete o horário conflitante e tente novamente';
  }

  @override
  String get iniciandoDownload => 'Iniciando download...';

  @override
  String get downloadDriverImpressoraConcluido =>
      'Download concluído, iniciando driver...';

  @override
  String get idioma => 'Idioma';

  @override
  String get copiadoParaAreaTransferencia =>
      'Copiado para area de transferência';

  @override
  String get editarHorarioFuncionamento => 'Editar horario de funcionamento';

  @override
  String get abertura => 'Abertura';

  @override
  String get fechamento => 'Fechamento';

  @override
  String get horarioAberturaDeveSerMenorQueHorarioFechamento =>
      'O horário de abertura deve ser menor que o de fechamento';

  @override
  String get horarioFechamentoDeveSerMaiorQueHorarioAbertura =>
      'O horário de fechamneto deve ser maior que o de abertura';

  @override
  String get necessarioDefinirHorarios =>
      'Você precisa definir horario de abertura,horario de fechamento e dias da semana, antes de salvar.';

  @override
  String get descDefinirHorarios =>
      'Defina seus horários de funcionamento e dias da semana que se aplica a mesma regra.';

  @override
  String get horariosFuncionamento => 'Horários de funcionamento';

  @override
  String get descHorariosFuncionamento =>
      'Defina seus horários de funcionamento aqui';

  @override
  String get adicionarHorario => 'Adicionar horário';

  @override
  String get conectarStripe => 'Conecte-se ao Stripe';

  @override
  String get descConectarStripe =>
      'Para receber pagamentos online com cartão de crédito e débito.';

  @override
  String get quantidade => 'Quantidade';

  @override
  String get ativa => 'Ativa';

  @override
  String get canhotoEntregador => 'Canhoto entregador';

  @override
  String get beep => 'Beep';

  @override
  String get colunas => 'Colunas';

  @override
  String get selecioneUmaImpressora => 'Selecione uma impressora';

  @override
  String get impressora => 'Impressora';

  @override
  String get downloadDriverImpressora => 'Download driver impressora';

  @override
  String get sincronizado => 'Sincronizado';

  @override
  String get mudarCor => 'Mudar cor';

  @override
  String get distanciaMinimaEmKm => 'Distancia minima (km)';

  @override
  String get precoMinimo => 'Preco minimo';

  @override
  String get precoPorKmRodado => 'Preco por km rodado';

  @override
  String get exemploDistanciaMinima => 'Exemplo: Grátis até (km)';

  @override
  String get adicionarArea => 'Adicionar area';

  @override
  String get descAreasEntrega =>
      'Defina suas áreas de entrega por bairro desenhando no mapa ou por km rodado.';

  @override
  String get solicitarParceria => 'Solicitar parceria';

  @override
  String get telefoneEntregador => 'Telefone do entregador';

  @override
  String get confirmar => 'Confirmar';

  @override
  String get pendente => 'Pendente';

  @override
  String get parceiro => 'Parceiro';

  @override
  String infoFecharSistemaEmMinutos(Object minutes) {
    return 'O Sistema será encerrado automaticamente em $minutes minutos';
  }

  @override
  String get fechado => 'Fechado';

  @override
  String get aberto => 'Aberto';

  @override
  String get descDialogLogout => 'Tem certeza que deseja sair?';

  @override
  String get descDialogEncerrarSistema =>
      'Tem certeza que deseja encerrar o sistema?';

  @override
  String get descDialogBackupCustomer =>
      'Deseja fazer backup dos seus clientes?';

  @override
  String get backupRealizado => 'Backup realizado com sucesso.';

  @override
  String get selecioneUmaImagem => 'Selecione uma imagem';

  @override
  String get pedidoCancelado => 'Pedido cancelado';

  @override
  String get mensagemAbrirEstabelecimento =>
      'Já está na hora de abrir o estabelecimento';

  @override
  String get mensagemFecharEstabelecimento =>
      'Já está na hora de fechar o estabelecimento';

  @override
  String get infoPedidoForaPeriodoAgendamento =>
      'Pedido fora do periodo de agendamento, tente novamente mais próximo do horário.';

  @override
  String get selecionarEntregador => 'Selecionar entregador';

  @override
  String get carrinho => 'Carrinho';

  @override
  String get cancelarPedido => 'Cancelar pedido';

  @override
  String get imprimir => 'Imprimir';

  @override
  String get descrevaMotivoCancelamento => 'Descreva o motivo do cancelamento';

  @override
  String acabouProdutoX(Object product) {
    return 'Acabou o produto $product';
  }

  @override
  String get voceNaoPossuiEntregadores =>
      'Você não possui entregadores disponíveis';

  @override
  String get mesas => 'Mesas';

  @override
  String get comandas => 'Comandas';

  @override
  String get venda => 'Venda';

  @override
  String get descEmptyStatePedido => 'Nenhum pedido por aqui.';

  @override
  String get tempoEntrega => 'Tempo de entrega';

  @override
  String get tempoRetirada => 'Tempo de retirada';

  @override
  String get aceitarPedidosAutomaticamente => 'Aceitar pedidos automaticamente';

  @override
  String get buscarPedidos => 'Buscar pedidos';

  @override
  String get pendentes => 'Pendentes 👋';

  @override
  String get emProducao => 'Em produção 🔥';

  @override
  String get emRota_aguardandoRetirada => 'Em rota 🛵/ aguardando retirada 📦';

  @override
  String get concluidos => 'Concluídos ✅';

  @override
  String get cancelados => 'Cancelados ❌';

  @override
  String get perdidos => 'Perdidos 🚫';

  @override
  String get cep => 'CEP';

  @override
  String get sincronizarContatos => 'Sincronizar contatos';

  @override
  String get fazerBackup => 'Fazer backup';

  @override
  String get importarContatos => 'Importar contatos';

  @override
  String get contatosImportados => 'Contatos importados';

  @override
  String get descEmptyStateEnderecos => 'Nenhum endereço cadastrado.';

  @override
  String get retirada_consumo => 'Retirada / Consumo';

  @override
  String get infoSelecioneOuAdicioneEndereco =>
      'Selecione ou adicione um endereço para continuar';

  @override
  String get item => 'Item';

  @override
  String get itens => 'Itens';

  @override
  String get taxaServico => 'Taxa de serviço';

  @override
  String get trocoPara => 'Troco para';

  @override
  String get pagamentoRealizado => 'Pagamento realizado';

  @override
  String get pagamentos => 'Pagamentos';

  @override
  String get voltar => 'Voltar';

  @override
  String get campoObrigatorio => 'Campo obrigatório.';

  @override
  String get valorPagamentoMaiorQueConta =>
      'Valor do pagamento maior que a conta.';

  @override
  String get relatorioPedidos => 'Relatório de pedidos';

  @override
  String get juntarMesas => 'Juntar mesas';

  @override
  String get separarMesas => 'Separar mesas';

  @override
  String get transferirMesa => 'Transferir mesa';

  @override
  String get limparMesa => 'Limpar mesa';

  @override
  String get adicionarItens => 'Adicionar itens';

  @override
  String get fecharConta => 'Fechar conta';

  @override
  String get nomeAmbiente => 'Nome do ambiente';

  @override
  String get adicionarAmbiente => 'Adicionar ambiente';

  @override
  String get numeroMesa => 'Número da mesa';

  @override
  String get desejaAbrirMesaParaVenda => 'Deseja abrir a mesa para venda?';

  @override
  String get descartar => 'Descartar';

  @override
  String get abrirMesa => 'Abrir mesa';

  @override
  String get transferir => 'Transferir';

  @override
  String get separar => 'Separar';

  @override
  String get adicionarComanda => 'Adicionar comanda';

  @override
  String get removerComanda => 'Remover comanda';

  @override
  String get numeroObrigatorio => 'Número obrigatório';

  @override
  String get numeroInvalido => 'Número inválido';

  @override
  String get jaExiste => 'Já existe';

  @override
  String get capacidade => 'Capacidade';

  @override
  String get ambiente => 'Ambiente';

  @override
  String get excluirMesa => 'Excluir mesa';

  @override
  String get area => 'Área';

  @override
  String get selecioneUmaMesa => 'Selecione uma mesa';

  @override
  String mesaXDisponivel(Object table) {
    return 'Mesa $table disponível';
  }

  @override
  String get agrupado => 'Agrupado';

  @override
  String get conexaoReestabelecida => 'Conexão reestabelecida';

  @override
  String get semConexaoInternet => 'Sem conexão com a internet.';

  @override
  String get concluido => 'Concluído';

  @override
  String get novaVersaoDisponivel => 'Nova versão disponível';

  @override
  String get atualizar => 'Atualizar';

  @override
  String get iniciandoInstalador => 'Iniciando instalador...';

  @override
  String get sair => 'Sair';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get bemVindo => 'Bem-vindo!';

  @override
  String get ativo => 'Ativo';

  @override
  String get inativo => 'Inativo';

  @override
  String get erroIniciarWpp =>
      'Erro ao iniciar o whatsapp, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.';

  @override
  String get erroEnviarMensagem =>
      'Erro ao enviar mensagem, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.';

  @override
  String get bomDia => 'Bom dia';

  @override
  String get boaTarde => 'Boa tarde';

  @override
  String get boaNoite => 'Boa noite';

  @override
  String get raioEntrega => 'Raio de entrega';

  @override
  String get infoselecioneAreaEntregaAntesAddPonto =>
      'Selecione uma área de entrega antes de adicionar um ponto';

  @override
  String get layoutImpresssao => 'Layout de impressão';

  @override
  String get salvoComSucesso => 'Salvo com sucesso!';

  @override
  String get trafegoPago => 'Anúncios pagos';

  @override
  String get trafegoPagoHandleErrorCode =>
      'Por favor adicione somente o codigo';

  @override
  String get preferenciasDoUsuario => 'Preferências do usuário';

  @override
  String get preferenciasDoEstabelecimento => 'Preferências do estabelecimento';

  @override
  String get resetContagemPedidos => 'Reset contagem de pedidos';

  @override
  String get periodo => 'Período';

  @override
  String get preferencias => 'Preferências';

  @override
  String get nunca => 'Nunca';

  @override
  String get diariamente => 'Diariamente';

  @override
  String get semanalmente => 'Semanalmente';

  @override
  String get mensalmente => 'Mensalmente';

  @override
  String get anualmente => 'Anualmente';

  @override
  String get espelharHorizontalmente => 'Espelhar horizontalmente';

  @override
  String get erroAoVerificarPagamento =>
      'Erro ao verificar o pagamento. Tente novamente.';

  @override
  String get erroAoGerarPagamento =>
      'Erro ao gerar o pagamento. Tente novamente.';

  @override
  String get chatbotStatesDisableTitle =>
      'Habilite a integração com o WhatsApp para começar a usar o Chatbot';

  @override
  String get chatbotStatesDisableSubtitle =>
      'Você precisa habilitar a integração com o WhatsApp para começar a usar o Chatbot';

  @override
  String get chatbotStatesDisableAction => 'Habilitar';

  @override
  String get chatbotStatesConnectingTitle => 'Conectando';

  @override
  String get chatbotStatesConnectingSubtitle => 'Aguarde alguns instantes...';

  @override
  String get chatbotStatesConnectingAction => 'Cancelar';

  @override
  String get chatbotStatesConnectedTitle => 'Conectado';

  @override
  String get chatbotStatesConnectedSubtitle =>
      'Personalize suas mensagens de status a baixo.';

  @override
  String get chatbotStatesConnectedAction => 'Desconectar';

  @override
  String get chatbotStatesDisconnectedTitle => 'Desconectado';

  @override
  String get chatbotStatesDisconnectedSubtitle =>
      'Você precisa escanear o QRCode para conectar o WhatsApp';

  @override
  String get chatbotStatesDisconnectedAction => 'Conectar';

  @override
  String get atencao => 'Atenção';

  @override
  String get descWhatsappDesconectado => 'Seu whatsapp está desconectado';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get wppGreetingsMessage =>
      '🤖 Olá! Eu sou o Atendente Virtual do(a) [establishment_name]. \n\nPara fazer um pedido com praticidade, clique no link abaixo: \n\n👇🏼 Toque para pedir 👇🏼 \n[link_company]';

  @override
  String get wppPending =>
      'Olá [name]👋, \nQue bom te ver por aqui! \n> Recebemos seu pedido, por favor, aguarde a confirmação. \n\n> Aqui está o link se quiser acompanhar:\n[link_order_status]';

  @override
  String get wppAccepted =>
      '[name]\nSeu pedido foi aceito!\n\nAqui está o link se quiser acompanhar:\n[link_order_status]';

  @override
  String get wppAwaitingDelivery =>
      '[name]\n> Seu pedido já está pronto. \nO entregador já está a caminho para coletar seu pedido aqui na loja!';

  @override
  String get wppAwaitingPickup =>
      'Acabou a espera! 😍\n> Seu pedido já está pronto e esperando por você!';

  @override
  String get wppDelivered =>
      'Seu pedido foi entregue\nmuito obrigado pela confiança! 😊';

  @override
  String get wppInDelivery =>
      'Temos uma ótima notícia para você!😀\n> Seu pedido saiu para entrega e logo chegará por aí, Qualquer dúvida, estamos à disposição.';

  @override
  String get wppLocalOrderMessage =>
      'Olá [name] 👋\nQue bom te ver por aqui!\n\nSeu pedido foi realizado e já está sendo preparado.✅\n\n> Logo volto com novidades, sobre o status do mesmo.\n\nAqui está o link, se quiser acompanhar:\n[link_order_status]';

  @override
  String get credit => 'Crédito';

  @override
  String get pago => 'Pago';

  @override
  String get debit => 'Débito';

  @override
  String get voucher => 'Voucher';

  @override
  String get foodTicket => 'Vale Alimentação';

  @override
  String get mealTicket => 'Vale Refeição';

  @override
  String get cash => 'Dinheiro';

  @override
  String get pix => 'Pix';

  @override
  String get email => 'Email';

  @override
  String get senha => 'Senha';

  @override
  String get entrar => 'Entrar';

  @override
  String get naoTemConta => 'Não tem conta?';

  @override
  String get registrese => 'Registe-se';

  @override
  String get esqueceuSenha => 'Esqueceu sua senha?';

  @override
  String get definicoes => 'Definições';

  @override
  String get aparencia => 'Aparência';

  @override
  String get informacoes => 'Informações';

  @override
  String get horaioFuncionamento => 'Horário de funcionamento';

  @override
  String get formasPagamento => 'Formas de pagamento';

  @override
  String get menu => 'Menu';

  @override
  String get areasEntrega => 'Áreas de entrega';

  @override
  String get cores => 'Cores';

  @override
  String get corPrimaria => 'Cor primária';

  @override
  String get descCorPrimaria =>
      'Escolha uma cor para ser a cor principal do seu app.';

  @override
  String get imagens => 'Imagens';

  @override
  String get descImagens =>
      'Escolha uma imagem de capa e um logótipo para a sua loja.';

  @override
  String get endereco => 'Endereço';

  @override
  String get adicionarEndereco => 'Adicionar endereço';

  @override
  String get enderecoInvalido => 'Endreço inválido';

  @override
  String get adicioneEnderecoEntrega => 'Adicone um endereço de entrega';

  @override
  String get selecioneEnderecoPadraoCliente =>
      'Selecione o endereço de entrega padrão do cliente';

  @override
  String get enderecoCliente => 'Endereço do cliente';

  @override
  String get selecioneClientePedido =>
      'Selecione um cliente para efetuar o pedido';

  @override
  String get selecionarCliente => 'Selecionar cliente';

  @override
  String get pesquiseClienteNomeTelefone =>
      'Pesquise seu cliente por nome ou telefone';

  @override
  String get adicionarCliente => 'Adicionar cliente';

  @override
  String get novoCliente => 'Novo cliente';

  @override
  String get nomeCompleto => 'Nome completo';

  @override
  String get descEndereco => 'Informe o endereço do seu estabelecimento';

  @override
  String get numero => 'Número';

  @override
  String get dataNascimento => 'Data de nascimento';

  @override
  String get complemento => 'Complemento';

  @override
  String get informacoesPrincipais => 'Informações Principais';

  @override
  String get descInformacoesPrincipais =>
      'Defina um nome, valor mínimo de pedidos e as informações de contacto';

  @override
  String get nomeLoja => 'Nome da Loja';

  @override
  String get descricao => 'Descrição';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get razaoSocial => 'Razão Social';

  @override
  String get pedidoMin => 'Pedido mínimo';

  @override
  String get loja => 'Loja';

  @override
  String get descLoja =>
      'Link da loja e modos de atendimento (Entrega, Recolha, Mesa, Quiosque)';

  @override
  String get linkLoja => 'Link da loja';

  @override
  String get descLinkLoja =>
      'Copie o link da sua loja e envie para seus clientes (Não é permitido alterar).';

  @override
  String get redesSociais => 'Redes Sociais';

  @override
  String get descredesSociais =>
      'Complete com o link das redes sociais do seu negócio, caso tenha';

  @override
  String get adicionar => 'Adicionar';

  @override
  String get pizzas => 'Pizzas';

  @override
  String get nome => 'Nome';

  @override
  String get preco => 'Preço';

  @override
  String get precoPromocional => 'Preço promocional';

  @override
  String get opcoes => 'Opções';

  @override
  String get opcao => 'Opção';

  @override
  String get addOpcao => 'Adicionar opção de tamanho';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get salvar => 'Salvar';

  @override
  String get complementos => 'Complementos';

  @override
  String get nomeItem => 'Informe um nome para este item';

  @override
  String get preSelecionado => 'Pré selecionado';

  @override
  String get quantidadeSabores => 'Quantidade de sabores';

  @override
  String get bordas => 'Bordas';

  @override
  String get descPageTamnhosQuantidadePizza =>
      'Defina os tamanhos e quantidade de sabores das suas pizzas.';

  @override
  String get tamanhos => 'Tamanhos';

  @override
  String get tamanhoLabel => 'Tamanho - fátias';

  @override
  String get adicionais => 'Adicionais';

  @override
  String get pizzaGrandeNome => 'Pizza grande - 8 Fátias';

  @override
  String get pizzaPequenaNome => 'Pizza pequena - individual';

  @override
  String get sabores => 'Sabores';

  @override
  String get complementoBordasDesc => 'Escolha uma borda para a sua pizza';

  @override
  String get massas => 'Massas';

  @override
  String get complementoMassasDesc => 'Escolha uma massa para a sua pizza';

  @override
  String get bar => 'Bar & Restaurante';

  @override
  String get bistro => 'Bistrô francês';

  @override
  String get buffet => 'Buffet';

  @override
  String get cafe => 'Cafeteria';

  @override
  String get italiana => 'Italiana';

  @override
  String get churrascaria => 'Churrascaria';

  @override
  String get comidaCaseira => 'Comida Caseira';

  @override
  String get fastFood => 'Fast Food';

  @override
  String get comidaSaudavel => 'Comida Saudável';

  @override
  String get creperia => 'Creperia';

  @override
  String get arabe => 'Árabe';

  @override
  String get emporio => 'Empório';

  @override
  String get mercado => 'Mercado';

  @override
  String get oriental => 'Oriental';

  @override
  String get japonesa => 'Japonesa';

  @override
  String get chinesa => 'Chinesa';

  @override
  String get frutosMar => 'Frutos do Mar';

  @override
  String get hamburgueria => 'Hamburgueria';

  @override
  String get pizzaria => 'Pizzaria';

  @override
  String get sorveteria => 'Sorveteria';

  @override
  String get padaria => 'Padaria';

  @override
  String get sanduiches => 'Sanduíches';

  @override
  String get sucos => 'Sucos & Vitaminas';

  @override
  String get farmacia => 'Farmácia';

  @override
  String get vegetariana => 'Vegetariana';

  @override
  String get vegana => 'Vegana';

  @override
  String aPartirDe(Object value) {
    return 'A partir de $value';
  }

  @override
  String get deletar => 'Deletar';

  @override
  String get editar => 'Editar';

  @override
  String get sim => 'Sim';

  @override
  String get bordaCatupiry => 'Catupiry';

  @override
  String get bordaCheddar => 'Cheddar';

  @override
  String get saborMussarela => 'Mussarela';

  @override
  String get descMussarela =>
      'Molho de tomate caseiro, mussarela, catupiry, azeitonas e orégano.';

  @override
  String get saborCalabresa => 'Calabresa';

  @override
  String get descCalabresa =>
      'Molho de tomate caseiro, calabresa, catupiry, cebola, azeitonas e orégano.';

  @override
  String get pizzaGrandeDefault => 'Pizza Grande - 8 fátias';

  @override
  String get pizzaPequenaDefault => 'Pizza Pequena - Individual';

  @override
  String get massaTradicional => 'Massa Tradicional';

  @override
  String get emptySateteProdutos => 'Voce ainda não adicionou nenhum produto.';

  @override
  String get emptySateteCategorias =>
      'Voce ainda não adicionou nenhuma categoria.';

  @override
  String get emptySateteComplementos =>
      'Voce ainda não adicionou nenhum complemento.';

  @override
  String get emptySateteSaborPizza => 'Voce ainda não adicionou nenhum sabor.';

  @override
  String adicionarSaborPizzaA(Object name) {
    return 'Adicionar sabor a $name';
  }

  @override
  String get emptyStateItens => 'Voce ainda não adicionou nenhum item.';

  @override
  String adicionarProdutoA(Object name) {
    return 'Adicionar produto a $name';
  }

  @override
  String adicionarItemA(Object name) {
    return 'Adicionar item a $name';
  }

  @override
  String get precoPromocionalDeveSerMenorQuePreco =>
      'O preço promocional deve ser menor que o preço';

  @override
  String get imagemExcluidaSucesso => 'Imagem excluida com sucesso!';

  @override
  String get deletarImagem => 'Excluir imagem';

  @override
  String get uploadImagem => 'Selecionar imagem';

  @override
  String get descZoomImagem =>
      'Utilize o scroll do seu mouse para dar zoom +- na sua imagem';

  @override
  String get imagemSalvaComSucesso => 'Imagem salva com sucesso!';

  @override
  String get vocePrecisaSelecionarUmaImagem =>
      'Você precisa selecionar uma imagem';

  @override
  String get adicionarTamanho => 'Adicionar tamanho';

  @override
  String get categorias => 'Categorias';

  @override
  String get addCategoria =>
      'Para adicionar uma nova categoria basta clicar no botão ao lado';

  @override
  String get descMenu => 'Faça a gestão dos seus produtos';

  @override
  String get sincronizar => 'Sincronizar alterações';

  @override
  String get tituloEditarCategoria => 'Edite sua categoria.';

  @override
  String get tituloEditarComplemento => 'Edite seu complemento.';

  @override
  String get tituloComplemento =>
      'Cadastre e defina as regras do seu complemento';

  @override
  String get tituloCategoria => 'Escolha uma opção de categoria.';

  @override
  String get produtos => 'Produtos';

  @override
  String get descCategoriaProdutos =>
      'Produtos no geral ex: lanches, doces, marmitas, etc...';

  @override
  String get descCategoriaPizza => 'Categoria exclusiva para pizzas';

  @override
  String get nomeDaCategoria => 'Nome da categoria*';

  @override
  String get gratuito => 'Gratuito';

  @override
  String get extras => 'Extras';

  @override
  String get tooltipNomeComplemento =>
      'Este campo aparece para o cliente\nno cardapio';

  @override
  String get tooltipIdentificador =>
      'Este campo aparece somente para você \npara ajudar a identificar o complemento';

  @override
  String get identifier => 'Identificador';

  @override
  String get hintIdentifier => 'Extras_lanches_simples_01';

  @override
  String get quantidadeMinima => 'Quantidade minima';

  @override
  String get hintQuantidadeMinima => 'Ex: 0';

  @override
  String get quantidadeMaxima => 'Quantidade maxima';

  @override
  String get hintQuantidadeMaxima => 'Ex: 5';

  @override
  String get validatorQuantidadeMaxima =>
      'Quantidade maxima deve ser maior que a quantidade minima.';

  @override
  String get tipoDoSeletor => 'Tipo do seletor';

  @override
  String get seletorUnico => 'Seletor unico';

  @override
  String get descSeletorUnico =>
      'Permite selecionar apenas uma vez o mesmo item.';

  @override
  String get seletorMultiplo => 'Seletor multiplo';

  @override
  String get descSeletorMultiplo =>
      'Permite selecionar varias vezes o mesmo item.';

  @override
  String get obrigatorio => 'Obrigatório';

  @override
  String get feedbackSucessImagemDeletada => 'Imagem deletada com sucesso!';

  @override
  String get bordasEMassas => 'Bordas & Massas';

  @override
  String get tituloBordasEMassas =>
      'Definas as opções de bordas e massa da suas pizzas';

  @override
  String get descSelecionarImage => 'Selecione uma nova imagem para o seu item';

  @override
  String get tituloConfirmacaoExclusao => 'Tem certeza que deseja excluir?';

  @override
  String descConfirmacaoExclusao(Object sim) {
    return 'Esta ação não pode ser desfeita digite $sim para confirmar.';
  }

  @override
  String validatorConfirmacaoExclusao(Object sim) {
    return 'Digite $sim no campo para confirmar.';
  }

  @override
  String get pedidos => 'Pedidos';

  @override
  String get pedido => 'Pedido';

  @override
  String descComplementRequiredObrigatio(Object qty) {
    return 'Escolha $qty opção';
  }

  @override
  String descComplementRequiredObrigatioPlural(Object qty) {
    return 'Escolha $qty opções';
  }

  @override
  String descComplementObrigatio(Object qty) {
    return 'Escolha ao menos $qty opção';
  }

  @override
  String descComplementObrigatioPlural(Object qty) {
    return 'Escolha ao menos $qty opções';
  }

  @override
  String descComplementLivre(Object qty) {
    return 'Escolha até $qty opção';
  }

  @override
  String descComplementLivrePlural(Object qty) {
    return 'Escolha até $qty opções';
  }

  @override
  String get descComplementLivreIlimitado => 'Escolha quantas opções quiser';

  @override
  String descComplementPizza(Object qty) {
    return 'Escolha $qty sabor';
  }

  @override
  String descComplementPizzaPlural(Object qty) {
    return 'Escolha $qty sabores';
  }

  @override
  String descComplementAte(Object qty) {
    return 'Até $qty';
  }

  @override
  String get observacoes => 'Observações';

  @override
  String get observacoesDesc => 'Escreva suas Observações aqui...';

  @override
  String sabor(Object qty) {
    return '$qty Sabor';
  }

  @override
  String saborPlural(Object qty) {
    return '$qty Sabores';
  }

  @override
  String obs(Object content) {
    return 'Obs: $content';
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
  String get pdv => 'Pdv';

  @override
  String get selecionarMesa => 'Selecionar mesa';

  @override
  String get clienteAvulso => 'Cliente avulso';

  @override
  String get ok => 'Ok';

  @override
  String get ola => 'Olá';

  @override
  String get pesquisarProdutos => 'Pesquisar produtos';

  @override
  String get impressao => 'Impressão';

  @override
  String get impressoras => 'Impressoras';

  @override
  String get taxaEntrega => 'Taxa de entrega';

  @override
  String get desconto => 'Desconto';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get total => 'Total';

  @override
  String get troco => 'Troco';

  @override
  String get telefone => 'Telefone';

  @override
  String get bairro => 'Bairro';

  @override
  String get credito => 'Credito';

  @override
  String get debito => 'Debito';

  @override
  String get money => 'Dinheiro';

  @override
  String get entrega => 'Entrega';

  @override
  String get retirada => 'Retirada';

  @override
  String get consumo => 'Consumo';

  @override
  String get kiosk => 'Kiosk';

  @override
  String get mesa => 'Mesa';

  @override
  String get trocop => 'Troco p/';

  @override
  String get finalizar => 'Finalizar';

  @override
  String get pending => 'Pendente';

  @override
  String get accepted => 'Aceito';

  @override
  String get inDelivery => 'Em entrega';

  @override
  String get awaitingPickup => 'Aguardando retirada';

  @override
  String get awaitingDelivery => 'Aguardando entregador';

  @override
  String get delivered => 'Entregue';

  @override
  String get canceled => 'Cancelado';

  @override
  String get lost => 'Perdido';

  @override
  String get segunda => 'Segunda';

  @override
  String get terca => 'Terça';

  @override
  String get quarta => 'Quarta';

  @override
  String get quinta => 'Quinta';

  @override
  String get sexta => 'Sexta';

  @override
  String get sabado => 'Sábado';

  @override
  String get domingo => 'Domingo';

  @override
  String get faturaDisponivel => 'Fatura disponível';

  @override
  String get faturaVencida => 'Fatura vencida';

  @override
  String get sistemaBloqueado => 'Sistema bloqueado';

  @override
  String faturaDescVencimento(Object date) {
    return 'Sua fatura vence em $date';
  }

  @override
  String faturaAvisoBloqueio(Object days) {
    return 'Seu sistema será bloqueado em $days dia';
  }

  @override
  String faturaDescBloqueado(Object date) {
    return 'Seu sistema foi bloqueado, regularize a fatura para ativa-lo novamente.\nSua fatura venceu em $date';
  }

  @override
  String get faturaDeMaisUmDia => 'Me de mais um dia';

  @override
  String get useWhatsappAutomatizarSistema =>
      'Use o WhatsApp para automatizar seu sistema';

  @override
  String get atualizeSeusClientesSobreOsStatusDosPedidos =>
      'Atualize seus clientes sobre os status dos pedidos, deixe seu WhatsApp no automático e não deixe seu cliente esperando.';

  @override
  String get abrirSeuWhatsappNoSeuCelularNaJanelaConversas =>
      'Abra seu WhatsApp no seu celular, na janela de conversas.';

  @override
  String get toqueEm => 'Toque em';

  @override
  String get maisOpcoes => 'Mais opções';

  @override
  String get seEstiverNoAndroid => 'se estiver no Android, ou em';

  @override
  String get configuracoes => 'Configurações';

  @override
  String get seEstiverNoIos => 'se estiver no iOS.';

  @override
  String get dispositivosConectados => 'Dispositivos conectados';

  @override
  String get eEmSeguidaEm => 'e, em seguida, em';

  @override
  String get conectarDispositivo => 'Conectar dispositivo.';

  @override
  String get aponteSeuCelularParaEstaTelaParaEscanear =>
      'Aponte seu celular para esta tela para escanear o QR code.';

  @override
  String get conectado => 'Conectado';

  @override
  String get desconectado => 'Desconectado';

  @override
  String get data => 'Data';

  @override
  String get entregador => 'Entregador';

  @override
  String get orderType => 'Tipo de pedido';

  @override
  String get comprouAMes => 'Comprou há 1 mês';

  @override
  String comprouAMeses(Object qty) {
    return 'Comprou há $qty meses';
  }

  @override
  String get comprouASemana => 'Comprou há 1 semana';

  @override
  String comprouASemanas(Object qty) {
    return 'Comprou há $qty semanas';
  }

  @override
  String get comprouAAno => 'Comprou há 1 ano';

  @override
  String comprouAAnos(Object qty) {
    return 'Comprou há $qty anos';
  }

  @override
  String get comprouADia => 'Comprou há 1 dia';

  @override
  String comprouADias(Object qty) {
    return 'Comprou há $qty dias';
  }

  @override
  String get comprouAHora => 'Comprou há 1 hora';

  @override
  String comprouAHoras(Object qty) {
    return 'Comprou há $qty horas';
  }

  @override
  String get comprouAPouco => 'Comprou há pouco';

  @override
  String get status => 'Status';

  @override
  String get agendado => 'Agendado';

  @override
  String get agendamentos => 'Agendamentos';

  @override
  String get ajustes => 'Ajustes';

  @override
  String get habilitarAgendamentos => 'Habilitar agendamentos';

  @override
  String get habilitarAgendamentosAmanha =>
      'Habilitar agendamentos para amanhã';

  @override
  String get vendasDoDia => 'Vendas do dia';

  @override
  String get relatorios => 'Relatórios';

  @override
  String get entregadores => 'Entregadores';

  @override
  String get automacoes => 'Automações';

  @override
  String get duplicar => 'Duplicar';

  @override
  String get available => 'Livre';

  @override
  String get occupied => 'Ocupada';

  @override
  String get reserved => 'Reservada';

  @override
  String get closingAccount => 'Fechando conta';

  @override
  String get cleaning => 'Limpando';

  @override
  String get inMaintenance => 'Em manutenção';

  @override
  String get fechar => 'Fechar';

  @override
  String get pagar => 'Pagar';

  @override
  String get encerrandoSistema => 'Encerrando o sistema';

  @override
  String get aguardandoPagamento => 'Aguardando pagamento';

  @override
  String get alteracoesSalvas => 'Alterações salvas com sucesso';

  @override
  String get necessarioReiniciar => 'Necessário reiniciar o sistema';

  @override
  String get fecharSistema => 'Fechar sistema';

  @override
  String get restaurar => 'Restaurar';

  @override
  String get restauracaoEfetuada => 'Restauração efetuada';

  @override
  String get salvo => 'Salvo';

  @override
  String get opsModuloPermitidoApenasTermianlPrincipal =>
      'Ops! \nEste modulo so pode ser acessado pelo terminal principal';

  @override
  String get servidorWppIniciando =>
      'O Servidor do whatsapp está sendo inicializado... \nTente novamente daqui um minuto.\n se persistir reinicie o sistema e tente novamente.';

  @override
  String get tentarNovamente => 'Tentar novamente';

  @override
  String get conectar => 'Conectar';

  @override
  String get destro => 'Destro';

  @override
  String get descDestro => 'Opera com a mão direita ou esquerda';

  @override
  String get telefoneClienteAvulsoObrigatorio =>
      'Telefone do cliente avulso obrigatório';

  @override
  String get terminalPrincipal => 'Terminal Principal';

  @override
  String get contagemPedidos => 'Contagem de pedidos';

  @override
  String get descContagemPedidos => 'Numero base para contagem de pedidos';

  @override
  String conflitoHorarioDiaSemana(Object weekDay) {
    return 'Houve um conflito de horário na $weekDay\nDelete o horário conflitante e tente novamente';
  }

  @override
  String get iniciandoDownload => 'Iniciando download...';

  @override
  String get downloadDriverImpressoraConcluido =>
      'Download concluído, iniciando driver...';

  @override
  String get idioma => 'Idioma';

  @override
  String get copiadoParaAreaTransferencia =>
      'Copiado para area de transferência';

  @override
  String get editarHorarioFuncionamento => 'Editar horario de funcionamento';

  @override
  String get abertura => 'Abertura';

  @override
  String get fechamento => 'Fechamento';

  @override
  String get horarioAberturaDeveSerMenorQueHorarioFechamento =>
      'O horário de abertura deve ser menor que o de fechamento';

  @override
  String get horarioFechamentoDeveSerMaiorQueHorarioAbertura =>
      'O horário de fechamneto deve ser maior que o de abertura';

  @override
  String get necessarioDefinirHorarios =>
      'Você precisa definir horario de abertura,horario de fechamento e dias da semana, antes de salvar.';

  @override
  String get descDefinirHorarios =>
      'Defina seus horários de funcionamento e dias da semana que se aplica a mesma regra.';

  @override
  String get horariosFuncionamento => 'Horários de funcionamento';

  @override
  String get descHorariosFuncionamento =>
      'Defina seus horários de funcionamento aqui';

  @override
  String get adicionarHorario => 'Adicionar horário';

  @override
  String get conectarStripe => 'Conecte-se ao Stripe';

  @override
  String get descConectarStripe =>
      'Para receber pagamentos online com cartão de crédito e débito.';

  @override
  String get quantidade => 'Quantidade';

  @override
  String get ativa => 'Ativa';

  @override
  String get canhotoEntregador => 'Canhoto entregador';

  @override
  String get beep => 'Beep';

  @override
  String get colunas => 'Colunas';

  @override
  String get selecioneUmaImpressora => 'Selecione uma impressora';

  @override
  String get impressora => 'Impressora';

  @override
  String get downloadDriverImpressora => 'Download driver impressora';

  @override
  String get sincronizado => 'Sincronizado';

  @override
  String get mudarCor => 'Mudar cor';

  @override
  String get distanciaMinimaEmKm => 'Distancia mínima (km)';

  @override
  String get precoMinimo => 'Preco minimo';

  @override
  String get precoPorKmRodado => 'Preco por km rodado';

  @override
  String get exemploDistanciaMinima => 'Exemplo: Grátis até (km)';

  @override
  String get adicionarArea => 'Adicionar area';

  @override
  String get descAreasEntrega =>
      'Defina suas áreas de entrega por bairro desenhando no mapa ou por km rodado.';

  @override
  String get solicitarParceria => 'Solicitar parceria';

  @override
  String get telefoneEntregador => 'Telefone do entregador';

  @override
  String get confirmar => 'Confirmar';

  @override
  String get pendente => 'Pendente';

  @override
  String get parceiro => 'Parceiro';

  @override
  String infoFecharSistemaEmMinutos(Object minutes) {
    return 'O Sistema será encerrado automaticamente em $minutes minutos';
  }

  @override
  String get fechado => 'Fechado';

  @override
  String get aberto => 'Aberto';

  @override
  String get descDialogLogout => 'Tem certeza que deseja sair?';

  @override
  String get descDialogEncerrarSistema =>
      'Tem certeza que deseja encerrar o sistema?';

  @override
  String get descDialogBackupCustomer =>
      'Deseja fazer backup dos seus clientes?';

  @override
  String get backupRealizado => 'Backup realizado com sucesso.';

  @override
  String get selecioneUmaImagem => 'Selecione uma imagem';

  @override
  String get pedidoCancelado => 'Pedido cancelado';

  @override
  String get mensagemAbrirEstabelecimento =>
      'Já está na hora de abrir o estabelecimento';

  @override
  String get mensagemFecharEstabelecimento =>
      'Já está na hora de fechar o estabelecimento';

  @override
  String get infoPedidoForaPeriodoAgendamento =>
      'Pedido fora do periodo de agendamento, tente novamente mais próximo do horário.';

  @override
  String get selecionarEntregador => 'Selecionar entregador';

  @override
  String get carrinho => 'Carrinho';

  @override
  String get cancelarPedido => 'Cancelar pedido';

  @override
  String get imprimir => 'Imprimir';

  @override
  String get descrevaMotivoCancelamento => 'Descreva o motivo do cancelamento';

  @override
  String acabouProdutoX(Object product) {
    return 'Acabou o produto $product';
  }

  @override
  String get voceNaoPossuiEntregadores =>
      'Você não possui entregadores disponíveis';

  @override
  String get mesas => 'Mesas';

  @override
  String get comandas => 'Comandas';

  @override
  String get venda => 'Venda';

  @override
  String get descEmptyStatePedido => 'Nenhum pedido por aqui.';

  @override
  String get tempoEntrega => 'Tempo de entrega';

  @override
  String get tempoRetirada => 'Tempo de retirada';

  @override
  String get aceitarPedidosAutomaticamente => 'Aceitar pedidos automaticamente';

  @override
  String get buscarPedidos => 'Buscar pedidos';

  @override
  String get pendentes => 'Pendentes 👋';

  @override
  String get emProducao => 'Em produção 🔥';

  @override
  String get emRota_aguardandoRetirada => 'Em rota 🛵/ aguardando retirada 📦';

  @override
  String get concluidos => 'Concluídos ✅';

  @override
  String get cancelados => 'Cancelados ❌';

  @override
  String get perdidos => 'Perdidos 🚫';

  @override
  String get cep => 'CEP';

  @override
  String get sincronizarContatos => 'Sincronizar contatos';

  @override
  String get fazerBackup => 'Fazer backup';

  @override
  String get importarContatos => 'Importar contatos';

  @override
  String get contatosImportados => 'Contatos importados';

  @override
  String get descEmptyStateEnderecos => 'Nenhum endereço cadastrado.';

  @override
  String get retirada_consumo => 'Retirada / Consumo';

  @override
  String get infoSelecioneOuAdicioneEndereco =>
      'Selecione ou adicione um endereço para continuar';

  @override
  String get item => 'Item';

  @override
  String get itens => 'Itens';

  @override
  String get taxaServico => 'Taxa de serviço';

  @override
  String get trocoPara => 'Troco para';

  @override
  String get pagamentoRealizado => 'Pagamento realizado';

  @override
  String get pagamentos => 'Pagamentos';

  @override
  String get voltar => 'Voltar';

  @override
  String get campoObrigatorio => 'Campo obrigatório.';

  @override
  String get valorPagamentoMaiorQueConta =>
      'Valor do pagamento maior que a conta.';

  @override
  String get relatorioPedidos => 'Relatório de pedidos';

  @override
  String get juntarMesas => 'Juntar mesas';

  @override
  String get separarMesas => 'Separar mesas';

  @override
  String get transferirMesa => 'Transferir mesa';

  @override
  String get limparMesa => 'Limpar mesa';

  @override
  String get adicionarItens => 'Adicionar itens';

  @override
  String get fecharConta => 'Fechar conta';

  @override
  String get nomeAmbiente => 'Nome do ambiente';

  @override
  String get adicionarAmbiente => 'Adicionar ambiente';

  @override
  String get numeroMesa => 'Número da mesa';

  @override
  String get desejaAbrirMesaParaVenda => 'Deseja abrir a mesa para venda?';

  @override
  String get descartar => 'Descartar';

  @override
  String get abrirMesa => 'Abrir mesa';

  @override
  String get transferir => 'Transferir';

  @override
  String get separar => 'Separar';

  @override
  String get adicionarComanda => 'Adicionar comanda';

  @override
  String get removerComanda => 'Remover comanda';

  @override
  String get numeroObrigatorio => 'Número obrigatório';

  @override
  String get numeroInvalido => 'Número inválido';

  @override
  String get jaExiste => 'Já existe';

  @override
  String get capacidade => 'Capacidade';

  @override
  String get ambiente => 'Ambiente';

  @override
  String get excluirMesa => 'Excluir mesa';

  @override
  String get area => 'Área';

  @override
  String get selecioneUmaMesa => 'Selecione uma mesa';

  @override
  String mesaXDisponivel(Object table) {
    return 'Mesa $table disponível';
  }

  @override
  String get agrupado => 'Agrupado';

  @override
  String get conexaoReestabelecida => 'Conexão reestabelecida';

  @override
  String get semConexaoInternet => 'Sem conexão com a internet.';

  @override
  String get concluido => 'Concluído';

  @override
  String get novaVersaoDisponivel => 'Nova versão disponível';

  @override
  String get atualizar => 'Atualizar';

  @override
  String get iniciandoInstalador => 'Iniciando instalador...';

  @override
  String get sair => 'Sair';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get bemVindo => 'Bem-vindo!';

  @override
  String get ativo => 'Ativo';

  @override
  String get inativo => 'Inativo';

  @override
  String get erroIniciarWpp =>
      'Erro ao iniciar o whatsapp, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.';

  @override
  String get erroEnviarMensagem =>
      'Erro ao enviar mensagem, tente reiniciar o sistema, se o problema persistir entre em contato com o suporte.';

  @override
  String get bomDia => 'Bom dia';

  @override
  String get boaTarde => 'Boa tarde';

  @override
  String get boaNoite => 'Boa noite';

  @override
  String get raioEntrega => 'Raio de entrega';

  @override
  String get infoselecioneAreaEntregaAntesAddPonto =>
      'Selecione uma área de entrega antes de adicionar um ponto';

  @override
  String get layoutImpresssao => 'Layout de impressão';

  @override
  String get salvoComSucesso => 'Salvo com sucesso!';

  @override
  String get trafegoPago => 'Anúncios pagos';

  @override
  String get trafegoPagoHandleErrorCode =>
      'Por favor adicione somente o codigo';

  @override
  String get preferenciasDoUsuario => 'Preferências do usuário';

  @override
  String get preferenciasDoEstabelecimento => 'Preferências do estabelecimento';

  @override
  String get resetContagemPedidos => 'Reset contagem de pedidos';

  @override
  String get periodo => 'Período';

  @override
  String get preferencias => 'Preferências';

  @override
  String get nunca => 'Nunca';

  @override
  String get diariamente => 'Diariamente';

  @override
  String get semanalmente => 'Semanalmente';

  @override
  String get mensalmente => 'Mensalmente';

  @override
  String get anualmente => 'Anualmente';

  @override
  String get espelharHorizontalmente => 'Espelhar horizontalmente';

  @override
  String get erroAoVerificarPagamento =>
      'Erro ao verificar o pagamento. Tente novamente.';

  @override
  String get erroAoGerarPagamento =>
      'Erro ao gerar o pagamento. Tente novamente.';

  @override
  String get chatbotStatesDisableTitle =>
      'Habilite a integração com o WhatsApp para começar a usar o Chatbot';

  @override
  String get chatbotStatesDisableSubtitle =>
      'Você precisa habilitar a integração com o WhatsApp para começar a usar o Chatbot';

  @override
  String get chatbotStatesDisableAction => 'Habilitar';

  @override
  String get chatbotStatesConnectingTitle => 'Conectando';

  @override
  String get chatbotStatesConnectingSubtitle => 'Aguarde alguns instantes...';

  @override
  String get chatbotStatesConnectingAction => 'Cancelar';

  @override
  String get chatbotStatesConnectedTitle => 'Conectado';

  @override
  String get chatbotStatesConnectedSubtitle =>
      'Personalize suas mensagens de status a baixo.';

  @override
  String get chatbotStatesConnectedAction => 'Desconectar';

  @override
  String get chatbotStatesDisconnectedTitle => 'Desconectado';

  @override
  String get chatbotStatesDisconnectedSubtitle =>
      'Você precisa escanear o QRCode para conectar o WhatsApp';

  @override
  String get chatbotStatesDisconnectedAction => 'Conectar';

  @override
  String get atencao => 'Atenção';

  @override
  String get descWhatsappDesconectado => 'Seu whatsapp está desconectado';
}
