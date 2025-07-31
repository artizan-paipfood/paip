import 'package:core/core.dart';

abstract interface class IEstablishmentInvoiceRepository {
  Future<List<EstablishmentInvoiceEntity>> getByEstablishmentId({required String id});

  Future<EstablishmentInvoiceEntity> getById({required String id});

  Future<EstablishmentInvoiceEntity> upsert({required EstablishmentInvoiceEntity establishmentInvoice, required String authToken});

  Future<LastInvoiceAndPlanView?> getLastInvoiceAndPlan({required String establishmentId});
}

class EstablishmentInvoiceRepository implements IEstablishmentInvoiceRepository {
  final IClient client;
  EstablishmentInvoiceRepository({required this.client});

  static final String _table = EstablishmentInvoiceEntity.table;

  @override
  Future<List<EstablishmentInvoiceEntity>> getByEstablishmentId({required String id}) async {
    final request = await client.get("/rest/v1/$_table?establishment_id=eq.$id&select=*");

    final List list = request.data;

    return list.map((r) => EstablishmentInvoiceEntity.fromMap(r)).toList();
  }

  @override
  Future<EstablishmentInvoiceEntity> getById({required String id}) async {
    final request = await client.get("/rest/v1/$_table?id=eq.$id&select=*");

    final List list = request.data;

    return EstablishmentInvoiceEntity.fromMap(list.first);
  }

  @override
  Future<EstablishmentInvoiceEntity> upsert({required EstablishmentInvoiceEntity establishmentInvoice, required String authToken}) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: establishmentInvoice.toMap(),
      headers: headerUpsert()
        ..addAll(
          {'Authorization': 'Bearer $authToken'},
        ),
    );
    final List list = response.data;

    return EstablishmentInvoiceEntity.fromMap(list.first);
  }

  @override
  Future<LastInvoiceAndPlanView?> getLastInvoiceAndPlan({required String establishmentId}) async {
    final request = await client.get(
      "/rest/v1/${LastInvoiceAndPlanView.viewName}?establishment_id=eq.$establishmentId&select=*&limit=1",
    );
    final List list = request.data;

    if (list.isEmpty) return null;

    return LastInvoiceAndPlanView.fromMap(list.first);
  }
}
