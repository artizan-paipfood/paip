import 'package:core/core.dart';

class LayoutPrinterApi {
  final IClient client;
  LayoutPrinterApi({
    required this.client,
  });

  static final String _table = PrinterLayoutEntity.table;

  Future<List<PrinterLayoutEntity>> getByEstablishmentId({
    required String id,
  }) async {
    final request = await client.get(
      "/rest/v1/$_table?establishment_id=eq.$id&select=*",
    );
    final List list = request.data;
    return list.map((r) => PrinterLayoutEntity.fromMap(r)).toList();
  }

  Future<List<PrinterLayoutEntity>> upsert({
    required List<PrinterLayoutEntity> layoutPrinters,
  }) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: layoutPrinters.map((l) => l.toMap()).toList(),
      headers: headerUpsert(),
    );
    final List list = response.data;
    return list.map((e) => PrinterLayoutEntity.fromMap(e)).toList();
  }

  Future<void> delete({
    required String id,
  }) async {
    String query = "id=eq.$id";
    await client.delete(
      "/rest/v1/$_table?$query",
    );
  }
}
