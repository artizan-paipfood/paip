import 'package:paipfood_package/paipfood_package.dart';

class CompanyPageViewmodel {
  final EstablishmentRepository repository;
  CompanyPageViewmodel({required this.repository});

  Future<List<ShortEstablishmentDto>> getShorEstablishmentsBySlug(String slug) async {
    return await repository.getShortEstablishmentsBySlug(slug);
  }
}
