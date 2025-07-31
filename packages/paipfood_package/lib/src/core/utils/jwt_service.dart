import 'package:paipfood_package/paipfood_package.dart';

class JwtService {
  static String buildToken({required Map map, required Duration expiresIn, required String secret}) {
    final jwt = JWT(map);
    return jwt.sign(SecretKey(secret), expiresIn: expiresIn);
  }

  static Map decodeToken({required String token, required String secret}) {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt.payload;
  }

  static Map toMap(String token) {
    return {'token': token};
  }

  static String fromMap(Map map) {
    return map['token'];
  }
}
