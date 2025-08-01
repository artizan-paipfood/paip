import 'package:paipfood_package/paipfood_package.dart';

class DataSource {
  DataSource._internal();
  static final DataSource instance = DataSource._internal();
  factory DataSource() => instance;

  PaymentMethodByEstablishmentView paymentMethod =
      PaymentMethodByEstablishmentView();
}
