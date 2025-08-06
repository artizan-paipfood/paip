import 'package:core/core.dart';

class StripeApi {
  final IClient client;
  StripeApi({
    required this.client,
  });

  static final String _v1 = '/v1/stripe';

  Future<StripeAccountStatusResponse> accountStatus({
    required String accountId,
    required String country,
  }) async {
    final response = await client.post(
      '$_v1/account_status',
      data: {
        'account_id': accountId,
        'country': country,
      },
    );

    return StripeAccountStatusResponse.fromMap(
      response.data,
    );
  }

  Future<String> buildAccountLink({
    required String accountId,
    required String country,
  }) async {
    final response = await client.post(
      '$_v1/build_account_link',
      data: {
        'account_id': accountId,
        'country': country,
      },
    );

    return response.data['link'];
  }

  Future<StripeCreateAccountResponse> createAccount({
    required String country,
  }) async {
    final response = await client.post(
      '$_v1/create_account',
      data: {
        'country': country,
      },
    );

    return StripeCreateAccountResponse.fromMap(
      response.data,
    );
  }

  Future<StripeCheckoutCreateSessionResponse> checkoutCreateSession({
    required String description,
    required double amount,
    required AppLocaleCode locale,
    required String chargeId,
    required String successUrl,
    required String cancelUrl,
  }) async {
    final response = await client.post(
      '$_v1/checkout_create_session',
      data: {
        'description': description,
        'amount': amount,
        'country': locale.name,
        'charge_id': chargeId,
        'success_url': successUrl,
        'cancel_url': cancelUrl,
      },
    );
    return StripeCheckoutCreateSessionResponse.fromMap(
      response.data,
    );
  }
}
