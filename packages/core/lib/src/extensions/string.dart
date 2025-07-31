extension PaipStringExtension on String {
  String capitalize() => split(' ').map((e) => e.capitalize).join(' ');

  String onlyNumbers() => replaceAll(RegExp(r'[^0-9]'), '').trim();

  String replaceIfEmpty(String value) => isEmpty ? value : this;

  String removeAccents(String value) => replaceAll(RegExp(r'[áàãâä]'), 'a').replaceAll(RegExp(r'[éèêë]'), 'e').replaceAll(RegExp(r'[íìîï]'), 'i').replaceAll(RegExp(r'[óòõôö]'), 'o').replaceAll(RegExp(r'[úùûü]'), 'u').replaceAll(RegExp(r'[ç]'), 'c');
}
