import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IMercadoPagoRepository {
  Uri getUrlConfig({required String establishmentId, required String userAccessToken});
  Future<MercadoPagoModel> getToken(String code);
  Future<MercadoPagoModel> refreshToken(String refreshToken);
  Future<PaymentProviderInvoiceModel> generatePix({
    required double value,
    required EstablishmentModel establishment,
    required String userId,
    String? title,
    String? email,
  });
  Future<String> getPaymentStatus({required String token, required String paymentId});
  Future<List<String>> getPaymentMethods(String token);
  Future<void> refoundPayment({required String token, required String paymentId, required double value});
}
