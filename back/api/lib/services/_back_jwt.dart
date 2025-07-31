import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:api/services/process_env.dart';

class BackJwt {
  static String generateToken({required Map<String, dynamic> map}) {
    final jwt = JWT(map);
    return jwt.sign(SecretKey(ProcessEnv.secrectKey), expiresIn: Duration(seconds: 60));
  }

  static Response generateJwtResponse({required Map<String, dynamic> map}) {
    final token = generateToken(map: map);
    return Response.json(body: {'token': token});
  }
}
