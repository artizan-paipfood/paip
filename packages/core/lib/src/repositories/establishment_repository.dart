import 'package:core/core.dart';
import 'package:core/src/entities/establishment_entity.dart';

abstract interface class IEstablishmentRepository {
  Future<EstablishmentEntity> getById({required String id});
  Future<EstablishmentEntity> upsert({required EstablishmentEntity establishment, required String authToken});
  Future<EstablishmentGestView> getEstablishmentGestView({required String id});
}

class EstablishmentRepository implements IEstablishmentRepository {
  final IClient client;

  EstablishmentRepository({required this.client});

  final String _table = EstablishmentEntity.table;

  @override
  Future<EstablishmentEntity> getById({required String id}) async {
    final response = await client.get('/rest/v1/$_table?id=eq.$id&select=*');
    final List list = response.data;
    if (list.isEmpty) {
      throw Exception('Establishment not found');
    }
    return EstablishmentEntity.fromJson(list.first);
  }

  @override
  Future<EstablishmentEntity> upsert({required EstablishmentEntity establishment, required String authToken}) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: establishment.toMap(),
      headers: headerUpsert()
        ..addAll(
          {'Authorization': 'Bearer $authToken'},
        ),
    );
    final List list = response.data;
    return EstablishmentEntity.fromJson(list.first);
  }

  @override
  Future<EstablishmentGestView> getEstablishmentGestView({required String id}) async {
    final response = await client.get('/rest/v1/${EstablishmentGestView.view}?id=eq.$id&select=*');
    final List list = response.data;
    if (list.isEmpty) {
      throw Exception('Establishment not found');
    }
    return EstablishmentGestView.fromJson(list.first);
  }
}
