// ignore_for_file: constant_identifier_names

enum PaipLanguage {
  pt_BR(imagePath: 'assets/flags/BR.png', languageCode: 'pt_BR'),
  en_US(imagePath: 'assets/flags/US.png', languageCode: 'en_US');

  final String imagePath;
  final String languageCode;

  const PaipLanguage({required this.imagePath, required this.languageCode});

  static PaipLanguage fromLanguageCode(String languageCode) => PaipLanguage.values.firstWhere((l) => l.languageCode == languageCode, orElse: () => PaipLanguage.pt_BR);
}
