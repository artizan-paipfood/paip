import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IPaymentMethodRepository {
  Future<PaymentMethodByEstablishmentView> getByEstablishmentId(String id);
  Future<PaymentMethodModel> upsert(
      {required PaymentMethodModel paymentMethod, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth});
}
