class Routes {
  Routes._();

  static String store(String establishmentId) => '/$establishmentId';
  static const String storeRelative = '/:establishment_id';
  static const String storeNamed = 'store';
  static Map<String, String> storeNamedParams(String establishmentId) => {'establishment_id': establishmentId};
}
