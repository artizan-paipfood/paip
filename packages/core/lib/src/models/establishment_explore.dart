import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class EstablishmentExplore {
  final String establishmentId;
  final String fantasyName;
  final String logo;
  final AddressEntity address;
  final double distanceKm;
  final bool isOpen;
  EstablishmentExplore({
    required this.establishmentId,
    required this.fantasyName,
    required this.logo,
    required this.address,
    required this.distanceKm,
    required this.isOpen,
  });

  factory EstablishmentExplore.fromMap(Map<String, dynamic> map) {
    try {
      return EstablishmentExplore(
        establishmentId: map['establishment_id'] ?? '',
        fantasyName: map['fantasy_name'] ?? '',
        logo: map['logo'] ?? '',
        address: AddressEntity.fromMap(map['address']),
        distanceKm: map['distance_km']?.toDouble() ?? 0.0,
        isOpen: map['is_open'] ?? false,
      );
    } catch (e, s) {
      throw SerializationException(map: map, runTimeType: 'EstablishmentExplore', stackTrace: s);
    }
  }

  String? get logoUrl => logo.trim().isNotEmpty ? '${AppCoreConstants.baseUrlAws}/$logo' : null;

  factory EstablishmentExplore.fromJson(String source) => EstablishmentExplore.fromMap(json.decode(source));
}
