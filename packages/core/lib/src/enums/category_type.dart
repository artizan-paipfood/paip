enum CategoryType {
  product,
  pizza;

  static CategoryType fromMap(String value) {
    return CategoryType.values.firstWhere((e) => e.name == value);
  }
}
