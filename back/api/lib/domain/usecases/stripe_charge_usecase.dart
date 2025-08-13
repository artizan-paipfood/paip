import 'package:core/core.dart';
import 'package:api/core/extensions/num_extension.dart';
import 'package:api/infra/repositories/stripe/i_stripe_repository.dart';

class StripeChargeUsecase {
  final IStripeRepository repository;
  final IChargesRepository chargesApi;

  StripeChargeUsecase({required this.repository, required this.chargesApi});

  Future<void> onPaymentAproved({required ChargeEntity charge, required String country}) async {
    StripeChargeMetadata metadata = StripeChargeMetadata.fromMap(charge.metadata);

    final retrieveSession = await repository.retrieveCheckoutSession(sessionId: metadata.sessionId, country: country);
    metadata = metadata.copyWith(paymentIntent: retrieveSession.paymentIntent);

    final retrievePaymentIntent = await repository.retrievePaymentIntent(paymentIntentId: metadata.paymentIntent!, country: country);
    metadata = metadata.copyWith(chargeId: retrievePaymentIntent.latestCharge);

    final retrieveCharge = await repository.retrieveCharge(chargeId: metadata.chargeId!, country: country);
    metadata = metadata.copyWith(balanceTransactionId: retrieveCharge.balanceTransaction);

    final retrieveBalanceTransaction = await repository.retrieveBalanceTransaction(balanceTransactionId: metadata.balanceTransactionId!, country: country);
    metadata = metadata.copyWith(stripeFee: retrieveBalanceTransaction.fee, net: retrieveBalanceTransaction.net);

    charge = charge.copyWith(metadata: metadata.toMap(), status: ChargeStatus.paid, netAmount: retrieveBalanceTransaction.net.transformIntAmountToDouble());
    await chargesApi.upsert(charges: [charge]);
  }

  Future<void> onRefundProcessing({required ChargeEntity charge, required String description, required String country, double? amount}) async {
    StripeChargeMetadata metadata = StripeChargeMetadata.fromMap(charge.metadata);

    final bool isRefundTotal = amount == null || amount == charge.amount;

    final bool isRefundParcial = !isRefundTotal;

    if (isRefundTotal) {
      final response = await repository.refund(paymentIntent: metadata.paymentIntent!, country: country);
      metadata = metadata.copyWith(transfersRefunds: [StripeTransferRefound(accountId: '', amount: response.amount, transferId: response.id, description: description)]);
      charge = charge.copyWith(metadata: metadata.toMap(), status: ChargeStatus.refunded);
      await chargesApi.upsert(charges: [charge]);
    }

    if (isRefundParcial) {
      final response = await repository.refund(paymentIntent: metadata.paymentIntent!, amount: amount, country: country);
      metadata = metadata.copyWith(transfersRefunds: [StripeTransferRefound(accountId: '', amount: response.amount, transferId: response.id, description: 'partial-$description')]);
      charge = charge.copyWith(metadata: metadata.toMap());
      await chargesApi.upsert(charges: [charge]);
    }
  }

  Future<void> onRefundSucess({required ChargeEntity charge, required String description, required String country, double? amount}) async {
    StripeChargeMetadata metadata = StripeChargeMetadata.fromMap(charge.metadata);

    final bool isRefundTotal = amount == null || amount == charge.amount;

    final bool isRefundParcial = !isRefundTotal;

    if (isRefundTotal) {
      final response = await repository.refund(paymentIntent: metadata.paymentIntent!, country: country);
      metadata = metadata.copyWith(transfersRefunds: [StripeTransferRefound(accountId: '', amount: response.amount, transferId: response.id, description: description)]);
      charge = charge.copyWith(metadata: metadata.toMap(), status: ChargeStatus.refunded);
      await chargesApi.upsert(charges: [charge]);
    }

    if (isRefundParcial) {
      final response = await repository.refund(paymentIntent: metadata.paymentIntent!, amount: amount, country: country);
      metadata = metadata.copyWith(transfersRefunds: [StripeTransferRefound(accountId: '', amount: response.amount, transferId: response.id, description: 'partial-$description')]);
      charge = charge.copyWith(metadata: metadata.toMap());
      await chargesApi.upsert(charges: [charge]);
    }
  }
}


/*
* FLUXO DE PAGAMENTO
1- Efetuar a cobrança
    * verificar se existe uma franquia filiada (split de pagamento)
2- Se houver franquia criar na tablela de split o split de pagamento
3- Criar o split para a empresa conforme a taxa 
4- rodar um cronjob para verificar se a cobrança foi paga e se nao foi cancelar a cobrança dentro de 6 minutos
*/


