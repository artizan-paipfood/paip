enum SplitDestinationType {
  franchise,
  drive,
  establishment;

  static SplitDestinationType fromMap(String value) => SplitDestinationType.values.firstWhere((e) => e.name == value);
}
