import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late HipayApi api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = HipayApi(client: client);
  });

  group(
    'HIPAY',
    () {
      test(
        'GERAR PIX PARA PAGAMENTO DE MENSALIDADE DO ESTABELECIMENTO',
        () async {
          final result = await api.createPixEstablishmentInvoice(
            establishmentId: "70173e91fd23439b9b61187064581c1b",
            amount: 1.50,
            description: "Mensalidade",
          );
          expect(
            result,
            isA<PixResponse>(),
          );
        },
      );
      test(
        'PAYMENT STATUS',
        () async {
          final result = await api.paymentStatus(
            id: "in_70173e91fd23439b9b61187064581c1b",
          );
          expect(
            result,
            isA<PaymentStatusResponse>(),
          );
        },
      );
    },
  );
  // setUp code
}
