import 'package:dart_frog/dart_frog.dart';
import 'package:api/middlewares/_validate_jwt.dart';

Handler middleware(Handler handler) {
  return handler.use(validateJwt());
}
