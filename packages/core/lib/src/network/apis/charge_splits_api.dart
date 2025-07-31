import 'package:core/src/network/apis/zz_api_export.dart';
import 'package:core/src/network/client/clien_exports.dart';
import 'package:core/src/entities/zz_entities_export.dart';
import 'package:core/src/enums/split_destination_type.dart';

class ChargeSplitApi {
  final IClient client;
  ChargeSplitApi({
    required this.client,
  });
  static final String _table = ChargeSplitEntity.table;

  Future<List<ChargeSplitEntity>> getByChargeId({
    required String chargeId,
  }) async {
    final request = await client.get("/rest/v1/$_table?charge_id=eq.$chargeId&select=*");
    final List list = request.data;
    if (list.isEmpty) {
      throw Exception('Charge not found');
    }
    return list.map((e) => ChargeSplitEntity.fromMap(e)).toList();
  }

  Future<List<ChargeSplitEntity>> upsert({
    required List<ChargeSplitEntity> charges,
  }) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: charges.map((c) => c.toMap()).toList(),
      headers: headerUpsert(),
    );
    final List list = response.data;
    return list.map((e) => ChargeSplitEntity.fromMap(e)).toList();
  }

  Future<void> delete({
    required String chargeId,
    required SplitDestinationType destinationType,
  }) async {
    String query = "charge_id=eq.$chargeId&destination_type=eq.${destinationType.name}";
    await client.delete(
      "/rest/v1/$_table?$query",
    );
  }
}
