import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late EstablishmentInvoiceRepository api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = EstablishmentInvoiceRepository(client: client);
  });

  group(
    'ESTABLISHMENT INVOICE API',
    () {
      test(
        'GET VIEW',
        () async {
          final result = await api.getLastInvoiceAndPlan(
            establishmentId: '7e92e0e7-4a09-43d1-90e6-4a1e98a1cc03',
          );
          expect(
            result,
            isA<LastInvoiceAndPlanView>(),
          );
        },
      );
    },
  );
}
