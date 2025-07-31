import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/src/entities/establishment_entity.dart';

class EstablishmentGestView {
  final EstablishmentEntity establishment;
  final EstablishmentPreferencesEntity preferences;
  final AddressEntity address;

  EstablishmentGestView({
    required this.establishment,
    required this.preferences,
    required this.address,
  });

  static const String view = 'establishment_gest_view';

  EstablishmentGestView copyWith({
    EstablishmentEntity? establishment,
    EstablishmentPreferencesEntity? preferences,
    AddressEntity? address,
  }) {
    return EstablishmentGestView(
      establishment: establishment ?? this.establishment,
      preferences: preferences ?? this.preferences,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment': establishment.toMap(),
      'preferences': preferences.toMap(),
      'address': address.toMap(),
    };
  }

  factory EstablishmentGestView.fromMap(Map<String, dynamic> map) {
    return EstablishmentGestView(
        establishment: EstablishmentEntity.fromMap(map['establishment']),
        preferences: map['preferences'] != null
            ? EstablishmentPreferencesEntity.fromMap(map['preferences'])
            : EstablishmentPreferencesEntity(
                establishmentId: map['establishment']['id'],
              ),
        address: AddressEntity.fromMap(map['address']));
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentGestView.fromJson(String source) => EstablishmentGestView.fromMap(json.decode(source));
}
