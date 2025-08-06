import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late UpdateQueusApi api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = UpdateQueusApi(client: client);
  });
  const establishmentId = 'bc4ecd21-ece8-4c06-b183-6ec08d57c388';

  group(
    'CRUD UPDATE QUEUS',
    () {
      final queu = UpdateQueusEntity(
        table: 'orders',
        establishmentId: establishmentId,
        operation: 'upsert',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        data: {
          "hello": "world",
        },
      );
      test(
        'UPSERT',
        () async {
          //Arrange

          //Act
          final result = await api.upsert(
            queus: [
              queu,
            ],
          );
          //Assert
          expect(
            result,
            isA<List<UpdateQueusEntity>>(),
          );
        },
      );
      test(
        'GET',
        () async {
          //Arrange

          //Act
          final result = await api.getById(
            establishmentId: establishmentId,
          );
          //Assert
          expect(
            result,
            isA<UpdateQueusEntity>(),
          );
          await Future.delayed(
            Duration(
              milliseconds: 500,
            ),
          );
        },
      );
      test(
        'DELETE',
        () async {
          //Arrange

          //Act
          await api.delete(
            establishmentId: establishmentId,
          );
          //Assert
        },
      );
    },
  );
}
