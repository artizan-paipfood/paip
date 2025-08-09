import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentMethodRepository implements IPaymentMethodRepository {
  final IClient http;
  PaymentMethodRepository({required this.http});
  final table = 'payment_methods';
  @override
  Future<PaymentMethodByEstablishmentView> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/view_payment_methods_by_establishment?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list
        .map<PaymentMethodByEstablishmentView>((product) {
          return PaymentMethodByEstablishmentView.fromMap(product);
        })
        .toList()
        .first;
  }

  @override
  Future<PaymentMethodModel> upsert({required PaymentMethodModel paymentMethod, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: paymentMethod.toMap(),
    );
    final List list = request.data;
    return PaymentMethodModel.fromMap(list.first);
  }

  @override
  Future<void> delete({required String id, required AuthModel auth}) async {
    await http.delete(
      "/rest/v1/$table?id=eq.$id",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }
}
