import 'package:paipfood_package/paipfood_package.dart';
import 'package:paipfood_package/src/core/enums/payment_enum.dart';

class PaymentProviderInvoiceModel {
  final DateTime createdAt;
  final DateTime? dateApproved;
  final DateTime? dateRefunded;
  final PaymentFlagEnum paymentFlag;
  final String? paymentId;
  final String? qrCodeCopyPaste;
  final String? qrCodeBase64;
  final double value;
  PaymentProviderInvoiceModel({
    required this.createdAt,
    required this.paymentFlag,
    required this.value,
    this.dateApproved,
    this.dateRefunded,
    this.paymentId,
    this.qrCodeCopyPaste,
    this.qrCodeBase64,
  });

  PaymentProviderInvoiceModel copyWith({
    DateTime? createdAt,
    DateTime? dateApproved,
    DateTime? dateRefunded,
    PaymentFlagEnum? paymentFlag,
    String? paymentId,
    String? qrCodeCopyPaste,
    String? qrCodeBase64,
    double? value,
  }) {
    return PaymentProviderInvoiceModel(
      createdAt: createdAt ?? this.createdAt,
      dateApproved: dateApproved ?? this.dateApproved,
      dateRefunded: dateRefunded ?? this.dateRefunded,
      paymentFlag: paymentFlag ?? this.paymentFlag,
      paymentId: paymentId ?? this.paymentId,
      qrCodeCopyPaste: qrCodeCopyPaste ?? this.qrCodeCopyPaste,
      qrCodeBase64: qrCodeBase64 ?? this.qrCodeBase64,
      value: value ?? this.value,
    );
  }

  factory PaymentProviderInvoiceModel.fromMercadoPagoPix(Map<String, dynamic> map) {
    return PaymentProviderInvoiceModel(
      createdAt: DateTime.parse(map['date_created']),
      dateApproved: map['date_approved'] != null ? DateTime.parse(map['date_approved']) : null,
      dateRefunded: map['date_refunded'] != null ? DateTime.parse(map['date_refunded']) : null,
      paymentFlag: PaymentFlagEnum.pix,
      paymentId: map['id'].toString(),
      qrCodeCopyPaste: map['point_of_interaction']['transaction_data']['qr_code'],
      qrCodeBase64: map['point_of_interaction']['transaction_data']['qr_code_base64'],
      value: map['transaction_amount'].toDouble(),
    );
  }

  bool get paymentIsApproved => dateApproved != null;
  bool get paymentIsNotApproved => !paymentIsApproved;
}
