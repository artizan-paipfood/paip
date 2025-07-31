enum PaymentType {
  credit,
  debit,
  voucher,
  foodTicket,
  mealTicket,
  cash,
  pix,
  qrcode;

  static PaymentType fromMap(String value) => PaymentType.values.firstWhere((e) => e.name == value.toLowerCase());
}
