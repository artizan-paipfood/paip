import 'package:paipfood_package/paipfood_package.dart';

abstract interface class ICustomFunctionsRepository {
  Future<PaymentProviderInvoiceModel> generatePixSplit(
      {required double value, required EstablishmentModel establishment, required String userId, String? title});
  Future<void> refoundPayment({required String paymentId, required double value, required EstablishmentModel establishment});
  Future<PaymentProviderInvoiceModel> generatePixEstablishmentInvoice({required double value, required EstablishmentModel establishment});
}
