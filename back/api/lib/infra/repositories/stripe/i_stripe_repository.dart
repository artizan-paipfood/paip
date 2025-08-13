import 'package:core/core.dart';
import 'package:api/infra/repositories/stripe/mappers/balance_transaction_response.dart';
import 'package:api/infra/repositories/stripe/mappers/refund_response.dart';
import 'package:api/infra/repositories/stripe/mappers/retrieve_account_response.dart';
import 'package:api/infra/repositories/stripe/mappers/retrieve_charge_response.dart';
import 'package:api/infra/repositories/stripe/mappers/retrieve_payment_intent_response.dart';
import 'package:api/infra/repositories/stripe/mappers/retrieve_session_response.dart';
import 'package:api/infra/repositories/stripe/mappers/transfer_refund_response.dart';
import 'package:api/infra/repositories/stripe/mappers/transfer_response.dart';
import 'package:api/infra/services/process_env.dart';

abstract interface class IStripeRepository {
  Future<StripeCheckoutCreateSessionResponse> checkoutCreateSession({required String description, required double amount, required String country, required String successUrl, required String cancelUrl, required String chargeId});
  Future<RetrieveSessionResponse> retrieveCheckoutSession({required String sessionId, required String country});

  Future<String> createAccount({required String country});
  Future<RetrieveAccountResponse> getAccountStatus({required String accountId, required String country});
  Future<String> getAccountLink({required String accountId, required String country});

  Future<RetrievePaymentIntentResponse> retrievePaymentIntent({required String paymentIntentId, required String country});

  Future<RetrieveChargeResponse> retrieveCharge({required String chargeId, required String country});

  Future<BalanceTransactionResponse> retrieveBalanceTransaction({required String balanceTransactionId, required String country});

  Future<TransferResponse> transfer({required String chargeId, required String accountId, required double amount, required String country});

  Future<TransferRefundResponse> reverseTransfer({required String transferId, required String country, double? amount});

  Future<RefundResponse> refund({required String paymentIntent, required String country, double? amount});
}

class StripeDto {
  final String baseUrlApp;
  final String baseUrlPortal;
  final String currency;
  final String secretKey;
  StripeDto({required this.baseUrlApp, required this.baseUrlPortal, required this.currency, required this.secretKey});
  static Map<String, StripeDto> countries = {
    'br': StripeDto(baseUrlApp: 'https://paipfood.com', baseUrlPortal: 'https://portal.paipfood.com', currency: 'BRL', secretKey: ProcessEnv.brStripeScretKey),
    'gb': StripeDto(baseUrlApp: 'https://paipfood.co.uk', baseUrlPortal: 'https://portal.paipfood.co.uk', currency: 'GBP', secretKey: ProcessEnv.gbStripeScretKey),
  };

  static StripeDto fromCountry(String country) {
    final result = countries[country.toLowerCase().trim()];
    if (result == null) throw Exception('Country not found');
    return result;
  }
}
