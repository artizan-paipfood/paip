import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:api/infra/services/back_injector.dart';
import 'package:api/infra/repositories/stripe/i_stripe_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = BuildAccountLinkRequest.fromMap(data);

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

Future<Response> _onPost({required RequestContext context, required BuildAccountLinkRequest body}) async {
  final stripe = await injector.get<IStripeRepository>();

  final session = await stripe.getAccountLink(accountId: body.accountId, country: body.country);

  return Response.json(body: {'link': session});
}

class BuildAccountLinkRequest {
  final String accountId;
  final String country;
  BuildAccountLinkRequest({
    required this.accountId,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'country': country,
    };
  }

  factory BuildAccountLinkRequest.fromMap(Map<String, dynamic> map) {
    return BuildAccountLinkRequest(
      accountId: map['account_id'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BuildAccountLinkRequest.fromJson(String source) => BuildAccountLinkRequest.fromMap(json.decode(source));
}
