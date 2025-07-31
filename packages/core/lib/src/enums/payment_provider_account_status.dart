enum PaymentProviderAccountStatus {
  pending,
  enable,
  disable;

  static PaymentProviderAccountStatus fromMap(String value) => PaymentProviderAccountStatus.values.firstWhere((e) => e.name == value);
}
