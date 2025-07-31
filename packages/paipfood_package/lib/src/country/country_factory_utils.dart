import 'package:paipfood_package/paipfood_package.dart';

class CountryFactoryUtils {
  CountryFactoryUtils._();

  static String get getCountry {
    if (isGb) return 'United Kingdom';
    return 'Brasil';
  }
}
