enum ComplementType {
  item,
  pizza,
  optionalPizza;

  static ComplementType fromMap(String value) {
    return ComplementType.values.firstWhere((e) => e.name == value);
  }
}
