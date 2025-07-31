import 'dart:convert';

import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class RefreshTokenDto {
  final String phone;
  final String phoneCountryCode;
  final String email;
  final String password;
  final String refreshToken;
  final String dispositiveAuthId;
  RefreshTokenDto({
    this.phone = '',
    this.password = '',
    this.email = '',
    this.phoneCountryCode = '',
    this.refreshToken = '',
    this.dispositiveAuthId = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
      'phone_country_code': phoneCountryCode,
      'refresh_token': refreshToken,
      'dispositive_auth_id': dispositiveAuthId,
      'email': email,
    };
  }

  factory RefreshTokenDto.fromToken(String token) {
    final decode = JwtService.decodeToken(token: token, secret: Env.secretKey);
    return RefreshTokenDto.fromMap(decode);
  }

  factory RefreshTokenDto.fromMap(Map map) {
    return RefreshTokenDto(
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      phoneCountryCode: map['phone_country_code'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      dispositiveAuthId: map['dispositive_auth_id'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshTokenDto.fromJson(String source) => RefreshTokenDto.fromMap(json.decode(source));
  factory RefreshTokenDto.fromAuth({
    required AuthModel auth,
    required String dispositiveAuthId,
  }) {
    return RefreshTokenDto(
      dispositiveAuthId: dispositiveAuthId,
      phone: auth.user!.phone!,
      refreshToken: auth.refreshToken!,
      email: auth.user!.email!,
      phoneCountryCode: auth.user!.phoneCountryCode ?? '55',
      password: Utils.encodePasswordPhone(countryCode: auth.user!.phoneCountryCode ?? '55', phone: auth.user!.phone!),
    );
  }

  RefreshTokenDto copyWith({
    String? phone,
    String? password,
    String? phoneCountryCode,
    String? refreshToken,
    String? dispositiveAuthId,
  }) {
    return RefreshTokenDto(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      refreshToken: refreshToken ?? this.refreshToken,
      dispositiveAuthId: dispositiveAuthId ?? this.dispositiveAuthId,
    );
  }
}
