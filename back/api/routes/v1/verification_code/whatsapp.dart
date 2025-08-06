import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:core/core.dart';
import 'package:api/services/whatsapp_verification_code.dart';
import 'package:api/services/_back_jwt.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = VerificationCodeRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context, body),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, VerificationCodeRequest body) async {
  final service = WhatsappVerificationCode.instance;
  final number = body.phone.onlyNumbers();
  final code = await service.sendCode(locale: body.locale, phone: number);
  return BackJwt.generateJwtResponse(map: {'code': code});
}

class VerificationCodeRequest {
  final AppLocaleCode locale;
  final String phone;

  VerificationCodeRequest({required this.locale, required this.phone});

  factory VerificationCodeRequest.fromMap(Map<String, dynamic> map) {
    return VerificationCodeRequest(phone: map['phone'], locale: AppLocaleCode.fromMap(map['locale']));
  }
}
