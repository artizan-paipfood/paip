import 'dart:convert';
import 'package:paipfood_package/paipfood_package.dart';

class AddressModelOld {
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

  bool isDeleted;

  AddressModelOld({
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

  AddressModelOld copyWith({
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
    return AddressModelOld(
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

  AddressModelOld clone() {
    return AddressModelOld(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      street: street,
      number: number,
      neighborhood: neighborhood,
      complement: complement,
      zipCode: zipCode,
      state: state,
      lat: lat,
      long: long,
      address: address,
      nickName: nickName,
      city: city,
      country: country,
      userId: userId,
      establishmentId: establishmentId,
      isDeleted: isDeleted,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
      'zip_code': zipCode,
      'state': state,
      'lat': lat,
      'long': long,
      'address': address,
      'nick_name': nickName,
      'city': city,
      'country': country,
      'user_id': userId,
      'establishment_id': establishmentId,
      'is_deleted': isDeleted,
    };
  }

  factory AddressModelOld.fromMap(Map map) {
    return AddressModelOld(
      id: map['id'] ?? '',
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      street: map['street'] ?? "",
      number: map['number'] ?? "",
      neighborhood: map['neighborhood'] ?? "",
      complement: map['complement'] ?? "",
      zipCode: map['zip_code'] ?? "",
      state: map['state'] ?? "",
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
      address: map['address'] ?? "",
      city: map['city'] ?? "",
      country: map['country'] ?? "",
      userId: map['user_id'],
      establishmentId: map['establishment_id'] ?? "",
      isDeleted: map['is_deleted'] ?? false,
      nickName: map['nick_name'] ?? '',
    );
  }

  // factory AddressModelOld.fromGeoCodeResponse({required AddressGeocodeResponse response, required String userId, required String establishmentId}) {
  //   return AddressModelOld(
  //     id: uuid,
  //     street: response.street,
  //     number: response.number,
  //     neighborhood: response.neighborhood,
  //     zipCode: response.postalCode,
  //     state: response.state,
  //     lat: response.lat,
  //     long: response.lon,
  //     address: response.formattedAddress,
  //     city: response.city,
  //     country: response.country,
  //     userId: userId,
  //     establishmentId: establishmentId,
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory AddressModelOld.fromJson(String source) => AddressModelOld.fromMap(json.decode(source));

  bool get isValid => lat != null && long != null;
  bool get isNotValid => !isValid;

  String get factoryCountryAddressToString {
    if (isGb) return "${complement.isNotEmpty ? "$complement - " : ""}${_startsWithNumber(address) ? "" : "$number "}$address";
    return "$street $number,${complement.isNotEmpty ? " $complement," : ""} $neighborhood";
  }

  String get subAddress => "$city - $zipCode - $country";

  String get addressFormatted => "$factoryCountryAddressToString \n$subAddress";
  String get _buildDestination => "$street, $number, $neighborhood, $city, $country".replaceAll(" ", "+");
  String get getWazeDestination {
    return 'https://waze.com/ul?q=$_buildDestination&navigate=yes';
  }

  String get getGoogleMapsDestination {
    return "https://www.google.com/maps/dir/?api=1&destination=$_buildDestination";
  }

  bool _startsWithNumber(String input) {
    final pattern = RegExp(r'^\d{1,3}');
    return pattern.hasMatch(input);
  }

  bool get countryFactoryIsValid {
    if (isGb) {
      return address.isNotEmpty && lat != 0.0 && long != 0.0;
    }
    return street.isNotEmpty && lat != 0.0 && long != 0.0;
  }
}
