import 'package:core/core.dart';
import 'package:core/src/helpers/base_options.dart';
import 'package:core/src/helpers/env.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late PaymentProviderStripeApi api;

  setUp(() async {
    await Env.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: PaipBaseOptions.supabase);
    api = PaymentProviderStripeApi(client: client);
  });

  const String paymentProviderId = '38058325-cec6-4e4a-b33b-443e719d9d0c';
  const String accountId = 'abc-123';

  group(
    'CRUD PAYMENT PROVIDER STRIPE',
    () {
      final paymentProvider = PaymentProviderStripeEntity(
        paymentProviderId: paymentProviderId,
        accountId: accountId,
        fixedFee: 0.03,
        status: PaymentProviderAccountStatus.pending,
      );
      test(
        'UPSERT',
        () async {
          //Arrange

          //Act
          final result = await api.upsert(
            paymentProviders: [
              paymentProvider,
            ],
            authToken: '',
          );
          //Assert
          expect(
            result,
            isA<List<PaymentProviderStripeEntity>>(),
          );
        },
      );
      test(
        'GET',
        () async {
          //Arrange

          //Act
          final result = await api.getByPaymentProviderId(
            paymentProviderId: paymentProviderId,
          );
          //Assert
          expect(
            result,
            isA<PaymentProviderStripeEntity>(),
          );
        },
      );
      test(
        'DELETE',
        () async {
          //Arrange

          //Act
          await api.delete(
            paymentProviderId: paymentProviderId,
          );
          //Assert
        },
      );
    },
  );
}
