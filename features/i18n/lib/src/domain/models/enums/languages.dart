// ignore_for_file: constant_identifier_names

enum AppLanguage {
  pt_BR(imagePath: 'assets/flags/BR.png', languageCode: 'pt_BR'),
  en_US(imagePath: 'assets/flags/US.png', languageCode: 'en_US');

  final String imagePath;
  final String languageCode;

  const AppLanguage({required this.imagePath, required this.languageCode});

  static AppLanguage fromLanguageCode(String languageCode) => AppLanguage.values.firstWhere((l) => l.languageCode == languageCode, orElse: () => AppLanguage.pt_BR);
}
