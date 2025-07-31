import 'package:core/core.dart';

abstract interface class IEstablishmentPreferencesRepository {
  Future<EstablishmentPreferencesEntity> getById({required String establishmentId});
  Future<EstablishmentPreferencesEntity> upsert({required EstablishmentPreferencesEntity establishmentPreferences});
}

class EstablishmentPreferencesRepository implements IEstablishmentPreferencesRepository {
  final IClient client;

  EstablishmentPreferencesRepository({required this.client});

  static const String _table = EstablishmentPreferencesEntity.table;

  @override
  Future<EstablishmentPreferencesEntity> getById({required String establishmentId}) async {
    final response = await client.get('/rest/v1/$_table?establishment_id=eq.$establishmentId&select=*');
    final List list = response.data;
    if (list.isEmpty) {
      throw Exception('Establishment preferences not found');
    }
    return EstablishmentPreferencesEntity.fromMap(list.first);
  }

  @override
  Future<EstablishmentPreferencesEntity> upsert({required EstablishmentPreferencesEntity establishmentPreferences}) async {
    final response = await client.post(
      '/rest/v1/$_table',
      data: establishmentPreferences.toMap(),
      headers: headerUpsert(),
    );
    final List list = response.data;
    return EstablishmentPreferencesEntity.fromMap(list.first);
  }
}
