import 'dart:convert';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UserDto {
  final AddressEntity? address;
  final String? name;
  final String? phone;
  final String? phoneCountryCode;
  final String? addressSaveId;
  final String? wppPhoneFormated;
  const UserDto({
    this.address,
    this.name,
    this.phone,
    this.phoneCountryCode,
    this.addressSaveId,
    this.wppPhoneFormated,
  });

  UserDto copyWith({
    AddressEntity? address,
    String? name,
    String? phone,
    String? phoneCountryCode,
    String? addressSaveId,
    String? wppPhoneFormated,
  }) {
    return UserDto(
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      addressSaveId: addressSaveId == '' ? null : addressSaveId ?? this.addressSaveId,
      wppPhoneFormated: wppPhoneFormated ?? this.wppPhoneFormated,
    );
  }

  factory UserDto.empty() {
    return UserDto(
      address: AddressEntity(id: uuid),
    );
  }

  factory UserDto.fromAuth() {
    return UserDto(
      address: AddressEntity.empty(),
      name: AuthNotifier.instance.auth.user?.name,
      phone: AuthNotifier.instance.auth.user?.phone,
      addressSaveId: AuthNotifier.instance.auth.user?.currentAddressId,
      phoneCountryCode: AuthNotifier.instance.auth.user?.phoneCountryCode,
      wppPhoneFormated: AuthNotifier.instance.auth.user?.wppPhoneFormated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
      'name': name,
      'phone': phone,
      'phone_country_code': phoneCountryCode,
      'address_save_id': addressSaveId,
      'wpp_phone_formated': wppPhoneFormated,
    };
  }

  factory UserDto.fromMap(Map map) {
    return UserDto(
      address: map['address'] != null ? AddressEntity.fromMap(map['address']) : AddressEntity.empty(),
      name: map['name'],
      phone: map['phone'],
      phoneCountryCode: map['phone_country_code'],
      addressSaveId: map['address_save_id'],
      wppPhoneFormated: map['wpp_phone_formated'],
    );
  }

  String toJson() => json.encode(toMap());

  UserModel buildUser() {
    return UserModel(
      addresses: address != null ? [address!] : [],
      name: name ?? '',
      phone: phone,
      phoneCountryCode: phoneCountryCode,
      currentAddressId: addressSaveId,
      wppPhoneFormated: wppPhoneFormated ?? '',
    );
  }

  factory UserDto.fromJson(String source) => UserDto.fromMap(json.decode(source));
}
