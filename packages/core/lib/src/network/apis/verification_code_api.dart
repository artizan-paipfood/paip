import 'package:core/core.dart';

class VerificationCodeApi {
  final IClient client;
  final String jwtSecretKey;
  VerificationCodeApi({
    required this.client,
    required this.jwtSecretKey,
  });
  static final String _v1 = '/v1/verification_code';

  Future<String> sendWhatsapp({
    required AppLocaleCode locale,
    required String phone,
  }) async {
    final response = await client.post(
      '$_v1/whatsapp',
      data: {
        "locale": locale.name,
        "phone": phone,
      },
    );
    final token = response.data['token'];
    final map = JwtService.parseToken(
      token: token,
      secretKey: jwtSecretKey,
    );
    return map['code'];
  }
}
