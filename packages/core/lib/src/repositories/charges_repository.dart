import 'package:core/core.dart';

abstract interface class IChargesRepository {
  Future<ChargeEntity> getById({required String id});
  Future<List<ChargeEntity>> getChargesByStatus({required ChargeStatus status});
  Future<ChargeEntity> getByOrderId({required String orderId});
  Future<List<ChargeEntity>> upsert({required List<ChargeEntity> charges});
}

class ChargesRepository implements IChargesRepository {
  final IClient client;
  ChargesRepository({required this.client});

  static final String _table = ChargeEntity.table;

  @override
  Future<ChargeEntity> getById({required String id}) async {
    final request = await client.get("/rest/v1/$_table?id=eq.$id&select=*");
    final List list = request.data;
    if (list.isEmpty) {
      throw Exception('Charge not found');
    }
    return ChargeEntity.fromMap(list.first);
  }

  @override
  Future<List<ChargeEntity>> getChargesByStatus({required ChargeStatus status}) async {
    final request = await client.get("/rest/v1/$_table?status=eq.${status.name}&select=*");
    final List list = request.data;
    return list.map((e) => ChargeEntity.fromMap(e)).toList();
  }

  @override
  Future<ChargeEntity> getByOrderId({required String orderId}) async {
    final request = await client.get("/rest/v1/$_table?order_id=eq.$orderId&select=*");
    final List list = request.data;
    if (list.isEmpty) {
      throw Exception('Charge not found');
    }
    return ChargeEntity.fromMap(list.first);
  }

  @override
  Future<List<ChargeEntity>> upsert({required List<ChargeEntity> charges}) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: charges.map((c) => c.toMap()).toList(),
      headers: headerUpsert(),
    );
    final List list = response.data;
    return list.map((e) => ChargeEntity.fromMap(e)).toList();
  }

  Future<void> delete({required String id}) async {
    String query = "id=eq.$id";
    await client.delete("/rest/v1/$_table?$query");
  }
}
