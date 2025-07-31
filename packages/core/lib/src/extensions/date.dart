extension PaipDate on DateTime {
  String? toPaipDB() {
    return toUtc().toIso8601String();
  }

  DateTime normalizeToCondition() {
    return copyWith(hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond);
  }
}
