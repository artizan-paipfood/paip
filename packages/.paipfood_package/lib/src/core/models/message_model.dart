import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class MessageModel {
  final String id;
  final String establishmentId;
  final String message;
  final bool enable;
  final OrderStatusEnum? status;
  final String? keysMessageResponse;
  MessageModel({
    required this.id,
    required this.establishmentId,
    required this.message,
    this.enable = true,
    this.status,
    this.keysMessageResponse,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'message': message,
      'enable': enable,
      'status': status?.name,
      'keys_message_response': keysMessageResponse,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      establishmentId: map['establishment_id'],
      message: map['message'],
      enable: map['enable'] ?? false,
      status: map['status'] != null ? OrderStatusEnum.fromMap(map['status']) : null,
      keysMessageResponse: map['keys_message_response'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  factory MessageModel.fromStatus({required OrderStatusEnum status, required String establishmentId}) {
    return MessageModel(
      establishmentId: establishmentId,
      id: uuid,
      message: status.messageDefaut,
      status: status,
    );
  }

  Map<String, String>? get buildMapResponse {
    if (keysMessageResponse == null) return null;
    return {keysMessageResponse!: message};
  }

  MessageModel copyWith({
    String? id,
    String? establishmentId,
    String? message,
    bool? enable,
    OrderStatusEnum? status,
    String? keysMessageResponse,
  }) {
    return MessageModel(
      id: id ?? this.id,
      establishmentId: establishmentId ?? this.establishmentId,
      message: message ?? this.message,
      enable: enable ?? this.enable,
      status: status ?? this.status,
      keysMessageResponse: keysMessageResponse ?? this.keysMessageResponse,
    );
  }
}
