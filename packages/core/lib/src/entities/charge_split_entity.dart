import 'dart:convert';
import 'package:core/src/enums/charge_status.dart';
import 'package:core/src/enums/payment_provider.dart';
import 'package:core/src/enums/split_destination_type.dart';
import 'package:core/src/extensions/date.dart';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class ChargeSplitEntity {
  final String chargeId;
  final SplitDestinationType splitDestinationType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double amount;
  final PaymentProvider paymentProvider;
  final String destinationId;
  final ChargeStatus status;
  final String? transactionId;
  ChargeSplitEntity({
    required this.chargeId,
    required this.splitDestinationType,
    this.createdAt,
    this.updatedAt,
    required this.amount,
    required this.paymentProvider,
    required this.destinationId,
    required this.status,
    this.transactionId,
  });

  static const String table = 'charge_splits';

  ChargeSplitEntity copyWith({
    String? chargeId,
    SplitDestinationType? splitDestinationType,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? amount,
    PaymentProvider? paymentProvider,
    String? destinationId,
    ChargeStatus? status,
    String? transactionId,
  }) {
    return ChargeSplitEntity(
      chargeId: chargeId ?? this.chargeId,
      splitDestinationType: splitDestinationType ?? this.splitDestinationType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      amount: amount ?? this.amount,
      paymentProvider: paymentProvider ?? this.paymentProvider,
      destinationId: destinationId ?? this.destinationId,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'charge_id': chargeId,
      'split_destination_type': splitDestinationType.name,
      'updated_at': updatedAt?.toPaipDB(),
      'amount': amount,
      'payment_provider': paymentProvider.name,
      'destination_id': destinationId,
      'status': status.name,
      'transaction_id': transactionId,
    };
  }

  factory ChargeSplitEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return ChargeSplitEntity(
        chargeId: map['charge_id'] ?? '',
        splitDestinationType: SplitDestinationType.fromMap(
          map['split_destination_type'],
        ),
        createdAt: map['created_at'] != null
            ? DateTime.parse(
                map['created_at'],
              )
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(
                map['updated_at'],
              )
            : null,
        amount: map['amount']?.toDouble() ?? 0.0,
        paymentProvider: PaymentProvider.fromMap(
          map['payment_provider'],
        ),
        destinationId: map['destination_id'] ?? '',
        status: ChargeStatus.fromMap(
          map['status'],
        ),
        transactionId: map['transaction_id'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'ChargeSplitEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory ChargeSplitEntity.fromJson(
    String source,
  ) =>
      ChargeSplitEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
