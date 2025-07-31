import 'package:core/core.dart';

class JwtService {
  static Map<String, dynamic> parseToken({required String token, required String secretKey}) {
    if (token.startsWith('Bearer')) {
      token = bearerParse(token);
    }
    final jwt = JWT.verify(token, SecretKey(secretKey));
    return jwt.payload;
  }

  static String bearerParse(String token) => token.substring(7).trim();

  static String generateToken({required String secretKey, required Map<String, dynamic> payload, required Duration expiresIn}) {
    final jwt = JWT(payload);
    return jwt.sign(SecretKey(secretKey), expiresIn: expiresIn);
  }
}
