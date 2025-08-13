import 'dart:io';

import 'package:api/infra/services/jwt_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware validateJwt() {
  return (handler) {
    return (context) async {
      final authorizationHeader = context.request.headers['Authorization'];

      if (authorizationHeader == null || !authorizationHeader.startsWith('Bearer ')) {
        return Response(statusCode: HttpStatus.unauthorized, body: 'Missing or malformed token');
      }

      final token = JwtService.tokenParse(authorizationHeader);

      if (!JwtService.validateToken(token)) {
        return Response(statusCode: HttpStatus.unauthorized, body: 'Unauthorized');
      }

      return handler(context);
    };
  };
}
