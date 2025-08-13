import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/repositories/address/search_address_repository.dart';
import 'package:core/core.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = PostcodeGeocodeRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context, body),
      _ => await Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    if (e is AppError) return Response.json(statusCode: e.statusCode, body: e.toMap());
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, PostcodeGeocodeRequest body) async {
  final autocompleteRepository = injector.get<ISearchAddressRepository>(key: "${body.locale.name}-address-api");

  final result = await autocompleteRepository.searchByPostalcode(postalCode: body.postalCode, locale: body.locale, lat: body.lat, lon: body.lon, radius: body.radius ?? 30);

  return Response.json(body: result.toMap());
}
