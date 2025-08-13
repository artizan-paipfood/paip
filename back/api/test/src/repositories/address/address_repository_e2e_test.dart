import 'package:api/apis/adress/geoapify_api.dart';
import 'package:api/constants/base_url.dart';
import 'package:api/infra/services/process_env.dart';
import 'package:api/infra/repositories/address/delivery_repository.dart';
import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;
  late IDeliveryRepository repository;
  late GeoApifyApi geoApifyApi;

  setUp(() async {
    await ProcessEnv.initializeForTest(envFilePath: '.env');
    client = ClientDio(baseOptions: DioBaseOptions.supabase);
    geoApifyApi = GeoApifyApi(client: client);
    repository = AddressRepository(client: client, geoApifyApi: geoApifyApi);
  });

  group('AddressRepository', () {
    test('getDeliveryTaxByDistance() deve retornar o valor da taxa de entrega', () async {
      final result = await repository.getTaxByDistance(establishmentId: '7e92e0e7-4a09-43d1-90e6-4a1e98a1cc03', distanceRadius: 8.56);
      expect(result, isA<double>());
    });
    test('getDeliveryTaxByDistance() deve retornar uma exceção se a distância não for permitida', () async {
      expect(
        () => repository.getTaxByDistance(establishmentId: '7e92e0e7-4a09-43d1-90e6-4a1e98a1cc03', distanceRadius: 100),
        throwsA(isA<GenericException>()),
      );
    });
  });
}
