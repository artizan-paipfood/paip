import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/_back_injectors.dart';
import 'package:api/usecases/distance_delivery_usecase.dart';
import 'package:core/core.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = GetDistanceRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context, body),
      _ => Future.value(
          Response(statusCode: HttpStatus.methodNotAllowed),
        ),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, GetDistanceRequest body) async {
  final getDistanceUsecase = injector.get<DistanceDeliveryUsecase>();
  final result = await getDistanceUsecase.getDistance(
    originlat: body.originlat,
    originlong: body.originlong,
    destlat: body.destlat,
    destlong: body.destlong,
    establishmentAddressId: body.establishmentAddressId,
    userAddressId: body.userAddessId,
  );

  return Response.json(body: result.toMap());
}
