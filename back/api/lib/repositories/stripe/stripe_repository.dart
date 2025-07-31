import 'package:core/core.dart';
import 'package:api/extensions/amount_extension.dart';
import 'package:api/repositories/stripe/i_stripe_repository.dart';
import 'package:api/repositories/stripe/responses/balance_transaction_response.dart';
import 'package:api/repositories/stripe/responses/refund_response.dart';
import 'package:api/repositories/stripe/responses/retrieve_account_response.dart';
import 'package:api/repositories/stripe/responses/retrieve_charge_response.dart';
import 'package:api/repositories/stripe/responses/retrieve_payment_intent_response.dart';
import 'package:api/repositories/stripe/responses/retrieve_session_response.dart';
import 'package:api/repositories/stripe/responses/transfer_refund_response.dart';
import 'package:api/repositories/stripe/responses/transfer_response.dart';

class StripeRepository implements IStripeRepository {
  final IClient client;

  StripeRepository({required this.client});

  @override
  Future<StripeCheckoutCreateSessionResponse> checkoutCreateSession({required String description, required double amount, required String country, required String successUrl, required String cancelUrl, required String chargeId}) async {
    final dto = StripeDto.fromCountry(country);

    final Map<String, dynamic> data = {
      'success_url': successUrl,
      'cancel_url': cancelUrl,
      'line_items[0][price_data][currency]': dto.currency,
      'line_items[0][price_data][product_data][name]': description,
      'line_items[0][price_data][unit_amount]': amount.toIntAmount().toString(),
      'line_items[0][quantity]': '1',
      'client_reference_id': chargeId,
      'mode': 'payment',
    };

    final request = await client.post('/v1/checkout/sessions', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'}, data: data);

    return StripeCheckoutCreateSessionResponse.fromMap(request.data);
  }

  @override
  Future<String> createAccount({required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.post('/v1/accounts', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'}, data: {'type': 'express'});

    return request.data['id'];
  }

  @override
  Future<String> getAccountLink({required String accountId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.post(
      '/v1/account_links',
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'},
      data: {'return_url': '${dto.baseUrlPortal}/account/return_url', 'refresh_url': '${dto.baseUrlPortal}/account/refresh_url', 'account': accountId, 'type': 'account_onboarding'},
    );

    return request.data['url'];
  }

  @override
  Future<RetrieveAccountResponse> getAccountStatus({required String accountId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.get('/v1/accounts/$accountId', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'});

    return RetrieveAccountResponse.fromMap(request.data);
  }

  @override
  Future<RetrieveSessionResponse> retrieveCheckoutSession({required String sessionId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.get('/v1/checkout/sessions/$sessionId', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'});

    return RetrieveSessionResponse.fromMap(request.data);
  }

  @override
  Future<BalanceTransactionResponse> retrieveBalanceTransaction({required String balanceTransactionId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.get('/v1/balance_transactions/$balanceTransactionId', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'});
    return BalanceTransactionResponse.fromMap(request.data);
  }

  @override
  Future<RetrieveChargeResponse> retrieveCharge({required String chargeId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.get('/v1/charges/$chargeId', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'});
    return RetrieveChargeResponse.fromMap(request.data);
  }

  @override
  Future<RetrievePaymentIntentResponse> retrievePaymentIntent({required String paymentIntentId, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.get('/v1/payment_intents/$paymentIntentId', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'});
    return RetrievePaymentIntentResponse.fromMap(request.data);
  }

  @override
  Future<TransferResponse> transfer({required String chargeId, required String accountId, required double amount, required String country}) async {
    final dto = StripeDto.fromCountry(country);
    final request = await client.post(
      '/v1/transfers',
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'},
      data: {'amount': amount.toIntAmount().toString(), 'currency': dto.currency.toLowerCase(), 'destination': accountId, 'source_transaction': chargeId},
    );
    return TransferResponse.fromMap(request.data);
  }

  @override
  Future<TransferRefundResponse> reverseTransfer({required String transferId, required String country, double? amount}) async {
    final dto = StripeDto.fromCountry(country);
    final respose = await client.post('v1/transfers/$transferId/reversals', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'}, data: amount != null ? {'amount': amount.toIntAmount()} : null);
    return TransferRefundResponse.fromMap(respose.data);
  }

  @override
  Future<RefundResponse> refund({required String paymentIntent, required String country, double? amount}) async {
    final dto = StripeDto.fromCountry(country);
    final Map<String, dynamic> body = {'reason': 'requested_by_customer', 'payment_intent': paymentIntent};

    if (amount != null) {
      body['amount'] = amount.toIntAmount();
    }

    final result = await client.post('/v1/refunds', headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${dto.secretKey}'}, data: body);

    return RefundResponse.fromMap(result.data);
  }
}
