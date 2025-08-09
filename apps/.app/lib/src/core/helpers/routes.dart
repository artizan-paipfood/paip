class Routes {
  static const Duration d = Duration(milliseconds: 700);

  //Auth
  static const String authModule = '/';
  static const String splashRelvative = '/';
  static String splash = splashRelvative;

  static const String login = loginRelative;
  static const loginRelative = '/login';
  //User
  static const String userModule = '/user';

  static String name = _normalizePath("$userModule/$nameRelative");
  static const String nameRelative = '/';

  static String phone = _normalizePath("$userModule$phoneRelative");
  static const phoneRelative = '/phone';

  static String phoneConfirm = _normalizePath("$userModule$phoneConfirmRelative");
  static const phoneConfirmRelative = '/phone_confirm';

  static String searchAddress = _normalizePath("$userModule$searchAddressRelative");
  static const searchAddressRelative = '/search_address';

  static String searchAddressManually = _normalizePath("$userModule$searchAddressManuallyRelative");
  static const searchAddressManuallyRelative = '/search_address_manually';

  static String userAddresses = _normalizePath("$userModule$userAddressesRelative");
  static const userAddressesRelative = '/user_adresses';

  static String addressNickname = _normalizePath("$userModule$addressNicknameRelative");
  static const addressNicknameRelative = '/address_nickname';

  //company
  static const String companyModule = '/company';
  static const String slugParam = 'slug';

  static String company({required String slug}) => _normalizePath("$companyModule/$slug");
  static const companyRelative = '/:$slugParam';

  //menu
  static const String menuModule = '/menu';
  static const String establishmentIdParam = 'establishment_id';
  static const String productIdParam = 'product_id';

  static String menu({required String establishmentId}) => _normalizePath("$menuModule/$establishmentId");
  static const menuRelative = '/:$establishmentIdParam';

  static String cartProduct({required String establishmentId, required String productId}) =>
      _normalizePath("$menuModule/$establishmentId/cart_product/$productId");
  static const cartProductRelative = '/cart_product/:$productIdParam';

  static cart({required String establishmentId}) => _normalizePath("$menuModule/$establishmentId/$cartRelative");
  static const cartRelative = '/cart';

  //order
  static const String orderModule = '/order';
  static const String orderIdParam = 'order_id';

  static String order({required String orderId}) => _normalizePath("$orderModule/$orderId");
  static const orderRelative = '/:$orderIdParam';

  static String paymentSucess({required String orderId}) => _normalizePath("$orderModule/$orderId/$paymentSucessRelative");
  static const paymentSucessRelative = '/payment_sucess';

  static waitingPayment({required String orderId}) => _normalizePath("$orderModule/$orderId/$waitingPaymentRelative");
  static const waitingPaymentRelative = '/waiting_payment';

  static String _normalizePath(String path) => path.replaceAll(RegExp(r'//'), '/').replaceAll('/:', '/');
}
