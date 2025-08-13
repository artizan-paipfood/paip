import 'package:api/infra/services/hive/hive_initializer.dart';
import 'package:api/core/l10n/i18n.dart';
import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/services/stripe_process_payments_cron.dart';

class BackInitializer {
  BackInitializer._();
  static void init() {
    I18n.instance.initialize();
    HiveInitializer.init();
    BackInjector.initialize();
    StripeProcessPaymentsCron.instance.initialize();
  }
}
