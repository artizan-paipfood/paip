import 'package:paipfood_package/paipfood_package.dart';

class OrderAndEstablishmentDto {
  final OrderModel order;
  final EstablishmentModel establishment;
  OrderAndEstablishmentDto({
    required this.order,
    required this.establishment,
  });

  OrderAndEstablishmentDto copyWith({
    OrderModel? order,
    EstablishmentModel? establishment,
  }) {
    return OrderAndEstablishmentDto(
      order: order ?? this.order,
      establishment: establishment ?? this.establishment,
    );
  }
}
