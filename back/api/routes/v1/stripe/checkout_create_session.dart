import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/repositories/stripe/i_stripe_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = CheckoutCreateSessionRequest.fromMap(data);

    return await switch (context.request.method) {
      HttpMethod.post => await _onPost(context: context, body: body),
      _ => Future.value(
          Response(statusCode: HttpStatus.methodNotAllowed),
        ),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: 'Invalid body. \ne.g: \n ${CheckoutCreateSessionRequest.buildExampleBody()}');
  }
}

Future<Response> _onPost({required RequestContext context, required CheckoutCreateSessionRequest body}) async {
  final stripe = await injector.get<IStripeRepository>();

  final session = await stripe.checkoutCreateSession(
    description: body.description,
    amount: body.amount,
    country: body.country,
    successUrl: body.successUrl,
    cancelUrl: body.cancelUrl,
    chargeId: body.chargeId,
  );

  return Response.json(body: session.toMap());
}

class CheckoutCreateSessionRequest {
  final String description;
  final double amount;
  final String country;
  final String chargeId;
  final String successUrl;
  final String cancelUrl;

  CheckoutCreateSessionRequest({
    required this.description,
    required this.amount,
    required this.country,
    required this.chargeId,
    required this.successUrl,
    required this.cancelUrl,
  });

  static String buildExampleBody() {
    return jsonEncode({
      'description': 'Order-1',
      'amount': 20.50,
      'country': 'br',
      'charge_id': 'abcd-1234',
      'success_url': 'https://example.com/success',
      'cancel_url': 'https://example.com/cancel',
      'payment_intent_transfer_group': 'abcd-1234',
    });
  }

  factory CheckoutCreateSessionRequest.fromMap(Map<String, dynamic> map) {
    return CheckoutCreateSessionRequest(
      description: map['description'],
      amount: map['amount']?.toDouble(),
      country: map['country'],
      chargeId: map['charge_id'],
      successUrl: map['success_url'],
      cancelUrl: map['cancel_url'],
    );
  }
}
