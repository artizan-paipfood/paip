import 'package:paipfood_package/paipfood_package.dart';

extension DateTimeExtension on DateTime {
  String pToTimesTamptzFormat() => toIso8601String();

  DateTime pNormalizeToCondition() => DateTime.now().copyWith(day: day, month: month, year: year, hour: hour, minute: minute, second: second);

  String pFactoryCountryFormatDDMMYYY() {
    if (isGb) return DateFormat("dd/MM/yyyy").format(toLocal());
    return DateFormat("dd/MM/yyyy").format(toLocal());
  }

  String pFactoryCountryFormatHHmm() {
    if (isGb) {
      return DateFormat("HH:mm").format(toLocal());
    }
    return DateFormat("HH:mm").format(toLocal());
  }

  String pFactoryCountryFormatDDMMYYYYHHmm() {
    if (isGb) {
      return DateFormat("dd/MM/yyyy HH:mm").format(toLocal());
    }
    return DateFormat("dd/MM/yyyy HH:mm").format(toLocal());
  }

  String pFactoryCountryFormatDDMMYYHHmm() {
    if (isGb) {
      return DateFormat("dd/MM/yy HH:mm").format(toLocal());
    }
    return DateFormat("dd/MM/yy HH:mm").format(toLocal());
  }
}
