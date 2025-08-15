class Routes {
  static const String cartProductRelative = '/:product_id';
  static String cartProduct(String productId) => '/$productId';
  static const String cartProductNamed = 'cart_product';

  static Map<String, String> cartProductNamedParams(String productId) => {'product_id': productId};
}
