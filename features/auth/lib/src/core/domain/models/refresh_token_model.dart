import 'dart:convert';

import 'package:core/core.dart';

class RefreshTokenModel {
  final PhoneNumber? phone;
  final String? email;
  final String? password;
  final String refreshToken;
  final String dispositiveAuthId;
  final DateTime expiresAt;
  RefreshTokenModel({
    required this.expiresAt,
    this.phone,
    this.email,
    this.password,
    this.refreshToken = '',
    this.dispositiveAuthId = '',
  });

  static const String prefsKey = 'paipfood_refresh_token_dto';

  Map<String, dynamic> toMap() {
    return {
      'phone': phone?.toMap(),
      'email': email,
      'password': password,
      'refresh_token': refreshToken,
      'dispositive_auth_id': dispositiveAuthId,
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  factory RefreshTokenModel.fromMap(Map<String, dynamic> map) {
    return RefreshTokenModel(
      phone: map['phone'] != null ? PhoneNumber.fromMap(map['phone']) : null,
      email: map['email'],
      password: map['password'],
      refreshToken: map['refresh_token'],
      dispositiveAuthId: map['dispositive_auth_id'],
      expiresAt: DateTime.parse(map['expires_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshTokenModel.fromJson(String source) => RefreshTokenModel.fromMap(json.decode(source));

  factory RefreshTokenModel.fromAuthenticatedUser({
    required AuthenticatedUser authenticatedUser,
    required String dispositiveAuthId,
    required DateTime expiresAt,
    String? password,
  }) {
    return RefreshTokenModel(
      dispositiveAuthId: dispositiveAuthId,
      phone: authenticatedUser.user.userMetadata.phoneNumber,
      refreshToken: authenticatedUser.refreshToken,
      email: authenticatedUser.user.email,
      password: password,
      expiresAt: expiresAt,
    );
  }

  AuthenticatorProvider provider() {
    if (phone != null) return AuthenticatorProvider.phone;
    if (email != null) return AuthenticatorProvider.email;
    throw Exception('Invalid provider');
  }
}
