import 'package:core/core.dart';

class PaymentProviderStripeApi {
  final IClient client;
  PaymentProviderStripeApi({
    required this.client,
  });

  static final String _table = PaymentProviderStripeEntity.table;

  Future<PaymentProviderStripeEntity> getByPaymentProviderId({
    required String paymentProviderId,
  }) async {
    final request = await client.get(
      "/rest/v1/$_table?payment_provider_id=eq.$paymentProviderId&select=*",
    );
    final List list = request.data;
    if (list.isEmpty) {
      throw Exception(
        'Charge not found',
      );
    }
    return PaymentProviderStripeEntity.fromMap(
      list.first,
    );
  }

  Future<List<PaymentProviderStripeEntity>> upsert({
    required List<PaymentProviderStripeEntity> paymentProviders,
    required String authToken,
  }) async {
    final headers = headerUpsert();
    headers['Authorization'] = 'Bearer $authToken';
    final response = await client.post(
      '/rest/v1/$_table',
      data: paymentProviders.map((e) => e.toMap()).toList(),
      headers: headers,
    );
    final List list = response.data;
    return list.map((e) => PaymentProviderStripeEntity.fromMap(e)).toList();
  }

  Future<void> delete({
    required String paymentProviderId,
  }) async {
    String query = "payment_provider_id=eq.$paymentProviderId";
    await client.delete(
      "/rest/v1/$_table?$query",
    );
  }
}
