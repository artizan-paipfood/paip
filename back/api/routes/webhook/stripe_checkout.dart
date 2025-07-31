import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:core/core.dart' hide Response;
import 'package:api/services/_back_injectors.dart';
import 'package:api/usecases/stripe_charge_usecase.dart';
import 'package:api/usecases/update_queus_usecase.dart';
import 'package:api/webhooks/stripe_checkout_webhook.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  try {
    final body = StripeCheckoutWebhook.fromMap(data);

    return switch (context.request.method) {
      HttpMethod.post => _onPost(context, body),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost(RequestContext context, StripeCheckoutWebhook body) async {
  final usecase = injector.get<StripeChargeUsecase>();
  final chargeApi = injector.get<IChargesRepository>();
  if (body.paymentStatus == StripePaymentStatus.paid) {
    final charge = await chargeApi.getById(id: body.clientReferenceId);
    await usecase.onPaymentAproved(charge: charge, country: charge.locale.name);

    if (charge.orderId != null) {
      await _onOrder(charge.orderId!);
    }
  }

  return Response.json();
}

Future<void> _onOrder(String orderId) async {
  final viewApi = injector.get<ViewsApi>();
  final usecase = injector.get<UpdateQueusUsecase>();
  final data = await viewApi.getOrderViewMap(orderId: orderId);
  final queu = UpdateQueusEntity(establishmentId: data['establishment_id'], table: 'orders', operation: 'update', data: data);
  await usecase.call(queu);
}
