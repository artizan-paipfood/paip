class Routes {
  Routes._();

  static String store(String establishmentId) => '/$establishmentId';
  static const String storeRelative = '/:establishment_id';
  static const String storeNamed = 'store';
  static Map<String, String> storeNamedParams(String establishmentId) => {'establishment_id': establishmentId};

  static String search(String establishmentId) => '/search/$establishmentId';
  static const String searchRelative = '/search';
  static const String searchNamed = 'store-search';
  static Map<String, String> searchNamedParams(String establishmentId) => {'establishment_id': establishmentId};
}
