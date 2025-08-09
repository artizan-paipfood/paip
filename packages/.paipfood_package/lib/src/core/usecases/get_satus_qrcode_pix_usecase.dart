import 'package:paipfood_package/paipfood_package.dart';

class GetStatusQrcodePixUsecase {
  final IMercadoPagoRepository mercadoPagoRepo;

  GetStatusQrcodePixUsecase({required this.mercadoPagoRepo});
  Future<bool> call({required String paymentId, required String token}) async {
    final status = await mercadoPagoRepo.getPaymentStatus(token: token, paymentId: paymentId);
    if (status == 'approved') return true;
    return false;
  }
}
