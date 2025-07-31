import 'package:flutter/widgets.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

enum PaymentFlagEnum {
  card,
  cash,
  amex,
  diners,
  elo,
  hiper,
  master,
  pix,
  visa,
  vrAlimentacao,
  vrRefeicao;

  static PaymentFlagEnum fromMap(String value) {
    return PaymentFlagEnum.values.firstWhere((element) => element.name == value);
  }

  static String pathIcon(PaymentFlagEnum paymentEnum) => 'assets/payments/${paymentEnum.name}.svg';
}

enum SubPaymentType {
  pix,
  vrAlimentacao,
  vrRefeicao;

  static SubPaymentType fromMap(String value) {
    return SubPaymentType.values.firstWhere((element) => element.name == value);
  }
}

extension PaymentTypeExtension on PaymentType {
  String get text => switch (this) { PaymentType.cash => 'dinheiro', PaymentType.credit => 'credito', PaymentType.debit => 'debito', PaymentType.pix => 'pix', _ => throw Exception('PaymentType not found') };

  IconData get icon =>
      switch (this) { PaymentType.cash => PIcons.strokeRoundedCash01, PaymentType.credit => PIcons.strokeRoundedCreditCard, PaymentType.debit => PIcons.strokeRoundedCreditCard, PaymentType.pix => PIcons.strokeRoundedQrCode, _ => throw Exception('PaymentType not found') };
}
