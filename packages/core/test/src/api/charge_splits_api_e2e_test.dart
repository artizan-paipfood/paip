import 'package:core/core.dart';
import 'package:core/src/helpers/base_options.dart';
import 'package:core/src/helpers/env.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late ChargeSplitApi api;

  setUp(() async {
    await Env.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: PaipBaseOptions.supabase);
    api = ChargeSplitApi(client: client);
  });

  group(
    'CRUD CHARGE_SPLITS',
    () {
      final chargeSplit = ChargeSplitEntity(
        splitDestinationType: SplitDestinationType.establishment,
        amount: 100,
        chargeId: '6ea7f22d-4fe1-4229-b8cb-19467999f126',
        destinationId: 'abc-123',
        status: ChargeStatus.pending,
        paymentProvider: PaymentProvider.stripe,
        transactionId: "abcsd",
        updatedAt: DateTime.now(),
      );

      test(
        'UPSERT',
        () async {
          //Arrange

          //Act
          final result = await api.upsert(
            charges: [
              chargeSplit,
            ],
          );
          //Assert
          expect(
            result,
            isA<List<ChargeSplitEntity>>(),
          );
        },
      );
      test(
        'GET',
        () async {
          //Arrange

          //Act
          final result = await api.getByChargeId(
            chargeId: chargeSplit.chargeId,
          );
          //Assert
          expect(
            result,
            isA<List<ChargeSplitEntity>>(),
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
            chargeId: chargeSplit.chargeId,
            destinationType: chargeSplit.splitDestinationType,
          );
          //Assert
        },
      );
    },
  );
}
