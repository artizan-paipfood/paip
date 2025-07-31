import 'package:core/core.dart';

class UpdateQueusApi {
  final IClient client;
  UpdateQueusApi({
    required this.client,
  });

  static final String _table = UpdateQueusEntity.tableDB;

  Future<UpdateQueusEntity> getById({
    required String establishmentId,
  }) async {
    final request = await client.get(
      "/rest/v1/$_table?establishment_id=eq.$establishmentId&select=*&limit=1",
    );
    final List list = request.data;
    if (list.isEmpty) {
      throw Exception('Queus not found');
    }
    return UpdateQueusEntity.fromMap(list.first);
  }

  Future<List<UpdateQueusEntity>> upsert({
    required List<UpdateQueusEntity> queus,
  }) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: queus.map((c) => c.toMap()).toList(),
      headers: headerUpsert(),
    );
    final List list = response.data;
    return list.map((e) => UpdateQueusEntity.fromMap(e)).toList();
  }

  Future<void> delete({
    required String establishmentId,
  }) async {
    String query = "establishment_id=eq.$establishmentId";
    await client.delete(
      "/rest/v1/$_table?$query",
    );
  }
}
