import 'package:core/core.dart';
import 'package:api/extensions/amount_extension.dart';

class SplitAmountDto {
  final double establishmentFee;
  final double franchiseFee;
  final double driverFee;
  SplitAmountDto({required this.establishmentFee, required this.franchiseFee, required this.driverFee});

  SplitAmountDto copyWith({double? establishmentAmount, double? franchiseAmount, double? driverAmount}) {
    return SplitAmountDto(establishmentFee: establishmentAmount ?? this.establishmentFee, franchiseFee: franchiseAmount ?? this.franchiseFee, driverFee: driverAmount ?? this.driverFee);
  }

  factory SplitAmountDto.fromCharge({required ChargeEntity charge, required String country, double? franchiseProfitPercent}) {
    final metaData = StripeChargeMetadata.fromMap(charge.metadata);
    if (metaData.net == null) {
      throw Exception('net is null');
    }
    double franchiseComission = 0;
    double platformCommission = 0;
    double driverComission = 0;
    double netTotal = metaData.net!.transformIntAmountToDouble();

    if (charge.driverFee != null) {
      driverComission = charge.driverFee! * 0.9;
      platformCommission += charge.driverFee! * 0.1;
    }

    platformCommission += feeOrderByCountry(country: country, amount: charge.amount);

    if (franchiseProfitPercent != null) {
      final value = platformCommission * franchiseProfitPercent;
      franchiseComission = value;
      platformCommission -= value;
    }

    netTotal = netTotal - (platformCommission + franchiseComission + driverComission);

    return SplitAmountDto(establishmentFee: netTotal, franchiseFee: franchiseComission, driverFee: driverComission);
  }

  static double feeOrderByCountry({required String country, required double amount}) {
    final data = {"br": 0.01, 'gb': 1};
    final result = data[country]!.toDouble();
    if (result < 1) {
      return amount * result;
    }
    return result;
  }
}
