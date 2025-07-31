import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IEstablishmentRepository {
  Future<CompanyModel> insertCompany({required CompanyModel company, required AuthModel auth});
  Future<CompanyModel> updateCompany({required CompanyModel company, required AuthModel auth});
  Future<CompanyModel?> getCompanyBySlug(String slug);
  Future<List<CompanyModel>> getCompanies({RangeModel? range});
  Future<void> deleteCompany({required CompanyModel company, required AuthModel auth});
  Future<EstablishmentModel> insertEstablishment({required EstablishmentModel establishment, required AuthModel auth, required String companySlug});
  Future<EstablishmentModel> updateEstablishment({required EstablishmentModel establishment, required String authToken});
  Future<EstablishmentModel> updateEstablishmentPaymentProvider(
      {required String establishmentId, required String userAcessToken, required Map<String, dynamic> paymentProvider});
  Future<void> deleteEstablishment({required EstablishmentModel establishment, required AuthModel auth});
  Future<EstablishmentModel?> getDataEstablishmentById(String id);
  Future<List<ShortEstablishmentDto>> getShortEstablishmentsBySlug(String slug);
  Future<bool> slugExists(String slug);
  Future<Map<String, dynamic>> getMenuByEstablishmentId({required String establishmentId, bool onlyVidible = false});
}
