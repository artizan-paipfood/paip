enum DeliveryMethod {
  polygon,
  miles;

  static DeliveryMethod fromMap(String value) => DeliveryMethod.values.firstWhere((e) => e.name == value);
}
