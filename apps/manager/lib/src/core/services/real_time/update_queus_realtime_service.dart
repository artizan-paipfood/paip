import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:io';
import 'package:core_flutter/core_flutter.dart';
import 'package:manager/src/core/services/real_time/add_bill_realtime_usecase.dart';
import 'package:manager/src/core/services/real_time/add_order_command_realtime_usecase.dart';
import 'package:manager/src/core/services/real_time/add_table_realtime_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/check_orders_in_queue_and_add_to_listusecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/periodic_establishment_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/send_order_to_store_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/update_orders_in_list_usecase.dart';
import 'package:manager/src/modules/order/domain/services/log_service.dart';
import 'package:realtime_client/realtime_client.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:window_manager/window_manager.dart';

class UpdateQueusRealtimeService {
  final DataSource dataSource;
  final SendOrderToStoreUsecase sendOrderToStoreUsecase;
  final CheckOrdersInQueueAndAddToStoreUsecase checkOrdersInQueueAndAddToStoreUsecase;
  final PeriodicEstablishmentUsecase periodicEstablishmentUsecase;
  final UpdateOrdersInListUsecase updateOrderInListUsecase;
  final AddOrderCommandRealtimeUsecase addOrderCommandRealtimeUsecase;
  final AddTableRealtimeUsecase addTableRealtimeUsecase;
  final AddBillRealtimeUsecase addBillRealtimeUsecase;

  UpdateQueusRealtimeService({
    required this.dataSource,
    required this.sendOrderToStoreUsecase,
    required this.checkOrdersInQueueAndAddToStoreUsecase,
    required this.periodicEstablishmentUsecase,
    required this.updateOrderInListUsecase,
    required this.addOrderCommandRealtimeUsecase,
    required this.addTableRealtimeUsecase,
    required this.addBillRealtimeUsecase,
  }) {
    periodicEstablishmentUsecase.call();
    // 🚀 CORREÇÃO: Iniciar conexão automaticamente
    _initializeConnection();
  }

  final LogService logService = LogService();

  // 🔄 VARIÁVEIS DE CONTROLE DE CONEXÃO
  RealtimeClient? _client;
  RealtimeChannel? channel;
  RealtimeSubscribeStatus? _status;

  // 🔄 VARIÁVEIS DE RECONEXÃO
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  Timer? _pollingTimer;
  Timer? _networkCheckTimer;

  int _reconnectAttempts = 0;
  bool _isConnecting = false;
  bool _isDisposed = false;
  bool _hasNetworkConnection = true;

  // ⚙️ CONFIGURAÇÕES
  static const int _maxReconnectDelay = 300; // 5 minutos máximo
  static const int _heartbeatInterval = 30; // 30 segundos
  static const int _pollingInterval = 90; // 90 segundos (reduzido de 5 minutos!)
  static const int _networkCheckInterval = 30; // 15 segundos

  // 🚀 INICIALIZAÇÃO AUTOMÁTICA
  Future<void> _initializeConnection() async {
    await Future.delayed(1.seconds); // Aguarda inicialização completa
    await connect();
    _startHeartbeat();
    _startPolling();
    _startNetworkMonitoring();
  }

  // 🌐 MONITORAMENTO DE REDE
  void _startNetworkMonitoring() {
    _networkCheckTimer?.cancel();
    _networkCheckTimer = Timer.periodic(_networkCheckInterval.seconds, (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

      _checkNetworkConnection();
    });
  }

  Future<void> _checkNetworkConnection() async {
    try {
      // Tenta fazer ping no Google DNS para verificar conectividade
      final result = await InternetAddress.lookup('google.com');
      final bool hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (!_hasNetworkConnection && hasConnection) {
        log('🌐 REDE RESTAURADA! Tentando reconectar...', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '🌐 REDE RESTAURADA! Tentando reconectar...');
        _hasNetworkConnection = true;
        // Força reconexão imediata quando a rede volta
        Future.delayed(1.seconds, () => connect());
      } else if (_hasNetworkConnection && !hasConnection) {
        log('🚫 PERDA DE CONEXÃO DE REDE DETECTADA', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '🚫 PERDA DE CONEXÃO DE REDE DETECTADA');
        _hasNetworkConnection = false;
      }
    } catch (e) {
      if (_hasNetworkConnection) {
        log('🚫 ERRO NA VERIFICAÇÃO DE REDE: $e', name: 'UpdateQueusRealtimeService');
        _hasNetworkConnection = false;
      }
    }
  }

  // 🔄 CLIENTE REALTIME COM MELHOR CONFIGURAÇÃO
  RealtimeClient _createClient() {
    final endPoint = '${Env.supaBaseUrl.replaceAll('https', 'wss')}/realtime/v1';
    return RealtimeClient(
      endPoint,
      params: {
        'apikey': Env.supaApiKey,
        'Authorization': 'Bearer ${AuthNotifier.instance.auth.accessToken!}',
      },
      // 🔧 LOGGER ATIVADO PARA DEPURAÇÃO
      logger: (kind, msg, data) {
        log('REALTIME[$kind]: $msg ${data ?? ''}', name: 'UpdateQueusRealtimeService');
      },
    );
  }

  // 💓 SISTEMA DE HEARTBEAT
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval.seconds, (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

      _checkConnectionHealth();
    });
  }

  void _checkConnectionHealth() {
    if (channel == null || _status != RealtimeSubscribeStatus.subscribed) {
      log('🚨 HEARTBEAT: Conexão não saudável - Status: $_status', name: 'UpdateQueusRealtimeService');
      _scheduleReconnect();
    } else {
      log('💓 HEARTBEAT: Conexão saudável', name: 'UpdateQueusRealtimeService');
    }
  }

  // 🔄 POLLING MELHORADO
  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(_pollingInterval.seconds, (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

      if (establishmentProvider.value.isOpen) {
        checkOrdersInQueueAndAddToStoreUsecase.call(
          currentOrderNumber: establishmentProvider.value.currentOrderNumber,
          establishmentId: establishmentProvider.value.id,
        );
      }
    });
  }

  // 🔄 RECONEXÃO COM BACKOFF EXPONENCIAL E TENTATIVAS ILIMITADAS
  void _scheduleReconnect() {
    if (_isDisposed || _isConnecting) return;

    _reconnectTimer?.cancel();

    // Se não há conexão de rede, aguarda mais tempo
    final baseDelay = _hasNetworkConnection ? 2 : 10;

    // Backoff exponencial: 2^attempt * baseDelay segundos, máximo 5 minutos
    final delay = math
        .min(
          math.pow(2, _reconnectAttempts) * baseDelay,
          _maxReconnectDelay,
        )
        .toInt();

    _reconnectAttempts++;

    final networkStatus = _hasNetworkConnection ? '✅' : '🚫';
    log('🔄 AGENDANDO RECONEXÃO: Tentativa #$_reconnectAttempts em ${delay}s $networkStatus', name: 'UpdateQueusRealtimeService');

    logService.insertLog(content: '🔄 AGENDANDO RECONEXÃO: Tentativa #$_reconnectAttempts em ${delay}s $networkStatus');

    _reconnectTimer = Timer(delay.seconds, () {
      if (!_isDisposed) {
        connect();
      }
    });
  }

  // 🚀 MÉTODO DE CONEXÃO MELHORADO
  Future<void> connect() async {
    if (_isDisposed || _isConnecting) return;

    // Não tenta conectar se não há rede
    if (!_hasNetworkConnection) {
      log('🚫 SEM CONEXÃO DE REDE - Aguardando...', name: 'UpdateQueusRealtimeService');
      _scheduleReconnect();
      return;
    }

    _isConnecting = true;

    try {
      // 🧹 Limpar conexão anterior
      await _cleanup();

      if (isWindows) await windowManager.focus();

      // 🔄 VERIFICAR E RENOVAR TOKEN SE NECESSÁRIO
      await _refreshTokenIfNeeded();

      await Future.delayed(500.ms);

      // 🔗 Criar nova conexão
      _client = _createClient();

      channel = _client!
          .channel('pedidos_realtime_${establishmentProvider.value.id}')
          .onPostgresChanges(
            schema: 'public',
            table: 'update_queus',
            event: PostgresChangeEvent.all,
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'establishment_id',
              value: establishmentProvider.value.id,
            ),
            callback: _handleRealtimeMessage,
          )
          .subscribe(_handleConnectionStatus);

      log('🚀 TENTATIVA DE CONEXÃO INICIADA', name: 'UpdateQueusRealtimeService');
    } catch (e, stackTrace) {
      log('❌ ERRO NA CONEXÃO: $e', name: 'UpdateQueusRealtimeService');
      logService.insertLog(content: '❌ ERRO NA CONEXÃO: $e');
      _scheduleReconnect();
    } finally {
      _isConnecting = false;
    }
  }

  // 🔄 RENOVAÇÃO AUTOMÁTICA DE TOKEN
  Future<void> _refreshTokenIfNeeded() async {
    try {
      final currentAuth = AuthNotifier.instance.auth;
      if (currentAuth.accessToken == null) {
        log('⚠️ TOKEN AUSENTE - Tentando renovar', name: 'UpdateQueusRealtimeService');
        // Aqui você pode implementar a lógica de renovação específica do seu app
        // Por exemplo, chamar um método de refresh token
      }

      // Verificar se o token está próximo do vencimento (opcional)
      // Se necessário, implementar lógica de verificação de expiração
    } catch (e) {
      log('⚠️ ERRO AO RENOVAR TOKEN: $e', name: 'UpdateQueusRealtimeService');
    }
  }

  // 📨 HANDLER DE MENSAGENS REALTIME
  void _handleRealtimeMessage(payload) {
    try {
      final map = payload.newRecord;
      final data = map['data'];

      log('📨 MENSAGEM RECEBIDA: ${map['table']}', name: 'UpdateQueusRealtimeService');

      switch (map['table']) {
        case OrderModel.box:
          if (map.entries.length > 1) {
            sendOrderToStoreUsecase.call(data);
          } else {
            updateOrderInListUsecase.call(data);
          }
          break;

        case TableModel.box:
          addTableRealtimeUsecase.call(data);
          break;

        case OrderCommandModel.box:
          addOrderCommandRealtimeUsecase.call(data);
          break;

        case BillModel.box:
          addBillRealtimeUsecase.call(data);
          break;

        case OrderModel.boxReactivity:
          updateOrderInListUsecase.call(data);
          break;

        case OrderModel.boxList:
          updateOrderInListUsecase.call(data);
          break;

        case EstablishmentModel.box:
          establishmentProvider.value = EstablishmentModel.fromMap(data);
          break;

        default:
          log('⚠️ TIPO DE MENSAGEM DESCONHECIDO: ${map['table']}', name: 'UpdateQueusRealtimeService');
          break;
      }
    } catch (e, stackTrace) {
      log('❌ ERRO AO PROCESSAR MENSAGEM: $e', name: 'UpdateQueusRealtimeService');
      logService.insertLog(content: '❌ ERRO AO PROCESSAR MENSAGEM: $e');
    }
  }

  // 🔌 HANDLER DE STATUS DE CONEXÃO
  void _handleConnectionStatus(RealtimeSubscribeStatus status, dynamic error) {
    _status = status;

    switch (status) {
      case RealtimeSubscribeStatus.subscribed:
        _reconnectAttempts = 0; // Reset contador
        log('✅ CONECTADO COM SUCESSO!', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '✅ REAL-TIME CONECTADO COM SUCESSO');
        break;

      case RealtimeSubscribeStatus.timedOut:
        log('⏱️ TIMEOUT NA CONEXÃO - ERROR: $error', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '⏱️ TIMEOUT NA CONEXÃO - ERROR: $error');
        _scheduleReconnect();
        break;

      case RealtimeSubscribeStatus.closed:
        log('🔌 CONEXÃO FECHADA - ERROR: $error', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '🔌 CONEXÃO FECHADA - ERROR: $error');
        _scheduleReconnect();
        break;

      case RealtimeSubscribeStatus.channelError:
        log('❌ ERRO NO CANAL - ERROR: $error', name: 'UpdateQueusRealtimeService');
        logService.insertLog(content: '❌ ERRO NO CANAL - ERROR: $error');
        _scheduleReconnect();
        break;
    }
  }

  // 🧹 LIMPEZA DE RECURSOS
  Future<void> _cleanup() async {
    try {
      await channel?.unsubscribe();
      _client?.disconnect();
    } catch (e) {
      log('⚠️ ERRO NA LIMPEZA: $e', name: 'UpdateQueusRealtimeService');
    }

    channel = null;
    _client = null;
  }

  // 🔄 MÉTODO PÚBLICO PARA VERIFICAR/FORÇAR RECONEXÃO
  Future<void> verifyReconnect() async {
    if (_status != RealtimeSubscribeStatus.subscribed) {
      log('🔄 VERIFICAÇÃO: Forçando reconexão', name: 'UpdateQueusRealtimeService');
      await connect();
    } else {
      log('✅ VERIFICAÇÃO: Conexão já ativa', name: 'UpdateQueusRealtimeService');
    }
  }

  // 🛑 DISPOSE PARA LIMPEZA COMPLETA
  Future<void> dispose() async {
    _isDisposed = true;

    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();
    _pollingTimer?.cancel();
    _networkCheckTimer?.cancel();

    await _cleanup();

    log('🛑 SERVIÇO FINALIZADO', name: 'UpdateQueusRealtimeService');
  }

  // 📊 GETTER PARA STATUS DA CONEXÃO
  bool get isConnected => _status == RealtimeSubscribeStatus.subscribed;

  // 📊 GETTER PARA TENTATIVAS DE RECONEXÃO
  int get reconnectAttempts => _reconnectAttempts;

  // 🌐 GETTER PARA STATUS DA REDE
  bool get hasNetworkConnection => _hasNetworkConnection;

  bool isTable({required Map map, required String table}) {
    return map['table'] == table;
  }
}
