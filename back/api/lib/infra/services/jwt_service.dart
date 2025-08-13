import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:api/infra/services/process_env.dart';

class JwtService {
  static String generateToken({required Map<String, dynamic> map}) {
    final jwt = JWT(map);
    return jwt.sign(SecretKey(ProcessEnv.secrectKey), expiresIn: Duration(seconds: 60));
  }

  static Response generateJwtResponse({required Map<String, dynamic> map}) {
    final token = generateToken(map: map);
    return Response.json(body: {'token': token});
  }

  static String tokenParse(String token) => token.substring(7).trim();

  static bool _validateJwtPayload(Map payload) {
    return payload['token'] != null;
  }

  static bool validateToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(ProcessEnv.secrectKey));
      if (_validateJwtPayload(jwt.payload)) return true;
      return false;
    } catch (_) {
      return false;
    }
  }
}
