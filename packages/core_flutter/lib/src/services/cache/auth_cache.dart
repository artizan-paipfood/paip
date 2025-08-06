import 'dart:convert';

import 'package:core_flutter/core_flutter.dart';

class AuthTokensCache {
  AuthTokensCache._();

  static late ICacheService _cacheService;

  static AuthTokens? _tokens;
  static late Duration _expiration;

  static Future<void> initialize({required ICacheService cacheService, required Duration expiration}) async {
    _cacheService = cacheService;
    _expiration = expiration;
  }

  static Future<AuthTokens?> get() async {
    if (_tokens == null) return _tokens;
    final data = await _cacheService.get(box: 'auth_tokens');
    if (data != null) {
      _tokens = AuthTokens.fromMap(data);
    }
    return _tokens;
  }

  static Future<void> save(AuthTokens tokens) async {
    DateTime expiresAt = DateTime.now().add(_expiration);

    final cachedTokens = await get();
    if (cachedTokens != null) {
      expiresAt = cachedTokens.expiresAt ?? DateTime.now().add(_expiration);
    }

    await _cacheService.save(
      box: 'auth_tokens',
      data: tokens.toMap(),
      expiresAt: expiresAt,
    );
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;

  AuthTokens({required this.accessToken, required this.refreshToken, required this.expiresAt});

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  factory AuthTokens.fromMap(Map<String, dynamic> map) {
    return AuthTokens(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokens.fromJson(String source) => AuthTokens.fromMap(json.decode(source));
}
