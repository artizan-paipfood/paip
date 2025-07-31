enum PaymentProvider {
  stripe,
  hipay;

  static PaymentProvider fromMap(String value) => PaymentProvider.values.firstWhere((ps) => ps.name == value);
}
