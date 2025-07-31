import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:core/core.dart' hide Response;
import 'package:hipay/hipay.dart';
import 'package:api/extensions/amount_extension.dart';
import 'package:api/services/_back_injectors.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  try {
    return switch (context.request.method) {
      HttpMethod.get => _onGet(context: context, id: id),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
    };
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}

Future<Response> _onGet({required RequestContext context, required String id}) async {
  final hipay = await injector.get<Hipay>();

  final response = await hipay.transactions.detalharTransacao(transactionId: id);

  final status = switch (response.status) {
    HipayTransactionStatus.waitingPayment => PaymentStatus.pending,
    HipayTransactionStatus.paid => PaymentStatus.paid,
    _ => PaymentStatus.undefined,
  };
  final paymentStatusResponse = PaymentStatusResponse(id: id, amount: response.amount.transformIntAmountToDouble(), status: status, provider: PaymentProvider.hipay);

  return Response.json(body: paymentStatusResponse.toMap());
}
