import 'dart:convert';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentInvoiceModel {
  final String id;
  final String establishmentId;
  final String establishmentPlanId;
  final DateTime createdAt;
  final DateTime dueDate;
  final double amount;
  final DateTime? renegotiationDate;
  final DateTime? paymentDate;
  final PaymentType? paymentType;
  final String? transactionId;
  final DateTime? updatedAt;

  EstablishmentInvoiceModel({
    required this.id,
    required this.establishmentId,
    required this.establishmentPlanId,
    required this.createdAt,
    required this.dueDate,
    required this.amount,
    this.renegotiationDate,
    this.paymentDate,
    this.paymentType,
    this.transactionId,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'establishment_plan_id': establishmentPlanId,
      'due_date': dueDate.pToTimesTamptzFormat(),
      'amount': amount,
      'renegotiation_date': renegotiationDate?.pToTimesTamptzFormat(),
      'payment_date': paymentDate?.pToTimesTamptzFormat(),
      'payment_type': paymentType?.name,
      'transaction_id': transactionId,
      'updated_at': updatedAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
    };
  }

  factory EstablishmentInvoiceModel.fromMap(Map map) {
    return EstablishmentInvoiceModel(
      id: map['id'] ?? '',
      establishmentId: map['establishment_id'] ?? '',
      establishmentPlanId: map['establishment_plan_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      dueDate: DateTime.parse(map['due_date']),
      amount: map['amount']?.toDouble() ?? 0.0,
      renegotiationDate: map['renegotiation_date'] != null ? DateTime.parse(map['renegotiationDate']) : null,
      paymentDate: map['payment_date'] != null ? DateTime.parse(map['payment_date']) : null,
      paymentType: map['payment_type'] != null ? PaymentType.fromMap(map['payment_type']) : null,
      transactionId: map['transaction_id'],
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentInvoiceModel.fromJson(String source) => EstablishmentInvoiceModel.fromMap(json.decode(source));

  factory EstablishmentInvoiceModel.fromEstablishmentPlan(EstablishmentPlanModel establishmentPlan) {
    return EstablishmentInvoiceModel(
      amount: establishmentPlan.buildAmount,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dueDate: establishmentPlan.dueDate,
      establishmentId: establishmentPlan.establishmentId,
      establishmentPlanId: establishmentPlan.id,
      id: uuid,
      paymentDate: establishmentPlan.buildAmount > 0 ? null : DateTime.now(),
      paymentType: establishmentPlan.buildAmount > 0 ? null : PaymentType.cash,
    );
  }

  bool get isCurrentMounth => dueDate.month == DateTime.now().month;

  bool get isNotCurrentMounth => !isCurrentMounth;

  bool get isPaid => paymentDate != null;
  bool get isNotPaid => !isPaid;

  bool get isExpired => paymentDate == null && daysOfVenciment < 1;

  bool get isBlocked => paymentDate == null && daysOfVenciment < 1;

  bool get isNotBlocked => !isBlocked;

  int get daysOfVenciment {
    return dueDate.add(5.days).difference(DateTime.now()).inDays;
  }

  EstablishmentInvoiceModel copyWith({
    String? id,
    String? establishmentId,
    String? establishmentPlanId,
    DateTime? createdAt,
    DateTime? dueDate,
    double? amount,
    DateTime? renegotiationDate,
    DateTime? paymentDate,
    PaymentType? paymentType,
    String? transactionId,
    DateTime? updatedAt,
  }) {
    return EstablishmentInvoiceModel(
      id: id ?? this.id,
      establishmentId: establishmentId ?? this.establishmentId,
      establishmentPlanId: establishmentPlanId ?? this.establishmentPlanId,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      renegotiationDate: renegotiationDate ?? this.renegotiationDate,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentType: paymentType ?? this.paymentType,
      transactionId: transactionId ?? this.transactionId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
