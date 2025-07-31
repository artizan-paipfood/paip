import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

import '../../../../paipfood_package.dart';

class EstablishmentRepository implements IEstablishmentRepository {
  final IClient http;
  EstablishmentRepository({
    required this.http,
  });

  @override
  Future<CompanyModel> insertCompany({required CompanyModel company, required AuthModel auth}) async {
    company = company.copyWith(userAdminId: auth.user!.id);

    final request = await http.post(
      "/rest/v1/companies",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
      data: company.toJson(),
    );

    final List list = request.data;
    return list
        .map((company) {
          return CompanyModel.fromMap(company);
        })
        .toList()
        .first;
  }

  @override
  Future<EstablishmentModel> insertEstablishment({required EstablishmentModel establishment, required AuthModel auth, required String companySlug}) async {
    establishment = establishment.copyWith(companySlug: companySlug, email: auth.user!.email);

    final request = await http.post(
      "/rest/v1/establishments",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
      data: establishment.toJson(),
    );

    final List list = request.data;
    return list
        .map((establishment) {
          return EstablishmentModel.fromMap(establishment);
        })
        .toList()
        .first;
  }

  @override
  Future<void> deleteCompany({required CompanyModel company, required AuthModel auth}) async {
    await http.delete(
      "/rest/v1/companies?slug=eq.${company.slug}",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }

  @override
  Future<void> deleteEstablishment({required EstablishmentModel establishment, required AuthModel auth}) async {
    await http.delete(
      "/rest/v1/establishments?id=eq.${establishment.id}",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }

  @override
  Future<List<CompanyModel>> getCompanies({RangeModel? range}) async {
    final request = await http.get(
      "/rest/v1/companies?select=*",
      headers: range?.toMap(),
    );
    return request.data.map<CompanyModel>((company) {
      return CompanyModel.fromMap(company);
    }).toList();
  }

  @override
  Future<CompanyModel?> getCompanyBySlug(String slug) async {
    final request = await http.get("/rest/v1/companies?slug=eq.$slug&select=*");
    final List list = request.data;
    if (list.isEmpty) return null;
    return list
        .map<CompanyModel>((companie) {
          return CompanyModel.fromMap(companie);
        })
        .toList()
        .first;
  }

  @override
  Future<EstablishmentModel> getDataEstablishmentById(String id) async {
    final request = await http.get("/rest/v1/view_data_establishment?id=eq.$id&select=*");
    final List list = request.data;
    return list
        .map<EstablishmentModel>((companie) {
          return EstablishmentModel.fromMap(companie);
        })
        .toList()
        .first;
  }

  @override
  Future<List<ShortEstablishmentDto>> getShortEstablishmentsBySlug(String slug) async {
    final request = await http.get(
      "/rest/v1/view_short_establishment?company_slug=eq.$slug&select=*",
    );
    final List list = request.data;
    return list.map<ShortEstablishmentDto>((establishment) {
      return ShortEstablishmentDto.fromMap(establishment);
    }).toList();
  }

  @override
  Future<CompanyModel> updateCompany({required CompanyModel company, required AuthModel auth}) async {
    final request = await http.patch(
      "/rest/v1/companies?slug=eq.${company.slug}",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
      data: company.toMap(),
    );

    final List list = request.data;
    return list
        .map((company) {
          return CompanyModel.fromMap(company);
        })
        .toList()
        .first;
  }

  @override
  Future<EstablishmentModel> updateEstablishment({required EstablishmentModel establishment, required String authToken}) async {
    final request = await http.patch(
      "/rest/v1/establishments?id=eq.${establishment.id}",
      headers: {"Authorization": "Bearer $authToken"},
      data: establishment.toMap(),
    );

    final List list = request.data;
    return list
        .map((establishment) {
          return EstablishmentModel.fromMap(establishment);
        })
        .toList()
        .first;
  }

  @override
  Future<bool> slugExists(String slug) async {
    final request = await http.post(
      "/rest/v1/rpc/func_slug_exists",
      headers: {"Authorization": "Bearer ${Env.supaApiKey}"},
      data: {"slug_company": Utils.onlyAlphanumeric(slug, undereline: true)},
    );
    return request.data;
  }

  @override
  Future<Map<String, dynamic>> getMenuByEstablishmentId({required String establishmentId, bool onlyVidible = false}) async {
    String queryVisible = '';
    if (onlyVidible) queryVisible = '_visible';
    final request = await http.get(
      "/rest/v1/menu_by_establishment${queryVisible}_view?id=eq.$establishmentId&select=*",
    );
    final List list = request.data;
    return list.first;
  }

  @override
  Future<EstablishmentModel> updateEstablishmentPaymentProvider({required String establishmentId, required String userAcessToken, required Map<String, dynamic> paymentProvider}) async {
    final request = await http.patch(
      "/rest/v1/establishments?id=eq.$establishmentId",
      headers: {"Authorization": "Bearer $userAcessToken"},
      data: {"payment_provider": paymentProvider},
    );
    final List list = request.data;
    return EstablishmentModel.fromMap(list.first);
  }
}
