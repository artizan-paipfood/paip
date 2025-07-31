import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/_back_injectors.dart';
import 'package:api/repositories/stripe/i_stripe_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = AccountStatusRequest.fromMap(data);

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

Future<Response> _onPost({required RequestContext context, required AccountStatusRequest body}) async {
  final stripe = await injector.get<IStripeRepository>();

  final status = await stripe.getAccountStatus(accountId: body.accountId, country: body.country);

  return Response.json(body: status.toMap());
}

class AccountStatusRequest {
  final String accountId;
  final String country;
  AccountStatusRequest({
    required this.accountId,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'country': country,
    };
  }

  factory AccountStatusRequest.fromMap(Map<String, dynamic> map) {
    return AccountStatusRequest(
      accountId: map['account_id'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountStatusRequest.fromJson(String source) => AccountStatusRequest.fromMap(json.decode(source));
}
