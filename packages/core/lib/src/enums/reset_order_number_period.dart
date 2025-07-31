enum ResetOrderNumberPeriod {
  never,
  daily,
  weekly,
  monthly,
  yearly;

  static ResetOrderNumberPeriod fromMap(String value) => ResetOrderNumberPeriod.values.firstWhere((e) => e.name == value, orElse: () => ResetOrderNumberPeriod.daily);
}
