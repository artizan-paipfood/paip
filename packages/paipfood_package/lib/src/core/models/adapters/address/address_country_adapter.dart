import 'dart:convert';

class AddressCountryAdapter {
  final String city;
  final String country;
  AddressCountryAdapter({
    required this.city,
    required this.country,
  });

  AddressCountryAdapter copyWith({
    String? city,
    String? country,
  }) {
    return AddressCountryAdapter(
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'p_city': city,
      'p_country': country,
    };
  }

  factory AddressCountryAdapter.fromMap(Map<String, dynamic> map) {
    return AddressCountryAdapter(
      city: map['city'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressCountryAdapter.fromJson(String source) => AddressCountryAdapter.fromMap(json.decode(source));
}
