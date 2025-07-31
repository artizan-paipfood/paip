import 'dart:convert';

import 'package:core/core.dart';

class Postcode {
  final String postcode;
  final int quality;
  final String country;
  final String nhsHa;
  final double longitude;
  final double latitude;
  final String primaryCareTrust;
  final String region;
  final String incode;
  final String outcode;
  final String adminDistrict;
  final String nuts;
  Postcode({
    required this.postcode,
    required this.quality,
    required this.country,
    required this.nhsHa,
    required this.longitude,
    required this.latitude,
    required this.primaryCareTrust,
    required this.region,
    required this.incode,
    required this.outcode,
    required this.adminDistrict,
    required this.nuts,
  });

  factory Postcode.fromMap(Map<String, dynamic> map) {
    return Postcode(
      postcode: map['postcode'] ?? '',
      quality: map['quality']?.toInt() ?? 0,
      country: map['country'] ?? '',
      nhsHa: map['nhsHa'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      primaryCareTrust: map['primaryCareTrust'] ?? '',
      region: map['region'] ?? '',
      incode: map['incode'] ?? '',
      outcode: map['outcode'] ?? '',
      adminDistrict: map['adminDistrict'] ?? '',
      nuts: map['nuts'] ?? '',
    );
  }

  AddressModel toAddressModel() {
    return AddressModel(
      mainText: '',
      secondaryText: '',
      formattedAddress: '$postcode - $adminDistrict',
      placeId: 'undefined',
      city: adminDistrict,
      postalCode: postcode,
      country: country,
      latitude: latitude,
      longitude: longitude,
      countryCode: 'GB',
    );
  }
}
