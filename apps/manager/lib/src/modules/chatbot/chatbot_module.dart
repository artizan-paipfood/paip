import 'dart:async';
import 'package:evolution_api/evolution_api.dart';
import 'package:manager/src/core/helpers/constants.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/modules/chatbot/domain/usecases/chatbot_wpp_messages_usecase.dart';
import 'package:manager/src/modules/chatbot/domain/services/chatbot_wpp_connection_service.dart';
import 'package:manager/src/modules/chatbot/presenters/viewmodels/chatbot_viewmodel.dart';
import 'package:manager/src/modules/chatbot/domain/repositories/chatbot_messages_repository.dart';
import 'package:manager/src/modules/chatbot/presenters/chatbot_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => ChatbotWppConnectionService(i.get())),
        Bind.singleton((i) => EvolutionApi(host: Constants.evolutionapiUrl(), token: Constants.evlutionapiKey(), websocketEnabled: true)),
        Bind.factory((i) => MessagesRepository(http: i.get())),
        Bind.singleton((i) => ChatbotWppMessagesUsecase(connectionService: i.get(), chatbotMessagesRepository: i.get(), dataSource: i.get())),
        Bind.singleton((i) => ChatbotMessagesRepository(messagesRepo: i.get(), dataSource: i.get())),
        Bind.singleton((i) => ChatbotViewmodel(chatbotMessagesRepository: i.get(), wppConnectionService: i.get(), establishmentPreferencesStore: EstablishmentPreferencesStore.instance, establishmentPreferencesRepo: i.get(), wppMessagesUsecase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [ChildRoute(Routes.robotsRelative, child: (context, args) => const ChatbotPage())];
}
