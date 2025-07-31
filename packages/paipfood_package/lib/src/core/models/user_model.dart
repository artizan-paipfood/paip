import 'dart:convert';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

enum Permissions {
  admin,
  cashier;
}

class UserModel {
  final String? id;
  String? email;
  final DateTime? emailConfirmedAt;
  String? phone;
  final DateTime? phoneConfirmedAt;
  final DateTime? confirmedAt;
  final DateTime? lastSignInAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String name;
  List<Permissions>? permissions;
  String? companySlug;
  List<AddressEntity> addresses;
  String? phoneCountryCode;
  String? currentAddressId;
  String wppPhoneFormated;
  String dispositiveAuthId;
  UserModel({
    required this.addresses,
    this.id,
    this.email,
    this.emailConfirmedAt,
    this.phone,
    this.phoneConfirmedAt,
    this.confirmedAt,
    this.lastSignInAt,
    this.createdAt,
    this.updatedAt,
    this.name = "",
    this.permissions,
    this.companySlug,
    this.phoneCountryCode,
    this.currentAddressId,
    this.wppPhoneFormated = '',
    this.dispositiveAuthId = '',
  });

  UserModel copyWith(
      {String? id,
      String? email,
      DateTime? emailConfirmedAt,
      String? phone,
      DateTime? phoneConfirmedAt,
      DateTime? confirmedAt,
      DateTime? lastSignInAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? name,
      List<Permissions>? permissions,
      String? companySlug,
      List<AddressEntity>? addresses,
      String? phoneCountryCode,
      String? currentAddressId,
      String? wppPhoneFormated,
      String? dispositiveAuthId}) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
        phone: phone ?? this.phone,
        phoneConfirmedAt: phoneConfirmedAt ?? this.phoneConfirmedAt,
        confirmedAt: confirmedAt ?? this.confirmedAt,
        lastSignInAt: lastSignInAt ?? this.lastSignInAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        permissions: permissions ?? this.permissions,
        companySlug: companySlug ?? this.companySlug,
        addresses: addresses ?? this.addresses,
        phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
        currentAddressId: currentAddressId ?? this.currentAddressId,
        wppPhoneFormated: wppPhoneFormated ?? this.wppPhoneFormated,
        dispositiveAuthId: dispositiveAuthId ?? this.dispositiveAuthId);
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'email': phone == null ? email : null,
      'email_confirmed_at': emailConfirmedAt?.toIso8601String(),
      'phone': email == null ? Utils.onlyNumbersRgx("$phoneCountryCode$phone") : null,
      'confirmed_at': confirmedAt?.toIso8601String(),
      'phone_confirmed_at': confirmedAt?.toIso8601String(),
      'last_sign_in_at': lastSignInAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMapUsers_() {
    return {
      'id': id,
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'email': email,
      'phone': phone,
      'name': name,
      'permissions': permissions?.map((e) => e.name).toList(),
      'company_slug': companySlug,
      'phone_country_code': phoneCountryCode,
      'current_address_id': currentAddressId,
      'wpp_phone_formated': wppPhoneFormated,
      'dispositive_auth_id': dispositiveAuthId
    };
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
        id: map['id'],
        email: map['email'],
        emailConfirmedAt: map['email_confirmed_at'] != null ? DateTime.parse(map['email_confirmed_at']) : null,
        phone: map['phone'],
        phoneConfirmedAt: map['phone_confirmed_at'] != null ? DateTime.parse(map['phone_confirmed_at']) : null,
        confirmedAt: map['confirmed_at'] != null ? DateTime.parse(map['confirmed_at']) : null,
        lastSignInAt: map['last_sign_in_at'] != null ? DateTime.parse(map['last_sign_in_at']) : null,
        createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
        updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
        name: map['name'] ?? "",
        permissions: map['permissions'] != null ? (map['permissions'] as List).map((permission) => Permissions.values.firstWhere((element) => element.name == permission)).toList() : null,
        companySlug: map['company_slug'],
        phoneCountryCode: map['phone_country_code'],
        addresses: map['addresses'] != null ? (map['addresses'] as List).map((address) => AddressEntity.fromMap(address)).toList() : [],
        currentAddressId: map['current_address_id'],
        wppPhoneFormated: map['wpp_phone_formated'] ?? '',
        dispositiveAuthId: map['dispositive_auth_id'] ?? '');
  }
  static const String box = "users";
  String toJson() => json.encode(toMap());
  String toJsonUsers_() => json.encode(toMapUsers_());

  AddressEntity? get getAddress => addresses.firstWhereOrNull((element) => element.id == currentAddressId);

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, emailConfirmedAt: $emailConfirmedAt, phone: $phone, phoneConfirmedAt: $phoneConfirmedAt, confirmedAt: $confirmedAt, lastSignInAt: $lastSignInAt, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, permissions: $permissions, companySlug: $companySlug)';
  }
}
