export '../../repositories/charges_repository.dart';
export 'address_api.dart';
export 'auth_api.dart';
export 'charge_splits_api.dart';
export 'evolution/i_evolution_api.dart';
export 'hipay_api.dart';
export 'layout_printer_api.dart';
export 'payment_provider_api.dart';
export 'payment_provider_stripe_api.dart';
export 'stripe_api.dart';
export 'update_queus_api.dart';
export 'verification_code_api.dart';
export 'views_api.dart';

Map<String, dynamic> headerUpsert() {
  return {
    "Prefer": ["resolution=merge-duplicates", "return=representation"]
  };
}
