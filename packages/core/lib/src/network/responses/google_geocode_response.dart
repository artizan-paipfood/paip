import 'dart:convert';
import 'package:collection/collection.dart';

class GoogleGeocodeResponse {
  final String mainText;
  final String secondaryText;
  final String formattedAddress;
  final double lat;
  final double lon;
  final String placeId;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String country;
  final String countryCode;
  final String postalCode;
  GoogleGeocodeResponse({
    required this.mainText,
    required this.secondaryText,
    required this.formattedAddress,
    required this.lat,
    required this.lon,
    required this.placeId,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.country,
    required this.countryCode,
    required this.postalCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'main_text': mainText,
      'secondary_text': secondaryText,
      'formatted_address': formattedAddress,
      'lat': lat,
      'lon': lon,
      'place_id': placeId,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'country': country,
      'country_code': countryCode,
      'postal_code': postalCode,
    };
  }

  factory GoogleGeocodeResponse.fromMap(Map<String, dynamic> map) {
    final components = List.from(map['address_components']).map((component) => AddressComponent.fromMap(component)).toList();

    AddressComponent? getComponent(String type) {
      return components.firstWhereOrNull((element) => element.types.contains(type));
    }

    final street = getComponent('route')?.longName ?? '';
    final number = getComponent('street_number')?.longName ?? '';
    final neighborhood = getComponent('sublocality_level_1')?.longName ?? '';
    final city = getComponent('administrative_area_level_2')?.longName ?? '';
    final state = getComponent('administrative_area_level_1')?.shortName ?? '';
    final country = getComponent('country')?.longName ?? '';
    final countryCode = getComponent('country')?.shortName ?? '';

    final mainText = '$street, ${number.isNotEmpty ? '$number, ' : ''}$neighborhood';
    final secondaryText = '$city, $state, $country';

    return GoogleGeocodeResponse(
      mainText: mainText,
      secondaryText: secondaryText,
      formattedAddress: map['formatted_address'],
      lat: map['geometry']['location']['lat']?.toDouble() ?? 0.0,
      lon: map['geometry']['location']['lng']?.toDouble() ?? 0.0,
      placeId: map['place_id'] ?? '',
      street: street,
      number: number,
      neighborhood: neighborhood,
      city: city,
      state: state,
      country: country,
      countryCode: countryCode,
      postalCode: getComponent('postal_code')?.shortName ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleGeocodeResponse.fromJson(String source) => GoogleGeocodeResponse.fromMap(json.decode(source));
}

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map['long_name'] ?? '',
      shortName: map['short_name'] ?? '',
      types: List<String>.from(map['types']),
    );
  }
}
