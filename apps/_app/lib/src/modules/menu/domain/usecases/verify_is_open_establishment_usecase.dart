import 'package:paipfood_package/paipfood_package.dart';

class VerifyIsOpenEstablishmentUsecase {
  final IEstablishmentRepository establishmentRepo;
  VerifyIsOpenEstablishmentUsecase({required this.establishmentRepo});
  Future<bool> call(String establishmentId) async {
    final establishment = await establishmentRepo.getDataEstablishmentById(establishmentId);
    return establishment!.isOpen;
  }
}
