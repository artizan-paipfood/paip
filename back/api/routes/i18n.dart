import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:core/core.dart';
import 'package:api/l10n/i18n.dart';

import 'package:api/extensions/db_locale_extension.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    return switch (context.request.method) {
      HttpMethod.post => _onPost(context),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;
  final body = I18nRequest.fromMap(data);

  final locale = DbLocale.fromMap(body.locale);

  return Response.json(body: {'result': I18n.testI18n(locale.language, name: body.name)});
}

class I18nRequest {
  final String locale;
  final String name;
  I18nRequest({required this.locale, required this.name});

  factory I18nRequest.fromMap(Map<String, dynamic> map) {
    return I18nRequest(locale: map['locale'] ?? '', name: map['name'] ?? '');
  }
}
