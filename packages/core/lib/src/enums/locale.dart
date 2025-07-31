enum DbLocale {
  br,
  gb;

  static DbLocale fromMap(String value) => DbLocale.values.firstWhere((e) => e.name.toLowerCase() == value.toLowerCase());
}
