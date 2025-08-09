import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class BillingRepository implements IBillingRepository {
  final IClient http;
  BillingRepository({
    required this.http,
  });
  @override
  Future<PlanAndInvoice> getCurrentInvoiceByEstablishmentId(String id) async {
    final req = await http.post(
      "/rest/v1/rpc/func_get_last_invoice_and_plan_by_establishment",
      data: {"p_establishment_id": id},
    );

    return PlanAndInvoice.fromMap(req.data);
  }

  @override
  Future<List<EstablishmentInvoiceModel>> getInvoicesByEstablishmentId(String id) async {
    final req = await http.get("/rest/v1/establishment_invoices?establishment_id=eq.$id&select=*");
    final List list = req.data;
    return Future.value(list.map((invoice) => EstablishmentInvoiceModel.fromMap(invoice)).toList());
  }

  @override
  Future<EstablishmentInvoiceModel> upsert({required EstablishmentInvoiceModel establishmentInvoice, required AuthModel auth}) async {
    final request = await http.post('/rest/v1/establishment_invoices', headers: HttpUtils.headerUpsertAuth(auth), data: establishmentInvoice.toMap());
    final List list = request.data;
    return EstablishmentInvoiceModel.fromMap(list.first);
  }
}
