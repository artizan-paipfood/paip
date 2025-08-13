import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:hipay/hipay.dart';
import 'package:api/core/extensions/num_extension.dart';
import 'package:api/infra/services/back_injector.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final data = await context.request.json() as Map<String, dynamic>;

    final body = EstablishmentInvoiceRequest.fromMap(data);

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

Future<Response> _onPost({required RequestContext context, required EstablishmentInvoiceRequest body}) async {
  final hipay = await injector.get<Hipay>();

  final response = await hipay.transactions.createTransaction(
    amount: body.amount.toIntAmount(),
    paymentMethod: HipayPaymentMethod.pix,
    description: body.description,
    expiresIn: DateTime.now().add(Duration(hours: 1)),
    customer: Customer(name: body.establishmentId, email: '', document: null),
  );

  return Response.json(body: response.toMap());
}

class EstablishmentInvoiceRequest {
  final double amount;
  final String description;
  final String establishmentId;

  EstablishmentInvoiceRequest({
    required this.amount,
    required this.description,
    required this.establishmentId,
  });

  factory EstablishmentInvoiceRequest.fromMap(Map<String, dynamic> map) {
    return EstablishmentInvoiceRequest(
      amount: map['amount']?.toDouble(),
      description: map['description'],
      establishmentId: map['establishment_id'],
    );
  }
}
