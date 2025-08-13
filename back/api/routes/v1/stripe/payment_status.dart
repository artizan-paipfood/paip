import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/repositories/stripe/i_stripe_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = PaymentStatusRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context: context, body: body),
      _ => Future.value(
          Response(statusCode: HttpStatus.methodNotAllowed),
        ),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onPost({required RequestContext context, required PaymentStatusRequest body}) async {
  final stripe = await injector.get<IStripeRepository>();

  final status = await stripe.retrieveCheckoutSession(sessionId: body.paymentId, country: body.country);

  return Response.json(body: status.toMap());
}

class PaymentStatusRequest {
  final String paymentId;
  final String country;
  PaymentStatusRequest({
    required this.paymentId,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'payment_id': paymentId,
      'country': country,
    };
  }

  factory PaymentStatusRequest.fromMap(Map<String, dynamic> map) {
    return PaymentStatusRequest(
      paymentId: map['payment_id'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentStatusRequest.fromJson(String source) => PaymentStatusRequest.fromMap(json.decode(source));
}
