import 'dart:convert';
import 'package:core/src/network/responses/google_geocode_response.dart';
import 'package:core/src/network/responses/mapbox_autocomplete_response.dart';
import 'package:core/src/network/responses/mapbox_geocoding_response.dart';

class AddressModel {
  final String mainText;
  final String secondaryText;
  final String formattedAddress;
  final String placeId;
  final double? latitude;
  final double? longitude;
  final String? street;
  final String? number;
  final String? neighborhood;
  final String? city;
  final String? state;
  final String? country;
  final String? countryCode;
  final String? postalCode;
  AddressModel({required this.mainText, required this.secondaryText, required this.formattedAddress, required this.placeId, this.latitude, this.longitude, this.street, this.number, this.neighborhood, this.city, this.state, this.country, this.countryCode, this.postalCode});

  Map<String, dynamic> toMap() {
    return {
      'main_text': mainText,
      'secondary_text': secondaryText,
      'formatted_address': formattedAddress,
      'place_id': placeId,
      'latitude': latitude,
      'longitude': longitude,
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

  factory AddressModel.empty() {
    return AddressModel(
      mainText: '',
      secondaryText: '',
      formattedAddress: '',
      placeId: '',
      latitude: null,
      longitude: null,
      street: null,
      number: null,
      neighborhood: null,
      city: null,
      state: null,
      country: null,
      countryCode: null,
      postalCode: null,
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      mainText: map['main_text'] ?? '',
      secondaryText: map['secondary_text'] ?? '',
      formattedAddress: map['formatted_address'] ?? '',
      placeId: map['place_id'] ?? '',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
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

  factory AddressModel.fromRadar(Map<String, dynamic> map) {
    final postalCode = map['postalCode'] ?? '';
    final city = map['city'] ?? '';
    final state = map['state'] ?? '';
    final country = map['country'] ?? '';
    return AddressModel(
      mainText: map['addressLabel'] ?? '',
      secondaryText: '$postalCode - $city, $state, $country',
      formattedAddress: map['formattedAddress'] ?? '',
      placeId: 'undefined',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      street: map['street'],
      number: map['number'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      countryCode: map['countryCode'],
      postalCode: map['postalCode'],
    );
  }

  factory AddressModel.fromGoogleMaps({required AddressModel address, GoogleGeocodeResponse? geocode}) {
    return AddressModel(
      mainText: address.mainText.isEmpty ? geocode?.mainText ?? '' : address.mainText,
      secondaryText: address.secondaryText.isEmpty ? geocode?.secondaryText ?? '' : address.secondaryText,
      formattedAddress: geocode?.formattedAddress ?? address.formattedAddress,
      placeId: address.placeId,
      latitude: geocode?.lat,
      longitude: geocode?.lon,
      street: geocode?.street,
      number: geocode?.number,
      neighborhood: geocode?.neighborhood,
      city: geocode?.city,
      state: geocode?.state,
      country: geocode?.country,
      countryCode: geocode?.countryCode,
      postalCode: geocode?.postalCode,
    );
  }
  factory AddressModel.fromMapBox({required MapboxAutoCompleteResponse autocomplete, MapboxGeocodingResponse? geocode}) {
    return AddressModel(
      mainText: autocomplete.name,
      secondaryText: autocomplete.placeFormatted,
      formattedAddress: '${autocomplete.name}, ${autocomplete.placeFormatted}',
      latitude: geocode?.latitude,
      longitude: geocode?.longitude,
      placeId: autocomplete.mapboxId,
      street: autocomplete.street,
      number: autocomplete.addressNumber,
      neighborhood: autocomplete.neighborhood,
      city: autocomplete.place,
      state: autocomplete.regionCode,
      country: autocomplete.country,
      countryCode: autocomplete.countryCode,
      postalCode: autocomplete.postCode,
    );
  }

  AddressModel copyWith({
    String? name,
    String? placeFormatted,
    String? formattedAddress,
    String? placeId,
    double? latitude,
    double? longitude,
    String? street,
    String? number,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? countryCode,
    String? postalCode,
  }) {
    return AddressModel(
      mainText: name ?? mainText,
      secondaryText: placeFormatted ?? secondaryText,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      placeId: placeId ?? this.placeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  String fromViaCepToQuery() => '$street, $neighborhood, $city';

  bool isValid() => mainText.isNotEmpty && (latitude != null && latitude != 0) && (longitude != null && longitude != 0);
}
