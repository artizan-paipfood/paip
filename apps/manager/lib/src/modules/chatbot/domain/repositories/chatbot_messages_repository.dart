import 'package:flutter/foundation.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotMessagesRepository extends ChangeNotifier {
  final IMessagesRepository messagesRepo;
  final DataSource dataSource;

  ChatbotMessagesRepository({required this.messagesRepo, required this.dataSource});

  final Map<OrderStatusEnum, MessageModel> _messages = {};

  List<MessageModel> get messages => _messages.values.toList()..sort((a, b) => a.status!.ordeningIndex.compareTo(b.status!.ordeningIndex));

  MessageModel? getMessageByStatus({required OrderStatusEnum status}) {
    if (!_messages.containsKey(status)) {
      throw StateError('There is no message configured for the status: $status');
    }
    final message = _messages[status]!;
    if (message.enable) return message;
    return null;
  }

  Future<void> upsert({required List<MessageModel> messages}) async {
    if (messages.isEmpty) {
      throw ArgumentError('The list of messages cannot be empty');
    }

    for (var message in messages) {
      if (message.status == null) {
        throw ArgumentError('All messages must have a status defined');
      }
    }

    await messagesRepo.upsert(messages: messages, auth: AuthNotifier.instance.auth);
    _updateCachedMessages(messages);
  }

  Future<List<MessageModel>> getAllByEstablishmentId({required String establishmentId}) async {
    if (establishmentId.isEmpty) {
      throw ArgumentError('The establishment ID cannot be empty');
    }

    final messages = await messagesRepo.getByEstablishmentId(establishmentId);
    _updateCachedMessages(messages);
    return messages;
  }

  void _updateCachedMessages(List<MessageModel> messages) {
    for (var message in messages) {
      if (message.status != null) {
        _messages[message.status!] = message;
      }
    }
    notifyListeners();
  }

  void clearCache() {
    _messages.clear();
    notifyListeners();
  }
}
