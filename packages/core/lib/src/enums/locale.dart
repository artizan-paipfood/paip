enum AppLocaleCode {
  br(currencySymbol: 'R\$', countryCode: 'BR', underscoreTag: 'pt_BR', countryName: 'Brazil', urlSufix: 'com'),
  gb(currencySymbol: '£', countryCode: 'GB', underscoreTag: 'en_US', countryName: 'United Kingdom', urlSufix: 'co.uk');

  final String currencySymbol;
  final String countryCode;
  final String underscoreTag;
  final String countryName;
  final String urlSufix;

  const AppLocaleCode({required this.currencySymbol, required this.underscoreTag, required this.countryName, required this.urlSufix, required this.countryCode});

  static AppLocaleCode fromMap(String value) => AppLocaleCode.values.firstWhere((e) => e.name.toLowerCase() == value.toLowerCase());

  static AppLocaleCode fromCountryCode(String countryCode) {
    return AppLocaleCode.values.firstWhere((e) => e.countryCode.toLowerCase() == countryCode.toLowerCase(), orElse: () => AppLocaleCode.gb);
  }
}

extension AppLocaleCodeExtension on AppLocaleCode {
  String get appBaseUrl => 'https://paipfood.$urlSufix';

  bool get isBr => this == AppLocaleCode.br;
  bool get isGb => this == AppLocaleCode.gb;
}
