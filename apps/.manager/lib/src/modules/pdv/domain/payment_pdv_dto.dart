import 'package:paipfood_package/paipfood_package.dart';

class PaymentPdvDto {
  final BillModel? bill;

  final OrderModel? order;

  PaymentPdvDto({this.bill, this.order});

  PaymentPdvDto copyWith({
    BillModel? bill,
    OrderModel? order,
  }) {
    return PaymentPdvDto(
      bill: bill ?? this.bill,
      order: order ?? this.order,
    );
  }
}
