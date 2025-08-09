import 'dart:async';
import 'package:artizan_ui/artizan_ui.dart';
import 'package:evolution_api/evolution_api.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/extensions/context.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/modules/chatbot/domain/repositories/chatbot_messages_repository.dart';
import 'package:manager/src/modules/chatbot/domain/usecases/chatbot_wpp_messages_usecase.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chatbot_wpp_states.dart';
import 'package:manager/src/modules/chatbot/domain/services/chatbot_wpp_connection_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotConstants {
  static const messageCleanupDuration = Duration(hours: 24);
  static const toastDuration = Duration(minutes: 90);
  static const reconnectInterval = Duration(seconds: 10);
}

class ChatbotViewmodel extends ChangeNotifier {
  final ChatbotMessagesRepository chatbotMessagesRepository;
  final ChatbotWppConnectionService wppConnectionService;
  final EstablishmentPreferencesStore establishmentPreferencesStore;
  final EstablishmentPreferencesRepository establishmentPreferencesRepo;
  final ChatbotWppMessagesUsecase wppMessagesUsecase;

  ChatbotViewmodel({
    required this.chatbotMessagesRepository,
    required this.wppConnectionService,
    required this.establishmentPreferencesStore,
    required this.establishmentPreferencesRepo,
    required this.wppMessagesUsecase,
  }) {
    _initializeMessageCleanup();
  }

  bool _shouldShowConnectionToast = true;
  Timer? _cleanupTimer;
  Timer? _toastTimer;
  StreamSubscription<EventResponse>? _eventSubscription;

  final Map<String, DateTime> _messagesReceived = {};

  List<MessageModel> get messages => chatbotMessagesRepository.messages;

  EstablishmentPreferencesEntity? get preferences => establishmentPreferencesStore.establishmentPreference;

  bool get wppEnabled => preferences?.enableWhatsapp ?? true;

  void _initializeMessageCleanup() {
    _cleanupTimer = Timer.periodic(ChatbotConstants.messageCleanupDuration, (_) {
      _cleanupOldMessages();
    });
  }

  void _cleanupOldMessages() {
    final now = DateTime.now();
    _messagesReceived.removeWhere((_, timestamp) => now.difference(timestamp) > ChatbotConstants.messageCleanupDuration);
  }

  Future<void> toggleWppEnabled({required bool value, required String establishmentId}) async {
    establishmentPreferencesStore.set(preferences!.copyWith(enableWhatsapp: value));
    await establishmentPreferencesRepo.upsert(establishmentPreferences: preferences!);
    if (value) await _connect(establishmentId: establishmentId);
    if (value == false) await _disconnect(establishmentId: establishmentId);
    notifyListeners();
  }

  Future<void> _connect({required String establishmentId}) async {
    await wppConnectionService.initialize(instanceName: establishmentId);
    _listenWppEvents(wppConnectionService.eventStream!);
  }

  Future<void> _disconnect({required String establishmentId}) async {
    try {
      // Cancelar o listen do stream primeiro
      await _eventSubscription?.cancel();
      _eventSubscription = null;

      await wppConnectionService.disconnect(instanceName: establishmentId);
      _messagesReceived.clear();
    } catch (e) {
      debugPrint('Erro ao desconectar WhatsApp: $e');
      rethrow;
    }
  }

  late final listenables = Listenable.merge([wppConnectionService, this]);

  Future<void> updateChangedMessages({required List<MessageModel> messages}) async {
    await chatbotMessagesRepository.upsert(messages: messages);
  }

  Future<List<MessageModel>> initialize({required String establishmentId}) async {
    final messages = await chatbotMessagesRepository.getAllByEstablishmentId(establishmentId: establishmentId);

    if (wppEnabled) await _connect(establishmentId: establishmentId);

    return messages;
  }

  void _listenWppEvents(Stream<EventResponse> eventStream) {
    // Cancelar subscription anterior se existir
    _eventSubscription?.cancel();

    _eventSubscription = eventStream.listen((event) {
      if (event.message != null && event.message!.fromMe == false && event.message?.messageTypeEnum == MessageType.conversation && event.message?.participant == null) {
        final bool isNewMessage = _messagesReceived[event.message!.remoteJid] == null;
        if (isNewMessage) {
          _messagesReceived[event.message!.remoteJid] = DateTime.now();
          wppMessagesUsecase.sendMessageWellcome(phone: event.message!.remoteJid);
        }
      }
    });
  }

  Future<void> disconnect({required String establishmentId}) async {
    await _disconnect(establishmentId: establishmentId);
  }

  Future<void> verifyConnection({required String establishmentId}) async {
    if (wppConnectionService.connectionStatus == null) {
      await wppConnectionService.initialize(instanceName: establishmentId);
    }
  }

  ChatbotWppStatesVariant get wppStates {
    if (wppEnabled == false) return ChatbotWppStatesVariant.disable;

    return switch (wppConnectionService.connectionStatus) {
      EvoConnectionStatus.open => ChatbotWppStatesVariant.connected,
      EvoConnectionStatus.connecting => ChatbotWppStatesVariant.disconnected,
      EvoConnectionStatus.close => ChatbotWppStatesVariant.disconnected,
      null => ChatbotWppStatesVariant.disconnected,
    };
  }

  Future<void> handleListStatusToaster(BuildContext context) async {
    _toastTimer?.cancel();

    Future.delayed(const Duration(seconds: 5), () {
      if (wppConnectionService.connectionStatus != EvoConnectionStatus.open && wppEnabled) {
        if (context.mounted) _showToast(context);
      }
    });

    _toastTimer = Timer.periodic(ChatbotConstants.reconnectInterval, (timer) {
      if (wppConnectionService.connectionStatus != EvoConnectionStatus.open && wppEnabled && _shouldShowConnectionToast) {
        _showToast(context);
      }
    });
  }

  void _showToast(BuildContext context) {
    if (!_shouldShowConnectionToast) return;
    _shouldShowConnectionToast = false;

    ArtSonner.show(
      context,
      ArtToast(
        id: _shouldShowConnectionToast,
        duration: ChatbotConstants.toastDuration,
        backgroundColor: context.artColors().foreground,
        title: Row(
          children: [
            Icon(PaipIcons.whatsApp, color: context.artColors().background),
            PSize.i.sizedBoxW,
            Text(context.i18n.atencao, style: TextStyle(color: context.artColors().background)),
          ],
        ),
        description: Text(context.i18n.descWhatsappDesconectado, style: TextStyle(color: context.artColors().muted)),
        action: ArtButton(
          backgroundColor: context.artColors().background,
          foregroundColor: context.artColors().foreground,
          child: Text(context.i18n.conectar),
          onPressed: () {
            ArtSonner.hide(context, _shouldShowConnectionToast);
            context.push(Routes.robots);
            _shouldShowConnectionToast = true;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cleanupTimer?.cancel();
    _toastTimer?.cancel();
    _eventSubscription?.cancel();
    super.dispose();
  }
}
