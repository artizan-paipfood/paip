import 'package:core/src/enums/zz_enums_export.dart';

extension NumExtension on num {
  double convertMetersToMiles() => this / 1609.34;
  double convertMetersToKm() => this / 1000;

  double convertMetersToRadius(AppLocaleCode locale) {
    if (locale == AppLocaleCode.br) {
      return convertMetersToKm();
    }
    return convertMetersToMiles();
  }
}
