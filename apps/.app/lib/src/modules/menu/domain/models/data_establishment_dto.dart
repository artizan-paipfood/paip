import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DataEstablishmentDto {
  final EstablishmentModel establishment;
  final MenuDto menu;
  final List<OpeningHoursModel> openingHours;
  final DeliveryAreaPerMileEntity? deliveryAreaPerMile;

  DataEstablishmentDto({
    required this.establishment,
    required this.menu,
    required this.openingHours,
    this.deliveryAreaPerMile,
  });

  DataEstablishmentDto copyWith({
    EstablishmentModel? establishment,
    MenuDto? menu,
    List<OpeningHoursModel>? openingHours,
    DeliveryAreaPerMileEntity? deliveryAreaPerMile,
  }) {
    return DataEstablishmentDto(
      establishment: establishment ?? this.establishment,
      menu: menu ?? this.menu,
      openingHours: openingHours ?? this.openingHours,
      deliveryAreaPerMile: deliveryAreaPerMile ?? this.deliveryAreaPerMile,
    );
  }
}
