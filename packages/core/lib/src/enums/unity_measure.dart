enum UnityMeasure {
  un,
  kg;

  static UnityMeasure fromMap(String value) => UnityMeasure.values.firstWhere((element) => element.name.toLowerCase() == value);
}
