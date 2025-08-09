import 'dart:convert';

class AddressGeocodeResponse {
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
  AddressGeocodeResponse({
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

  factory AddressGeocodeResponse.fromMap(Map<String, dynamic> map) {
    return AddressGeocodeResponse(
      formattedAddress: map['formatted_address'],
      lat: map['lat'],
      lon: map['lon'],
      placeId: map['place_id'],
      street: map['street'],
      number: map['number'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      countryCode: map['country_code'],
      postalCode: map['postal_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressGeocodeResponse.fromJson(String source) => AddressGeocodeResponse.fromMap(json.decode(source));
}
