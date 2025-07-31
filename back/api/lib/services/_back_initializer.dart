import 'package:api/services/hive/hive_initializer.dart';
import 'package:api/l10n/i18n.dart';
import 'package:api/services/_back_injectors.dart';
import 'package:api/services/stripe_process_payments_cron.dart';

class BackInitializer {
  BackInitializer._();
  static void init() {
    I18n.instance.initialize();
    HiveInitializer.init();
    BackInjector.initialize();
    StripeProcessPaymentsCron.instance.initialize();
  }
}
