import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/back_injector.dart';
import 'package:api/domain/usecases/distance_delivery_usecase.dart';
import 'package:core/core.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = DeliveryTaxRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context, body),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    if (e is AppError) return Response.json(statusCode: e.statusCode, body: e.toMap());
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, DeliveryTaxRequest body) async {
  final getDistanceUsecase = injector.get<DistanceDeliveryUsecase>();
  final result = await getDistanceUsecase.getDeliveryTax(
    establishmentId: body.establishmentId,
    lat: body.lat,
    long: body.long,
    establishmentLat: body.establishmentLat,
    establishmentLong: body.establishmentLong,
    deliveryMethod: body.deliveryMethod,
    establishmentAddressId: body.establishmentAddressId,
    userAddressId: body.userAddessId,
    locale: body.locale,
  );

  return Response.json(body: result.toMap());
}
