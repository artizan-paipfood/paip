enum SizeType {
  product,
  pizza;

  static SizeType fromMap(String value) {
    return SizeType.values.firstWhere((e) => e.name == value);
  }
}
