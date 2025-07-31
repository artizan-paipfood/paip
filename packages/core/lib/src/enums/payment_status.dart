enum PaymentStatus {
  pending,
  // awaitingPayment,
  failed,
  paid,
  // paymentRejected,
  refunded,
  canceled,
  // lost;
  expired,
  undefined;

  static PaymentStatus fromMap(String value) => PaymentStatus.values.firstWhere((e) => e.name == value, orElse: () => PaymentStatus.undefined);
}
