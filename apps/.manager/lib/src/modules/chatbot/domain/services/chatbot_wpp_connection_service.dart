import 'dart:async';

import 'package:evolution_api/evolution_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:paipfood_package/paipfood_package.dart';

class WppConnectionConstants {
  static const maxQrcodeAttempts = 10;
  static const qrcodeRetryDelay = Duration(seconds: 30);
  static const connectionTimeout = Duration(seconds: 30);
}

class ChatbotWppConnectionService extends ChangeNotifier {
  final EvolutionApi evolutionApi;
  ChatbotWppConnectionService(this.evolutionApi);

  EvoConnectionStatus? _connectionStatus;
  String? _qrcode;
  String? _instanceName;
  Stream<EventResponse>? _eventStream;
  Stream<EventResponse>? _broadcastEventStream;
  Stream<EventResponse>? get eventStream => _broadcastEventStream;

  EvoConnectionStatus? get connectionStatus => _connectionStatus;

  String? get qrcode => _qrcode;

  final Set<String> _whileQrcodeHash = {};

  Future<EvoConnectionStatus> initialize({required String instanceName}) async {
    _instanceName = instanceName;

    _connectionStatus = await getConnectionStatus(instanceName);

    await _setupWebsocketEvents(instanceName);

    _eventStream = await evolutionApi.websocket.connect(instanceName: instanceName);
    if (_eventStream != null) {
      _broadcastEventStream = _eventStream!.asBroadcastStream();
      _handleWebsocketEvents(_broadcastEventStream!);
    }
    notifyListeners();
    return _connectionStatus!;
  }

  Future<void> _setupWebsocketEvents(String instanceName) async {
    await evolutionApi.websocket.setEvents(
      instanceName: instanceName,
      events: [
        EvoEvents.CONNECTION_UPDATE,
        EvoEvents.MESSAGES_UPSERT,
        EvoEvents.QRCODE_UPDATED,
      ],
    );
  }

  Future<EvoConnectionStatus> getConnectionStatus(String instanceName) async {
    try {
      return await evolutionApi.instance.connectionStatus(instanceName: instanceName);
    } catch (e) {
      if (e is InstanceNotFound) {
        await evolutionApi.instance.create(instanceName: instanceName);
        return await evolutionApi.instance.connectionStatus(instanceName: instanceName);
      } else {
        return await _forceReconnect(instanceName: instanceName);
      }
    }
  }

  Future<EvoConnectionStatus> _forceReconnect({required String instanceName}) async {
    await evolutionApi.instance.delete(instanceName: instanceName);
    await evolutionApi.instance.create(instanceName: instanceName);
    return await evolutionApi.instance.connectionStatus(instanceName: instanceName);
  }

  Future<void> generateQrcode({required String instanceName}) async {
    final hash = Uuid().v1();
    _whileQrcodeHash.add(hash);
    int attempts = 0;

    while (_whileQrcodeHash.contains(hash) && attempts < WppConnectionConstants.maxQrcodeAttempts && _connectionStatus != EvoConnectionStatus.open) {
      attempts++;
      final qrcode = await evolutionApi.instance.connect(instanceName: instanceName);
      _qrcode = qrcode.base64;
      notifyListeners();
      await Future.delayed(WppConnectionConstants.qrcodeRetryDelay);
    }
  }

  void disposeGenerateQrcode() {
    _whileQrcodeHash.clear();
  }

  Future<void> disconnect({required String instanceName}) async {
    _whileQrcodeHash.clear();
    _eventStream = null;
    _connectionStatus = null;

    await evolutionApi.instance.logout(instanceName: instanceName);
    await evolutionApi.instance.delete(instanceName: instanceName);
    await evolutionApi.websocket.disconnect();

    notifyListeners();
  }

  void _handleWebsocketEvents(Stream<EventResponse> eventStream) {
    eventStream.listen(
      (event) {
        if (event.connectionUpdate != null) {
          _connectionStatus = event.connectionUpdate!.status;
          notifyListeners();
        }
        if (event.qrcode != null) {
          _qrcode = event.qrcode!.base64;
          notifyListeners();
        }
      },
    );
  }

  Future<void> sendTextMessage({required String phone, required String message}) async {
    if (_instanceName == null) throw StateError('Instance name not initialized');

    try {
      await evolutionApi.send.text(instanceName: _instanceName!, number: phone, message: message).timeout(
            WppConnectionConstants.connectionTimeout,
            onTimeout: () => throw TimeoutException('Timeout sending message'),
          );
    } catch (e) {
      await _handleSendMessageError();
      rethrow;
    }
  }

  Future<void> _handleSendMessageError() async {
    if (_instanceName == null) throw StateError('Instance name not initialized');

    final status = await evolutionApi.instance.connectionStatus(instanceName: _instanceName!);
    if (status == EvoConnectionStatus.close) {
      await disconnect(instanceName: _instanceName!);
    }
  }

  @override
  void dispose() {
    _whileQrcodeHash.clear();
    super.dispose();
  }
}
