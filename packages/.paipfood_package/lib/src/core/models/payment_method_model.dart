// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

enum PaymentProviderEnum {
  stripe,
  mercado_pago,
  hipay;

  static PaymentProviderEnum fromMap(String value) {
    return PaymentProviderEnum.values.firstWhere((e) => e.name == value);
  }
}

class PaymentMethodModel {
  final String establishmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool credit;
  final List<OrderTypeEnum> creditTypes;
  final bool debit;
  final List<OrderTypeEnum> debitTypes;
  final bool cash;
  final List<OrderTypeEnum> cashTypes;
  final bool pix;
  final List<OrderTypeEnum> pixTypes;
  final bool voucher;
  final List<OrderTypeEnum> voucherTypes;
  final PixMetadata? pixMetadata;
  const PaymentMethodModel({
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.credit = true,
    this.creditTypes = _defaulOrderTypes,
    this.debit = true,
    this.debitTypes = _defaulOrderTypes,
    this.cash = true,
    this.cashTypes = _defaulOrderTypes,
    this.pix = false,
    this.pixTypes = _defaulOrderTypes,
    this.voucher = false,
    this.voucherTypes = _defaulOrderTypes,
    this.pixMetadata,
  });

  static const List<OrderTypeEnum> _defaulOrderTypes = [OrderTypeEnum.delivery, OrderTypeEnum.takeWay];

  PaymentMethodModel copyWith({
    String? establishmentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? credit,
    List<OrderTypeEnum>? creditTypes,
    bool? debit,
    List<OrderTypeEnum>? debitTypes,
    bool? cash,
    List<OrderTypeEnum>? cashTypes,
    bool? pix,
    List<OrderTypeEnum>? pixTypes,
    bool? voucher,
    List<OrderTypeEnum>? voucherTypes,
    PixMetadata? pixMetadata,
  }) {
    return PaymentMethodModel(
      establishmentId: establishmentId ?? this.establishmentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      credit: credit ?? this.credit,
      creditTypes: creditTypes ?? this.creditTypes,
      debit: debit ?? this.debit,
      debitTypes: debitTypes ?? this.debitTypes,
      cash: cash ?? this.cash,
      cashTypes: cashTypes ?? this.cashTypes,
      pix: pix ?? this.pix,
      pixTypes: pixTypes ?? this.pixTypes,
      voucher: voucher ?? this.voucher,
      voucherTypes: voucherTypes ?? this.voucherTypes,
      pixMetadata: pixMetadata ?? this.pixMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'updated_at': updatedAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
      'credit': credit,
      'credit_types': creditTypes.map((x) => x.name).toList(),
      'debit': debit,
      'debit_types': debitTypes.map((x) => x.name).toList(),
      'cash': cash,
      'cash_types': cashTypes.map((x) => x.name).toList(),
      'pix': pix,
      'pix_types': pixTypes.map((x) => x.name).toList(),
      'voucher': voucher,
      'voucher_types': voucherTypes.map((x) => x.name).toList(),
      'pix_metadata': pixMetadata?.toMap(),
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      establishmentId: map['establishment_id'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      credit: map['credit'] ?? false,
      creditTypes: List<OrderTypeEnum>.from(map['credit_types']?.map((x) => OrderTypeEnum.fromMap(x))),
      debit: map['debit'] ?? false,
      debitTypes: List<OrderTypeEnum>.from(map['debit_types']?.map((x) => OrderTypeEnum.fromMap(x))),
      cash: map['cash'] ?? false,
      cashTypes: List<OrderTypeEnum>.from(map['cash_types']?.map((x) => OrderTypeEnum.fromMap(x))),
      pix: map['pix'] ?? false,
      pixTypes: List<OrderTypeEnum>.from(map['pix_types']?.map((x) => OrderTypeEnum.fromMap(x))),
      voucher: map['voucher'] ?? false,
      voucherTypes: List<OrderTypeEnum>.from(map['voucher_types']?.map((x) => OrderTypeEnum.fromMap(x))),
      pixMetadata: map['pix_metadata'] != null ? PixMetadata.fromMap(map['pix_metadata']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) => PaymentMethodModel.fromMap(json.decode(source));

  List<PaymentType> getAllPaymentTypes() {
    final List<PaymentType> types = [];
    if (cash) types.add(PaymentType.cash);
    if (credit) types.add(PaymentType.credit);
    if (debit) types.add(PaymentType.debit);
    if (pix) types.add(PaymentType.pix);
    // if (voucher) types.add(PaymentType.voucher);
    return types;
  }

  List<PaymentType> getPaymentTypesByOrderType(OrderTypeEnum orderType) {
    final List<PaymentType> types = [];
    if (cash) {
      if (cashTypes.contains(orderType)) types.add(PaymentType.cash);
    }
    if (credit) {
      if (creditTypes.contains(orderType)) types.add(PaymentType.credit);
    }
    if (debit) {
      if (debitTypes.contains(orderType)) types.add(PaymentType.debit);
    }
    if (pix) {
      if (pixTypes.contains(orderType)) types.add(PaymentType.pix);
    }
    // if (voucher) {
    //   if (voucherTypes.contains(orderType)) types.add(PaymentType.voucher);
    // }
    return types;
  }

  List<OrderTypeEnum> getOrderTypesByPaymentType(PaymentType paymentType) {
    final List<OrderTypeEnum> types = [];
    if (paymentType == PaymentType.cash) types.addAll(cashTypes);
    if (paymentType == PaymentType.credit) types.addAll(creditTypes);
    if (paymentType == PaymentType.debit) types.addAll(debitTypes);
    if (paymentType == PaymentType.pix) types.addAll(pixTypes);
    // if (paymentType == PaymentType.voucher) types.addAll(voucherTypes);
    return types;
  }

  PaymentMethodModel updateOrderTypes({required PaymentType paymentType, required List<OrderTypeEnum> orderTypes}) {
    switch (paymentType) {
      case PaymentType.cash:
        return copyWith(cashTypes: orderTypes);
      case PaymentType.credit:
        return copyWith(creditTypes: orderTypes);
      case PaymentType.debit:
        return copyWith(debitTypes: orderTypes);
      case PaymentType.pix:
        return copyWith(pixTypes: orderTypes);
      // case PaymentType.voucher:
      //   return copyWith(voucherTypes: orderTypes);
      default:
        return this;
    }
  }

  PaymentMethodModel switchPaymentType({required PaymentType paymentType, required bool value}) {
    switch (paymentType) {
      case PaymentType.cash:
        return copyWith(cash: value);
      case PaymentType.credit:
        return copyWith(credit: value);
      case PaymentType.debit:
        return copyWith(debit: value);
      case PaymentType.pix:
        return copyWith(pix: value);
      // case PaymentType.voucher:
      //   return copyWith(voucher: value);
      default:
        return this;
    }
  }
}
