import 'package:core/core.dart';
import 'package:core/src/helpers/base_options.dart';
import 'package:core/src/helpers/env.dart';
import 'package:test/test.dart';

void main() {
  late StripeApi api;
  late IClient client;

  // Arrange
  const String accountId = 'acct_1Qj3Z6P6vlVCDVZ2';
  const String country = 'br';

  setUp(() async {
    await Env.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: PaipBaseOptions.supabase);
    api = StripeApi(client: client);
  });

  group(
    'STRIPE',
    () {
      test(
        'ACCOUNT STATUS',
        () async {
          //Act
          final result = await api.accountStatus(
            accountId: accountId,
            country: country,
          );
          //Assert
          expect(
            result,
            isA<StripeAccountStatusResponse>(),
          );
        },
      );

      test(
        'CREATE ACCOUNT',
        () async {
          //Act
          final result = await api.createAccount(
            country: country,
          );
          //Assert
          expect(
            result,
            isA<StripeCreateAccountResponse>(),
          );
        },
      );

      test(
        'BUILD ACCOUNT LINK',
        () async {
          //Act
          final result = await api.buildAccountLink(
            accountId: accountId,
            country: country,
          );
          //Assert
          expect(
            result,
            isA<String>(),
          );
          // expect(result, result.contains('https://'));
        },
      );

      test(
        'CHECKOUT CREATE SESSION',
        () async {
          //Act
          final result = await api.checkoutCreateSession(
            amount: 20,
            cancelUrl: 'https://example.com/cancel',
            description: 'Order-1',
            locale: DbLocale.br,
            chargeId: 'abcd-1234',
            successUrl: 'https://example.com/success',
          );
          //Assert
          expect(
            result,
            isA<StripeCheckoutCreateSessionResponse>(),
          );
          // expect(result, result.contains('https://'));
        },
      );
    },
  );
  // setUp code
}
