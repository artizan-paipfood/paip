import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late IClient client;

  late PaymentProviderApi api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = PaymentProviderApi(client: client);
  });

  // Arrange

  test(
    'CREATE PAYMENT PROVIDER',
    () async {
      //Arrange

      //Act
      final result = await api.create(
        PaymentProviderEntity(
          id: Uuid().v4(),
        ),
      );
      //Assert
      expect(
        result,
        isA<PaymentProviderEntity>(),
      );
    },
  );
}
