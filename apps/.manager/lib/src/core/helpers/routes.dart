class Routes {
  //PARAMS

  //AUTH
  static const String authModule = '/auth';

  static const String splashRelative = '/';
  static String splash = _parsePath('/auth/');

  static const String selectLanguageRelative = '/select_language';
  static String selectLanguage = _parsePath('/auth/select_language/');

  static const String loginRelative = '/login';
  static String login = _parsePath('/auth/login/');

  //HOME
  static const String homeModule = '/';

  //CONFIG
  static const String configModule = '/config';

  static const String aparenceRelative = '/';
  static String aparence = _parsePath('/config/');

  static const String paymentTypesRelative = '/payment_types';
  static String paymentTypes = _parsePath('/config/payment_types/');

  static const String informationRelative = '/information';
  static String information = _parsePath('/config/information/');

  static const String openingHoursRelative = '/opening_hours';
  static String openingHours = _parsePath('/config/opening_hours/');

  static const String printerRelative = '/printer';
  static String printer = _parsePath('/config/printer/');

  static const String preferencesRelative = '/preferences';
  static String preferences = _parsePath('/config/preferences/');

  //REPORTS
  static const String reportsModule = '/reports';

  static const String reportsRelative = '/';
  static String reports = _parsePath('/reports/');

  //DRIVERS
  static const String driversModule = '/drivers';

  static const String driversRelative = '/';
  static String drivers = _parsePath('/drivers/');

  //DELIVERY AREAS
  static const String deliveryAreasModule = '/delivery_areas';

  static const String deliveryAreasRelative = '/';
  static String deliveryAreas = _parsePath('/delivery_areas/');

  //MENU
  static const String menuModule = '/menu';

  static const String menuRelative = '/';
  static String menu = _parsePath('/menu/');

  //ROBOT
  static const String robotsModule = '/robots';

  static const String robotsRelative = '/';
  static String robots = _parsePath('/robots/');

  //PDV
  static const String pdvModule = '/pdv';

  static const String pdvRelative = '/';
  static String pdv = _parsePath('/pdv/');

  //ORDERS
  static const String ordersModule = '/orders';

  static const String ordersRelative = '/';
  static String orders = _parsePath('/orders/');

  static String _parsePath(String path) {
    final result = path.replaceAll('//', '/');
    if (result.substring(result.length - 1) == '/') {
      return result.substring(0, result.length - 1);
    }
    return result;
  }
}
