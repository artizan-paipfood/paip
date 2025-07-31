import 'package:core/core.dart';

import 'package:api/dtos/split_amount_dto.dart';
import 'package:api/repositories/stripe/i_stripe_repository.dart';

/// Methods index
/// [onProcessSplit] - Process the split of the charge
/// [onSplitDrive] - Split the amount to the driver
/// [onRevertSplitDrive] - Revert the split of the amount to the driver
/// [onSplitEstablishment] - Split the amount to the establishment
/// [onRevertSplitEstablishment] - Revert the split of the amount to the establishment
/// [onSplitFranchise] - Split the amount to the franchise
/// [onRevertSplitFranchise] - Revert the split of the amount to the franchise
/// [onRefundTotal] - Refund the total amount of the charge

class StripeSplitUsecase {
  final IStripeRepository repository;
  final ChargeSplitApi chargeSplitApi;
  final IChargesRepository chargesApi;

  StripeSplitUsecase({required this.repository, required this.chargeSplitApi, required this.chargesApi});

  Future<void> onProcessSplit({required OrderSplitWithPaymentProviderView orderSplitWithPaymentProvider, required ChargeEntity charge, required String country}) async {
    final metadata = StripeChargeMetadata.fromMap(charge.metadata);
    final splitDto = SplitAmountDto.fromCharge(country: country, charge: charge, franchiseProfitPercent: orderSplitWithPaymentProvider.franchise?.profitPercent);

    final List<ChargeSplitEntity> chargeSplits = [];

    if (splitDto.driverFee > 0) {
      final splitDriver = await onSplitDrive(orderSplitWithPaymentProvider: orderSplitWithPaymentProvider, charge: charge, amount: splitDto.driverFee, country: country);
      chargeSplits.add(splitDriver);
    }

    if (splitDto.franchiseFee > 0) {
      final splitFranchise = await onSplitFranchise(orderSplitWithPaymentProvider: orderSplitWithPaymentProvider, charge: charge, metadata: metadata, amount: splitDto.franchiseFee, country: country);
      chargeSplits.add(splitFranchise);
    }

    final splitEstablishment = await onSplitEstablishment(orderSplitWithPaymentProvider: orderSplitWithPaymentProvider, charge: charge, metadata: metadata, amount: splitDto.establishmentFee, country: country);
    chargeSplits.add(splitEstablishment);

    await chargeSplitApi.upsert(charges: chargeSplits);

    await chargesApi.upsert(charges: [charge.copyWith(status: ChargeStatus.processed)]);
  }

  Future<ChargeSplitEntity> onSplitDrive({required OrderSplitWithPaymentProviderView orderSplitWithPaymentProvider, required ChargeEntity charge, required double amount, required String country}) async {
    final metadata = StripeChargeMetadata.fromMap(charge.metadata);
    final paymentProvider = orderSplitWithPaymentProvider.driverPaymentProvider!.stripe!;
    final response = await repository.transfer(chargeId: metadata.chargeId!, accountId: paymentProvider.accountId, amount: amount, country: country);

    return ChargeSplitEntity(chargeId: charge.id, splitDestinationType: SplitDestinationType.drive, amount: amount, paymentProvider: PaymentProvider.stripe, destinationId: response.destination, status: ChargeStatus.processed, transactionId: response.id);
  }

  Future<StripeTransferRefound> onRevertSplitDrive({required ChargeSplitEntity chargeSplit, required String country}) async {
    final result = await repository.reverseTransfer(transferId: chargeSplit.transactionId!, country: country, amount: chargeSplit.amount);
    return StripeTransferRefound(accountId: chargeSplit.destinationId, amount: result.amount, transferId: result.id, description: 'Refund Driver');
  }

  Future<ChargeSplitEntity> onSplitEstablishment({required OrderSplitWithPaymentProviderView orderSplitWithPaymentProvider, required ChargeEntity charge, required StripeChargeMetadata metadata, required double amount, required String country}) async {
    final paymentProvider = orderSplitWithPaymentProvider.establishmentPaymentProvider!.stripe!;
    final response = await repository.transfer(chargeId: metadata.chargeId!, accountId: paymentProvider.accountId, amount: amount, country: country);
    return ChargeSplitEntity(chargeId: charge.id, splitDestinationType: SplitDestinationType.establishment, amount: amount, paymentProvider: PaymentProvider.stripe, destinationId: response.destination, status: ChargeStatus.processed, transactionId: response.id);
  }

  Future<StripeTransferRefound> onRevertSplitEstablishment({required ChargeSplitEntity chargeSplit, required String country}) async {
    final result = await repository.reverseTransfer(transferId: chargeSplit.transactionId!, country: country, amount: chargeSplit.amount);
    return StripeTransferRefound(accountId: chargeSplit.destinationId, amount: result.amount, transferId: result.id, description: 'Refund establishment');
  }

  Future<ChargeSplitEntity> onSplitFranchise({required OrderSplitWithPaymentProviderView orderSplitWithPaymentProvider, required ChargeEntity charge, required StripeChargeMetadata metadata, required double amount, required String country}) async {
    final response = await repository.transfer(chargeId: metadata.chargeId!, accountId: orderSplitWithPaymentProvider.franchisePaymentProvider!.stripe!.accountId, amount: amount, country: country);

    return ChargeSplitEntity(chargeId: charge.id, splitDestinationType: SplitDestinationType.franchise, amount: amount, paymentProvider: PaymentProvider.stripe, destinationId: response.destination, status: ChargeStatus.processed, transactionId: response.id);
  }

  Future<StripeTransferRefound> onRevertSplitFranchise({required ChargeSplitEntity chargeSplit, required String country}) async {
    final result = await repository.reverseTransfer(transferId: chargeSplit.transactionId!, country: country, amount: chargeSplit.amount);
    return StripeTransferRefound(accountId: chargeSplit.destinationId, amount: result.amount, transferId: result.id, description: 'Refund franchise');
  }

  Future<void> onRefundTotal({required ChargeEntity charge, required String country}) async {
    final splits = await chargeSplitApi.getByChargeId(chargeId: charge.id);
    final List<StripeTransferRefound> refunds = [];
    for (final split in splits) {
      if (split.splitDestinationType == SplitDestinationType.drive) {
        final driverRefound = await onRevertSplitDrive(chargeSplit: split, country: country);
        refunds.add(driverRefound);
      }
      if (split.splitDestinationType == SplitDestinationType.franchise) {
        final franchiseRefound = await onRevertSplitFranchise(chargeSplit: split, country: country);
        refunds.add(franchiseRefound);
      }
      if (split.splitDestinationType == SplitDestinationType.establishment) {
        final establishmentRefound = await onRevertSplitEstablishment(chargeSplit: split, country: country);
        refunds.add(establishmentRefound);
      }
    }
    StripeChargeMetadata metadata = StripeChargeMetadata.fromMap(charge.metadata);
    metadata = metadata.copyWith(transfersRefunds: refunds);
    charge = charge.copyWith(metadata: metadata.toMap(), status: ChargeStatus.refunded);

    await repository.refund(paymentIntent: metadata.paymentIntent!, country: country);

    await chargesApi.upsert(charges: [charge]);
  }
}
