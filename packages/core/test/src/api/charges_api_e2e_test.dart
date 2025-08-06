import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late IClient client;

  late ChargesRepository api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = ChargesRepository(client: client);
  });

  group(
    'CRUD CHARGES',
    () {
      final charge = ChargeEntity(
        id: Uuid().v4(),
        locale: AppLocaleCode.br,
        amount: 100,
        orderId: '279a8522-db56-4073-988e-b4adbb16750e',
        status: ChargeStatus.pending,
        paymentProvider: PaymentProvider.stripe,
        paymentId: 'abc-123',
        metadata: {
          "hello": "world",
        },
      );
      test(
        'UPSERT',
        () async {
          //Arrange

          //Act
          final result = await api.upsert(
            charges: [
              charge,
            ],
          );
          //Assert
          expect(
            result,
            isA<List<ChargeEntity>>(),
          );
        },
      );
      test(
        'GET',
        () async {
          //Arrange

          //Act
          final result = await api.getByOrderId(
            orderId: charge.orderId!,
          );
          //Assert
          expect(
            result,
            isA<ChargeEntity>(),
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
            id: charge.id,
          );
          //Assert
        },
      );
    },
  );

  test(
    'GET CHARGES BY STATUS',
    () async {
      final result = await api.getChargesByStatus(
        status: ChargeStatus.paid,
      );

      final allPaid = result.every(
        (
          element,
        ) =>
            element.status == ChargeStatus.paid,
      );

      expect(
        result,
        isA<List<ChargeEntity>>(),
      );
      expect(
        allPaid,
        true,
      );
    },
  );
}
