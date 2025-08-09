import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/chatbot/domain/repositories/chatbot_messages_repository.dart';
import 'package:manager/src/modules/chatbot/domain/services/chatbot_wpp_connection_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

/// Classe responsável por gerenciar o envio de mensagens do WhatsApp
class ChatbotWppMessagesUsecase {
  final ChatbotWppConnectionService connectionService;
  final ChatbotMessagesRepository chatbotMessagesRepository;
  final DataSource dataSource;

  ChatbotWppMessagesUsecase({
    required this.connectionService,
    required this.chatbotMessagesRepository,
    required this.dataSource,
  });

  Future<void> sendMessageWellcome({required String phone}) async {
    String? message = chatbotMessagesRepository.getMessageByStatus(status: OrderStatusEnum.greetingsMessage)?.message;
    if (message != null) {
      message = _replaceMessage(message: message);
      await connectionService.sendTextMessage(phone: phone, message: message);
    }
  }

  Future<void> sendMessageByOrderStatus({required String phone, required OrderModel order}) async {
    _validateOrder(order);
    String? message = chatbotMessagesRepository.getMessageByStatus(status: order.status)?.message;

    if (message != null) {
      message = _replaceMessage(message: message, order: order);
      await connectionService.sendTextMessage(phone: phone, message: message);
    }
  }

  void _validateOrder(OrderModel order) {
    if (order.customer.name.isEmpty) {
      throw ArgumentError('O pedido deve ter um cliente com nome definido');
    }
  }

  String _replaceMessage({required String message, OrderModel? order}) {
    try {
      final nameAndSurname = "${order?.customer.name ?? " "} ";
      final name = nameAndSurname.substring(0, nameAndSurname.indexOf(' '));

      return message
          .replaceAll(ReplaceMessageEnum.name.code, name)
          .replaceAll(ReplaceMessageEnum.resumeOrder.code, order?.getResume ?? "")
          .replaceAll(ReplaceMessageEnum.linkOrderStatus.code, order != null ? "${LocaleNotifier.instance.baseUrl}/order/${order.id}" : "")
          .replaceAll(ReplaceMessageEnum.goodDay.code, _getGoodDay())
          .replaceAll(ReplaceMessageEnum.establishmentName.code, establishmentProvider.value.fantasyName)
          .replaceAll(ReplaceMessageEnum.linkCompany.code, "${LocaleNotifier.instance.baseUrl}/menu/${dataSource.company.slug}")
          .replaceAll(ReplaceMessageEnum.linkEstablishment.code, "${LocaleNotifier.instance.baseUrl}/menu/${establishmentProvider.value.id}");
    } catch (e) {
      throw FormatException('Error replacing message placeholders: $e');
    }
  }

  String _getGoodDay() {
    final hora = DateTime.now().hour;

    if (hora >= 6 && hora < 12) {
      return l10nProiver.bomDia;
    } else if (hora >= 12 && hora < 18) {
      return l10nProiver.boaTarde;
    } else {
      return l10nProiver.boaNoite;
    }
  }
}
