import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/_back_injectors.dart';
import 'package:api/repositories/address/search_address/search_address_repository.dart';
import 'package:core/core.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = PostalcodeGeocodeRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context, body),
      _ => Future.value(Response(
          statusCode: HttpStatus.methodNotAllowed,
        )),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, PostalcodeGeocodeRequest body) async {
  final autocompleteRepository = injector.get<ISearchAddressRepository>(key: "${body.locale.name}-address-api");

  final result = await autocompleteRepository.searchByPostalcode(postalCode: body.postalCode, locale: body.locale, lat: body.lat, lon: body.lon, radius: body.radius);

  return Response.json(body: result.toMap());
}
