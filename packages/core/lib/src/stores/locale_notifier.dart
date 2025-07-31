import 'package:core/core.dart';

const Map<String, String> _currencyByCountry = {
  "BR": "R\$",
  "PT": "€",
  "GB": "£",
};
const Map<String, String> _baseUrlByCountry = {
  "BR": "https://paipfood.com",
  "PT": "https://paipfood.com",
  "GB": "https://paipfood.co.uk",
};

class LocaleNotifier {
  static LocaleNotifier? _instance;
  LocaleNotifier._();
  static LocaleNotifier get instance => _instance ??= LocaleNotifier._();

  DbLocale _locale = DbLocale.gb;
  DbLocale get locale => _locale;

  String get language {
    return switch (locale) { DbLocale.br => 'pt_BR', DbLocale.gb => 'en' };
  }

  String get currency => _currencyByCountry[locale.name.toUpperCase()]!;
  String get baseUrl => _baseUrlByCountry[locale.name.toUpperCase()]!;

  void setLocale(DbLocale locale) {
    _locale = locale;
  }
}

bool get isGb => LocaleNotifier.instance.locale == DbLocale.gb;
bool get isBr => LocaleNotifier.instance.locale == DbLocale.br;
// bool get isPt => LocaleNotifier.instance.locale == DbLocale.PT;
