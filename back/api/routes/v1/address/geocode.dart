import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/repositories/address/search_address_repository.dart';
import 'package:core/core.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = GeocodeRequest.fromMap(data);

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

Future<Response> _onPost(RequestContext context, GeocodeRequest body) async {
  final autocompleteRepository = injector.get<ISearchAddressRepository>(key: "${body.locale.name}-address-api");

  final result = await autocompleteRepository.geocode(query: body.query, address: body.address, locale: body.locale, lat: body.lat, lon: body.lon, radius: body.radius ?? 30);

  return Response.json(body: result.toMap());
}
