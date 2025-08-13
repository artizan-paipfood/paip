import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/entities/establishment_entity.dart';
import 'package:core/src/views/menu_view.dart';

class EstablishmentMenuView {
  final String id;
  final EstablishmentEntity establishment;
  final PaymentProviderView paymentProvider;
  final AddressEntity address;
  final MenuView menu;
  final List<OpeningHoursEntity> openingHours;
  EstablishmentMenuView({
    required this.id,
    required this.establishment,
    required this.paymentProvider,
    required this.address,
    required this.menu,
    required this.openingHours,
  });

  factory EstablishmentMenuView.fromMap(Map<String, dynamic> map) {
    return EstablishmentMenuView(
      id: map['id'] ?? '',
      establishment: EstablishmentEntity.fromMap(map['establishment']),
      paymentProvider: PaymentProviderView.fromMap(map['payment_provider']),
      address: AddressEntity.fromMap(map['address']),
      menu: MenuView.fromMap(map['menu']),
      openingHours: List<OpeningHoursEntity>.from(map['opening_hours']?.map((x) => OpeningHoursEntity.fromMap(x)) ?? []),
    );
  }

  factory EstablishmentMenuView.fromJson(String source) => EstablishmentMenuView.fromMap(json.decode(source));
}
