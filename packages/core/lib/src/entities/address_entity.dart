import 'dart:convert';

import 'package:core/core.dart';

class AddressEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String street;
  final String number;
  final String neighborhood;
  final String complement;
  final String zipCode;
  final String state;
  final double? lat;
  final double? long;
  final String address;
  final String city;
  final String country;
  final String nickName;
  final String? userId;
  final String? establishmentId;
  final bool isDeleted;
  final String mainText;
  final String secondaryText;
  final String countryCode;

  static const String table = 'address';

  AddressEntity({
    required this.id,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    String street = "",
    this.number = "",
    this.neighborhood = "",
    this.complement = "",
    this.zipCode = "",
    this.state = "",
    this.address = "",
    this.city = "",
    this.country = "",
    this.userId,
    this.nickName = "",
    this.establishmentId,
    this.isDeleted = false,
    this.mainText = "",
    this.secondaryText = "",
    this.countryCode = "",
  }) : street = _cleanStreetName(street);

  static const String box = "address";

  AddressEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? street,
    String? number,
    String? neighborhood,
    String? complement,
    String? zipCode,
    String? state,
    double? lat,
    double? long,
    String? address,
    String? city,
    String? country,
    String? nickName,
    String? userId,
    String? establishmentId,
    bool? isDeleted,
    String? mainText,
    String? secondaryText,
    String? countryCode,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      complement: complement ?? this.complement,
      zipCode: zipCode ?? this.zipCode,
      state: state ?? this.state,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      nickName: nickName ?? this.nickName,
      userId: userId ?? this.userId,
      establishmentId: establishmentId ?? this.establishmentId,
      isDeleted: isDeleted ?? this.isDeleted,
      mainText: mainText ?? this.mainText,
      secondaryText: secondaryText ?? this.secondaryText,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toPaipDB(),
      'updated_at': updatedAt?.toPaipDB(),
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
      'zip_code': zipCode,
      'state': state,
      'lat': lat,
      'long': long,
      'address': address,
      'city': city,
      'country': country,
      'nick_name': nickName,
      'user_id': userId,
      'establishment_id': establishmentId,
      'is_deleted': isDeleted,
      'main_text': mainText,
      'secondary_text': secondaryText,
      'country_code': countryCode.toUpperCase(),
    };
  }

  factory AddressEntity.empty() {
    return AddressEntity(
      id: Uuid().v4(),
      createdAt: null,
      updatedAt: null,
    );
  }

  factory AddressEntity.fromMap(
    Map map,
  ) {
    return AddressEntity(
      id: map['id'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(
              map['created_at'],
            )
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(
              map['updated_at'],
            )
          : null,
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      complement: map['complement'] ?? '',
      zipCode: map['zip_code'] ?? '',
      state: map['state'] ?? '',
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      nickName: map['nick_name'] ?? '',
      userId: map['user_id'],
      establishmentId: map['establishment_id'],
      isDeleted: map['is_deleted'] ?? false,
      mainText: map['main_text'] ?? '',
      secondaryText: map['secondary_text'] ?? '',
      countryCode: map['country_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) => AddressEntity.fromMap(json.decode(source));
  //***************************************************** */
  //custom
  //***************************************************** */

  static String _cleanStreetName(String street) {
    // Remove numbers from the beginning and end of street name
    final trimmedStreet = street.trim();

    // Remove numbers from the beginning
    String cleanedStreet = trimmedStreet.replaceAll(RegExp(r'^\d+\s*'), '');

    // Remove numbers from the end of street name until the first space
    final endRegex = RegExp(r'\d+$');
    if (endRegex.hasMatch(cleanedStreet)) {
      // Find the last space before the numbers at the end
      final lastSpaceIndex = cleanedStreet.lastIndexOf(' ');
      if (lastSpaceIndex != -1) {
        // Remove everything from the last space (including numbers)
        cleanedStreet = cleanedStreet.substring(0, lastSpaceIndex).trim();
      } else {
        // If there's no space, remove all numbers from the end
        cleanedStreet = cleanedStreet.replaceAll(endRegex, '');
      }
    }

    return cleanedStreet.trim();
  }

  factory AddressEntity.fromAddressModel(AddressModel addressModel) {
    return AddressEntity(
      id: Uuid().v4(),
      address: addressModel.formattedAddress,
      city: addressModel.city ?? '',
      country: addressModel.country ?? '',
      lat: addressModel.latitude,
      long: addressModel.longitude,
      neighborhood: addressModel.neighborhood ?? '',
      number: addressModel.number ?? '',
      street: addressModel.street ?? '',
      zipCode: addressModel.postalCode ?? '',
      state: addressModel.state ?? '',
      complement: '',
      nickName: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isDeleted: false,
    );
  }

  bool isValid() => lat != null && long != null;

  bool isNotValid() => !isValid();

  String buildGoogleMapsDestination() => 'https://www.google.com/maps/dir/?api=1&destination=${_buildDestination()}';
  String buildWazeDestination() => 'https://waze.com/ul?q=${_buildDestination()}&navigate=yes';
  String _buildDestination() => "$street, $number, $neighborhood, $city, $country".replaceAll(" ", "+");
}
