import 'dart:convert';

import 'package:core/core.dart';

class PaymentProviderView {
  final String id;
  final PaymentProviderStripeEntity? stripe;
  final PaymentProviderHipayEntity? hipay;

  PaymentProviderView({
    required this.id,
    required this.stripe,
    required this.hipay,
  });
  static const String view = 'view_payment_providers';

  PaymentProviderView copyWith({
    String? id,
    PaymentProviderStripeEntity? stripe,
    PaymentProviderHipayEntity? hipay,
  }) {
    return PaymentProviderView(
      id: id ?? this.id,
      stripe: stripe ?? this.stripe,
      hipay: hipay ?? this.hipay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stripe': stripe?.toMap(),
      'hipay': hipay?.toMap(),
    };
  }

  factory PaymentProviderView.fromMap(
    Map<String, dynamic> map,
  ) {
    return PaymentProviderView(
      id: map['id'] ?? '',
      stripe: map['stripe'] != null
          ? PaymentProviderStripeEntity.fromMap(
              map['stripe'],
            )
          : null,
      hipay: map['hipay'] != null
          ? PaymentProviderHipayEntity.fromMap(
              map['hipay'],
            )
          : null,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PaymentProviderView.fromJson(
    String source,
  ) =>
      PaymentProviderView.fromMap(
        json.decode(
          source,
        ),
      );
}
