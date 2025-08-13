import 'dart:convert';

import 'package:core/src/extensions/date.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class PaymentProviderEntity {
  final String id;
  final DateTime? createdAt;

  PaymentProviderEntity({
    required this.id,
    this.createdAt,
  });
  static const String table = 'payment_providers';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toPaipDB(),
    };
  }

  factory PaymentProviderEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return PaymentProviderEntity(
        id: map['id'] ?? '',
        createdAt: map['created_at'] != null
            ? DateTime.parse(
                map['created_at'],
              )
            : null,
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'PaymentProviderEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PaymentProviderEntity.fromJson(
    String source,
  ) =>
      PaymentProviderEntity.fromMap(
        json.decode(
          source,
        ),
      );

  PaymentProviderEntity copyWith({
    String? id,
    DateTime? createdAt,
  }) {
    return PaymentProviderEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
