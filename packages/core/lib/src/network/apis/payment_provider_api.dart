import 'package:core/core.dart';

class PaymentProviderApi {
  final IClient client;

  PaymentProviderApi({
    required this.client,
  });

  static String table = PaymentProviderEntity.table;

  Future<PaymentProviderEntity> create(
    PaymentProviderEntity paymentProvider,
  ) async {
    final response = await client.post(
      '/rest/v1/$table',
      data: paymentProvider.toMap(),
    );
    final List list = response.data;
    return PaymentProviderEntity.fromMap(
      list.first,
    );
  }
}
