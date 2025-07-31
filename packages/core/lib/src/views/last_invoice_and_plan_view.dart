import 'dart:convert';

import 'package:core/core.dart';

class LastInvoiceAndPlanView {
  final String establishmentId;
  final EstablishmentInvoiceEntity? invoice;
  final EstablishmentPlanEntity? plan;
  LastInvoiceAndPlanView({
    required this.establishmentId,
    this.invoice,
    this.plan,
  });

  static const String viewName = 'view_last_invoice_and_plan';

  LastInvoiceAndPlanView copyWith({
    String? establishmentId,
    EstablishmentInvoiceEntity? invoice,
    EstablishmentPlanEntity? plan,
  }) {
    return LastInvoiceAndPlanView(
      establishmentId: establishmentId ?? this.establishmentId,
      invoice: invoice ?? this.invoice,
      plan: plan ?? this.plan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'invoice': invoice?.toMap(),
      'plan': plan?.toMap(),
    };
  }

  factory LastInvoiceAndPlanView.fromMap(
    Map<String, dynamic> map,
  ) {
    return LastInvoiceAndPlanView(
      establishmentId: map['establishment_id'] ?? '',
      invoice: map['invoice'] != null
          ? EstablishmentInvoiceEntity.fromMap(
              map['invoice'],
            )
          : null,
      plan: map['plan'] != null
          ? EstablishmentPlanEntity.fromMap(
              map['plan'],
            )
          : null,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory LastInvoiceAndPlanView.fromJson(
    String source,
  ) =>
      LastInvoiceAndPlanView.fromMap(
        json.decode(
          source,
        ),
      );
}
