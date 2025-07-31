import 'dart:convert';
import 'package:core/src/enums/payment_type.dart';
import 'package:core/src/extensions/date.dart';

class EstablishmentInvoiceEntity {
  final String id;
  final String establishmentId;
  final String establishmentPlanId;
  final DateTime? createdAt;
  final DateTime dueDate;
  final double amount;
  final DateTime? renegotiationDate;
  final DateTime? paymentDate;
  final PaymentType? paymentType;
  final String? transactionId;
  final DateTime? updatedAt;
  EstablishmentInvoiceEntity({
    required this.id,
    required this.establishmentId,
    required this.establishmentPlanId,
    this.createdAt,
    required this.dueDate,
    required this.amount,
    this.renegotiationDate,
    this.paymentDate,
    this.paymentType,
    this.transactionId,
    this.updatedAt,
  });

  static const String table = 'establishment_invoices';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'establishment_plan_id': establishmentPlanId,
      'due_date': dueDate.toPaipDB(),
      'amount': amount,
      'renegotiation_date': renegotiationDate?.toPaipDB(),
      'payment_date': paymentDate?.toPaipDB(),
      'payment_type': paymentType?.name,
      'transaction_id': transactionId,
      'updated_at': updatedAt?.toPaipDB(),
    };
  }

  factory EstablishmentInvoiceEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return EstablishmentInvoiceEntity(
      id: map['id'] ?? '',
      establishmentId: map['establishment_id'] ?? '',
      establishmentPlanId: map['establishment_plan_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      dueDate: DateTime.parse(map['due_date']),
      amount: map['amount']?.toDouble() ?? 0.0,
      renegotiationDate: map['renegotiation_date'] != null ? DateTime.parse(map['renegotiation_date']) : null,
      paymentDate: map['payment_date'] != null ? DateTime.parse(map['payment_date']) : null,
      paymentType: map['payment_type'] != null ? PaymentType.fromMap(map['payment_type']) : null,
      transactionId: map['transaction_id'],
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentInvoiceEntity.fromJson(String source) => EstablishmentInvoiceEntity.fromMap(json.decode(source));

  EstablishmentInvoiceEntity copyWith({
    String? id,
    String? establishmentId,
    String? establishmentPlanId,
    DateTime? dueDate,
    double? amount,
    DateTime? renegotiationDate,
    DateTime? paymentDate,
    PaymentType? paymentType,
    String? transactionId,
  }) {
    return EstablishmentInvoiceEntity(
      id: id ?? this.id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      establishmentId: establishmentId ?? this.establishmentId,
      establishmentPlanId: establishmentPlanId ?? this.establishmentPlanId,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      renegotiationDate: renegotiationDate ?? this.renegotiationDate,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentType: paymentType ?? this.paymentType,
      transactionId: transactionId ?? this.transactionId,
    );
  }
  //------------------------------------------------------------------------------------------------------------------
  // methods
  //------------------------------------------------------------------------------------------------------------------

  bool get isCurrentMounth => dueDate.month == DateTime.now().month;
  bool get isNotCurrentMounth => !isCurrentMounth;

  bool get isPaid => paymentDate != null;
  bool get isNotPaid => !isPaid;

  bool isBlocked([DateTime? now]) => isNotPaid && daysUntilBlock(now) == 0;
  bool isNotBlocked([DateTime? now]) => !isBlocked(now);

  int daysOverdue([DateTime? now]) {
    now ??= DateTime.now();
    final diff = now.difference(dueDate).inDays;
    return diff > 0 ? diff : 0;
  }

  int daysUntilDue([DateTime? now]) {
    now ??= DateTime.now();
    final diff = dueDate.difference(now).inDays;

    return diff > 0 ? diff : 0;
  }

  int? daysUntilBlock([DateTime? now]) {
    now ??= DateTime.now();

    if (now.isBefore(dueDate)) return null;

    final blockDate = dueDate.add(
      Duration(days: 5),
    );
    final diff = blockDate.difference(now).inDays;

    return diff > 0 ? diff : 0;
  }
}
