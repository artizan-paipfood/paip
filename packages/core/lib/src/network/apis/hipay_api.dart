import 'package:core/core.dart';

abstract interface class IHipayApi {
  Future<PaymentStatusResponse> paymentStatus({required String id});
  Future<PixResponse> createPixEstablishmentInvoice({required double amount, required String description, required String establishmentId});
}

class HipayApi implements IHipayApi {
  final IClient client;
  HipayApi({
    required this.client,
  });
  static final String _v1 = '/v1/hipay';

  @override
  Future<PaymentStatusResponse> paymentStatus({
    required String id,
  }) async {
    final response = await client.get('$_v1/transaction/$id/status');
    return PaymentStatusResponse.fromMap(response.data);
  }

  @override
  Future<PixResponse> createPixEstablishmentInvoice({
    required double amount,
    required String description,
    required String establishmentId,
  }) async {
    final response = await client.post(
      '$_v1/establishment_invoice',
      data: {"amount": amount, "description": description, "establishment_id": establishmentId},
    );

    return PixResponse(
      id: response.data['transactionId'],
      qrCode: response.data['qrCode'],
      amount: amount,
    );
  }
}
