enum ItemType {
  item,
  pizza;

  static ItemType fromMap(String value) {
    return ItemType.values.firstWhere((e) => e.name == value);
  }
}
