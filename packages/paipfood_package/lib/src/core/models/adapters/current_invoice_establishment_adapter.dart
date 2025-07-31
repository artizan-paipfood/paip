import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class PlanAndInvoice {
  EstablishmentPlanModel? plan;
  EstablishmentInvoiceModel? invoice;
  PlanAndInvoice({
    this.plan,
    this.invoice,
  });

  Map<String, dynamic> toMap() {
    return {
      'plan': plan?.toMap(),
      'invoice': invoice?.toMap(),
    };
  }

  factory PlanAndInvoice.fromMap(Map map) {
    return PlanAndInvoice(
      plan: map['plan'] != null ? EstablishmentPlanModel.fromMap(map['plan']) : null,
      invoice: map['invoice'] != null ? EstablishmentInvoiceModel.fromMap(map['invoice']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanAndInvoice.fromJson(String source) => PlanAndInvoice.fromMap(json.decode(source));
}
