import 'package:core/core.dart';
import 'package:core/src/helpers/test_base_options.dart';
import 'package:core/src/helpers/env_test.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late VerificationCodeApi api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = VerificationCodeApi(client: client, jwtSecretKey: EnvTest.secretKey);
  });

  group(
    'VERIFICATION CODE',
    () {
      test(
        'WHATSAPP',
        () async {
          //Act
          final result = await api.sendWhatsapp(
            locale: AppLocaleCode.br,
            phone: "5535984091567",
          );
          //Assert
          expect(
            result,
            isA<String>(),
          );
        },
      );
    },
  );
  // setUp code
}
