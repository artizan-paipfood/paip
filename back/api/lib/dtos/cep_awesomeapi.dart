import 'dart:convert';

import 'package:core/core.dart';

class CepAwesomeapi {
  final String cep;
  final String addressType;
  final String addressName;
  final String address;
  final String state;
  final String district;
  final String lat;
  final String lng;
  final String city;
  final String cityIbge;
  final String ddd;
  CepAwesomeapi({
    required this.cep,
    required this.addressType,
    required this.addressName,
    required this.address,
    required this.state,
    required this.district,
    required this.lat,
    required this.lng,
    required this.city,
    required this.cityIbge,
    required this.ddd,
  });

  factory CepAwesomeapi.fromMap(Map<String, dynamic> map) {
    return CepAwesomeapi(
      cep: map['cep'] ?? '',
      addressType: map['address_type'] ?? '',
      addressName: map['address_name'] ?? '',
      address: map['address'] ?? '',
      state: map['state'] ?? '',
      district: map['district'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      city: map['city'] ?? '',
      cityIbge: map['city_ibge'] ?? '',
      ddd: map['ddd'] ?? '',
    );
  }

  AddressModel toAddressModel() {
    final mainText = '$address, $district - $city';
    final secondaryText = '$cep - $state';
    return AddressModel(
      mainText: mainText,
      secondaryText: secondaryText,
      formattedAddress: '$mainText - $secondaryText',
      street: address,
      neighborhood: district,
      city: city,
      state: state,
      postalCode: cep,
      country: 'Brasil',
      countryCode: 'BR',
      latitude: double.parse(lat),
      longitude: double.parse(lng),
      number: '',
      placeId: 'undefined',
    );
  }
}
