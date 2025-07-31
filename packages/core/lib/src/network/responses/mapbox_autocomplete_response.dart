import 'dart:convert';

class MapboxAutoCompleteResponse {
  final String mapboxId;
  final String name;
  final String placeFormatted;
  final String country;
  final String countryCode;
  final String regionCode;
  final String postCode;
  final String place;
  final String neighborhood;
  final String street;
  final String addressNumber;
  MapboxAutoCompleteResponse({
    required this.mapboxId,
    required this.name,
    required this.placeFormatted,
    required this.country,
    required this.countryCode,
    required this.regionCode,
    required this.postCode,
    required this.place,
    required this.neighborhood,
    required this.street,
    required this.addressNumber,
  });

  Map<String, dynamic> toMap() {
    return {'mapbox_id': mapboxId, 'name': name, 'place_formatted': placeFormatted, 'country': country, 'region': regionCode, 'post_code': postCode, 'place': place, 'neighborhood': neighborhood, 'street': street, 'address_number': addressNumber};
  }

  factory MapboxAutoCompleteResponse.fromMap(Map<String, dynamic> map) {
    final _context = map['context'] ?? {};
    final _country = _context['country']?['name'] ?? '';
    final _countryCode = _context['country']?['country_code'] ?? '';
    final _regionCode = _context['region']?['region_code'] ?? '';
    final _postCode = _context['postcode']?['name'] ?? '';
    final _place = _context['place']?['name'] ?? '';
    final _neighborhood = _context['neighborhood']?['name'] ?? '';
    final _street = _context['street']?['name'] ?? '';
    final _addressNumber = _context['address']?['address_number'] ?? '';
    return MapboxAutoCompleteResponse(
      mapboxId: map['mapbox_id'] ?? '',
      name: map['name'] ?? '',
      placeFormatted: map['place_formatted'] ?? '',
      country: _country,
      countryCode: _countryCode,
      regionCode: _regionCode,
      postCode: _postCode,
      place: _place,
      neighborhood: _neighborhood,
      street: _street,
      addressNumber: _addressNumber,
    );
  }

  String toJson() => json.encode(toMap());

  factory MapboxAutoCompleteResponse.fromJson(String source) => MapboxAutoCompleteResponse.fromMap(json.decode(source));
}
