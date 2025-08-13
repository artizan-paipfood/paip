import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class PaymentProviderHipayEntity {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String recipientId;
  final PaymentProviderAccountStatus status;
  final String bankAgency;
  final String bankAgencyVerificationDigit;
  final String bankCode;
  final String bankAccount;
  final String bankAccountVerificationDigit;
  final String paymentProviderId;
  final double feePercent;
  final double fee;
  PaymentProviderHipayEntity({
    this.createdAt,
    this.updatedAt,
    required this.recipientId,
    this.status = PaymentProviderAccountStatus.pending,
    required this.bankAgency,
    required this.bankAgencyVerificationDigit,
    required this.bankCode,
    required this.bankAccount,
    required this.bankAccountVerificationDigit,
    required this.paymentProviderId,
    required this.feePercent,
    required this.fee,
  });
  static const String table = 'payment_provider_hipay';

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt?.toPaipDB(),
      'updated_at': updatedAt?.toPaipDB(),
      'recipient_id': recipientId,
      'status': status,
      'bank_agency': bankAgency,
      'bank_agency_verification_digit': bankAgencyVerificationDigit,
      'bank_code': bankCode,
      'bank_account': bankAccount,
      'bank_account_verification_digit': bankAccountVerificationDigit,
      'payment_provider_id': paymentProviderId,
      'fee_percent': feePercent,
      'fee': fee,
    };
  }

  factory PaymentProviderHipayEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return PaymentProviderHipayEntity(
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
        recipientId: map['recipient_id'] ?? '',
        status: PaymentProviderAccountStatus.fromMap(
          map['status'],
        ),
        bankAgency: map['bank_agency'] ?? '',
        bankAgencyVerificationDigit: map['bank_agency_verification_digit'] ?? '',
        bankCode: map['bank_code'] ?? '',
        bankAccount: map['bank_account'] ?? '',
        bankAccountVerificationDigit: map['bank_account_verification_digit'] ?? '',
        paymentProviderId: map['payment_provider_id'] ?? '',
        feePercent: map['fee_percent']?.toDouble() ?? 0.0,
        fee: map['fee']?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'PaymentProviderHipayEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PaymentProviderHipayEntity.fromJson(
    String source,
  ) =>
      PaymentProviderHipayEntity.fromMap(
        json.decode(
          source,
        ),
      );

  PaymentProviderHipayEntity copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? recipientId,
    PaymentProviderAccountStatus? status,
    String? bankAgency,
    String? bankAgencyVerificationDigit,
    String? bankCode,
    String? bankAccount,
    String? bankAccountVerificationDigit,
    String? paymentProviderId,
    double? feePercent,
    double? fee,
  }) {
    return PaymentProviderHipayEntity(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recipientId: recipientId ?? this.recipientId,
      status: status ?? this.status,
      bankAgency: bankAgency ?? this.bankAgency,
      bankAgencyVerificationDigit: bankAgencyVerificationDigit ?? this.bankAgencyVerificationDigit,
      bankCode: bankCode ?? this.bankCode,
      bankAccount: bankAccount ?? this.bankAccount,
      bankAccountVerificationDigit: bankAccountVerificationDigit ?? this.bankAccountVerificationDigit,
      paymentProviderId: paymentProviderId ?? this.paymentProviderId,
      feePercent: feePercent ?? this.feePercent,
      fee: fee ?? this.fee,
    );
  }
}
