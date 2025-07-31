import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/_back_injectors.dart';
import 'package:api/repositories/stripe/i_stripe_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = CreateAccountRequest.fromMap(data);

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

Future<Response> _onPost({required RequestContext context, required CreateAccountRequest body}) async {
  final stripe = await injector.get<IStripeRepository>();

  final accountId = await stripe.createAccount(country: body.country);

  final link = await stripe.getAccountLink(accountId: accountId, country: body.country);

  return Response.json(body: {'account_id': accountId, 'link': link});
}

class CreateAccountRequest {
  final String country;
  CreateAccountRequest({required this.country});

  Map<String, dynamic> toMap() {
    return {"country": country};
  }

  factory CreateAccountRequest.fromMap(Map<String, dynamic> map) {
    return CreateAccountRequest(
      country: map['country'],
    );
  }
}
