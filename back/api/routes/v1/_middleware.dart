import 'package:dart_frog/dart_frog.dart';
import 'package:api/middlewares/_cors_middleware.dart';
import 'package:api/middlewares/_validate_jwt.dart';

Handler middleware(Handler handler) {
  return handler.use(validateJwt()).use(requestLogger()).use(corsHeaders());
  // return handler.use(requestLogger()).use(corsHeaders());
}
