import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class UserEntity {
  final String id;
  final String email;
  final DateTime? emailConfirmedAt;
  final String? phone;
  final DateTime? confirmedAt;
  final DateTime? recoverySentAt;
  final DateTime? lastSignInAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserMetadata userMetadata;
  UserEntity({
    required this.id,
    required this.email,
    this.emailConfirmedAt,
    this.phone,
    this.confirmedAt,
    this.recoverySentAt,
    this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userMetadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': userMetadata.toMap(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    try {
      return UserEntity(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        emailConfirmedAt: map['email_confirmed_at'] != null ? DateTime.parse(map['email_confirmed_at']) : null,
        phone: map['phone'],
        confirmedAt: map['confirmed_at'] != null ? DateTime.parse(map['confirmed_at']) : null,
        recoverySentAt: map['recovery_sent_at'] != null ? DateTime.parse(map['recovery_sent_at']) : null,
        lastSignInAt: map['last_sign_in_at'] != null ? DateTime.parse(map['last_sign_in_at']) : null,
        createdAt: DateTime.parse(map['created_at']),
        updatedAt: DateTime.parse(map['updated_at']),
        userMetadata: UserMetadata.fromMap(map['user_metadata']),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'UserEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  UserEntity copyWith({
    String? email,
    String? phone,
    UserMetadata? userMetadata,
  }) {
    return UserEntity(
      id: id,
      email: email ?? this.email,
      emailConfirmedAt: emailConfirmedAt,
      phone: phone ?? this.phone,
      confirmedAt: confirmedAt,
      recoverySentAt: recoverySentAt,
      lastSignInAt: lastSignInAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userMetadata: userMetadata ?? this.userMetadata,
    );
  }
}

class UserMetadata {
  final String sub;
  final String fullName;
  final String? email;
  final bool? emailVerified;
  final String? phone;
  final bool? phoneVerified;
  //* CUSTOM FIELDS
  final String? document;
  final String? documentType;
  final DateTime? birthDate;
  final String? gender;
  final PhoneNumber? phoneNumber;
  final String? dispositiveAuthId;
  final String? selectedAddressId;
  //* END CUSTOM FIELDS
  UserMetadata({required this.sub, required this.fullName, this.email, this.emailVerified, this.phone, this.phoneVerified, this.document, this.documentType, this.birthDate, this.gender, this.phoneNumber, this.dispositiveAuthId, this.selectedAddressId});

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'document': document,
      'document_type': documentType,
      'birth_date': birthDate?.toPaipDB(),
      'gender': gender,
      'phone_number': phoneNumber?.toMap(),
      'dispositive_auth_id': dispositiveAuthId,
      'selected_address_id': selectedAddressId,
    };
  }

  factory UserMetadata.fromMap(Map<String, dynamic> map) {
    try {
      return UserMetadata(
        sub: map['sub'] ?? '',
        fullName: map['full_name'] ?? '',
        email: map['email'],
        emailVerified: map['email_verified'],
        phone: map['phone'],
        phoneVerified: map['phone_verified'],
        document: map['document'],
        documentType: map['document_type'],
        birthDate: map['birth_date'] != null ? DateTime.parse(map['birth_date']) : null,
        gender: map['gender'],
        phoneNumber: map['phone_number'] != null ? PhoneNumber.fromMap(map['phone_number']) : null,
        dispositiveAuthId: map['dispositive_auth_id'],
        selectedAddressId: map['selected_address_id'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'UserMetadata', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory UserMetadata.fromJson(String source) => UserMetadata.fromMap(json.decode(source));

  UserMetadata copyWith({
    String? sub,
    String? fullName,
    String? email,
    bool? emailVerified,
    String? phone,
    bool? phoneVerified,
    String? document,
    String? documentType,
    DateTime? birthDate,
    String? gender,
    PhoneNumber? phoneNumber,
    String? dispositiveAuthId,
    String? selectedAddressId,
  }) {
    return UserMetadata(
      sub: sub ?? this.sub,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phone: phone ?? this.phone,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      document: document ?? this.document,
      documentType: documentType ?? this.documentType,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dispositiveAuthId: dispositiveAuthId ?? this.dispositiveAuthId,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
    );
  }
}

class PhoneNumber {
  final String dialCode;
  final String number;
  PhoneNumber({
    required this.dialCode,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'dial_code': dialCode,
      'number': number,
    };
  }

  factory PhoneNumber.fromMap(Map<String, dynamic> map) {
    try {
      return PhoneNumber(
        dialCode: map['dial_code'] ?? '',
        number: map['number'] ?? '',
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'PhoneNumber', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory PhoneNumber.fromJson(String source) => PhoneNumber.fromMap(json.decode(source));

  PhoneNumber copyWith({
    String? dialCode,
    String? number,
  }) {
    return PhoneNumber(
      dialCode: dialCode ?? this.dialCode,
      number: number ?? this.number,
    );
  }

  String fullPhoneOnlyNumbers() => "$dialCode$number".onlyNumbers();

  void validate() {
    if (dialCode.isEmpty || number.isEmpty) {
      throw ArgumentError('Dial code and number are required');
    }
    if (dialCode.length < 2) {
      throw ArgumentError('Dial code must be 2 digits');
    }
    if (number.length < 4) {
      throw ArgumentError('Number must be 4 digits');
    }
  }
}

class AuthenticatedUser {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final String refreshToken;
  final UserEntity user;
  AuthenticatedUser({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.expiresAt,
    required this.refreshToken,
    required this.user,
  });

  factory AuthenticatedUser.fromMap(Map<String, dynamic> map) {
    try {
      return AuthenticatedUser(
        accessToken: map['access_token'],
        tokenType: map['token_type'],
        expiresIn: map['expires_in'],
        expiresAt: map['expires_at'],
        refreshToken: map['refresh_token'],
        user: UserEntity.fromMap(map['user']),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'AuthenticatedUser', stackTrace: StackTrace.current);
    }
  }

  factory AuthenticatedUser.fromJson(String source) => AuthenticatedUser.fromMap(json.decode(source));

  AuthenticatedUser copyWith({
    UserEntity? user,
  }) {
    return AuthenticatedUser(
      accessToken: accessToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
      expiresAt: expiresAt,
      refreshToken: refreshToken,
      user: user ?? this.user,
    );
  }
}
