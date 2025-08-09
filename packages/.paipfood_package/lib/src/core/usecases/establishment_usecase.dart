import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentUsecase {
  final IEstablishmentRepository repository;
  EstablishmentUsecase({
    required this.repository,
  });

  Future<EstablishmentModel> save({required EstablishmentModel establishment, required AuthModel auth}) async {
    return await repository.updateEstablishment(establishment: establishment, authToken: auth.accessToken!);
  }
}
