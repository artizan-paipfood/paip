import 'package:core/core.dart';
import 'package:core/src/helpers/base_options.dart';
import 'package:core/src/helpers/env.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late VerificationCodeApi api;

  setUp(() async {
    await Env.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: PaipBaseOptions.supabase);
    api = VerificationCodeApi(client: client, jwtSecretKey: Env.secretKey);
  });

  group(
    'VERIFICATION CODE',
    () {
      test(
        'WHATSAPP',
        () async {
          //Act
          final result = await api.sendWhatsapp(
            locale: DbLocale.br,
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
