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

  static const String table = 'address';

  AddressEntity({
    required this.id,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    this.street = "",
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
  });

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
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) => AddressEntity.fromMap(json.decode(source));
  //***************************************************** */
  //custom
  //***************************************************** */

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

  String mainText(DbLocale locale) {
    if (street.isEmpty) return address;
    final pNumber = number.isNotEmpty ? '$number ' : '';
    final pComplement = complement.isNotEmpty ? '$complement, ' : '';
    final pNeighborhood = neighborhood.isNotEmpty ? '- $neighborhood' : '';
    return switch (locale) {
      DbLocale.br => '$street $pNumber$pComplement $pNeighborhood',
      DbLocale.gb => '$zipCode, Nº$number, $street $pComplement',
    };
  }

  String secondaryText(DbLocale locale) => switch (locale) {
        DbLocale.br => '$zipCode - $state - $country',
        DbLocale.gb => '$city, $state, $country',
      };

  String formattedAddress(DbLocale locale) => '${mainText(locale)} - ${secondaryText(locale)}';

  bool isValid() => lat != null && long != null;

  bool isNotValid() => !isValid();

  String buildGoogleMapsDestination() => 'https://www.google.com/maps/dir/?api=1&destination=${_buildDestination()}';
  String buildWazeDestination() => 'https://waze.com/ul?q=${_buildDestination()}&navigate=yes';
  String _buildDestination() => "$street, $number, $neighborhood, $city, $country".replaceAll(" ", "+");
}
