import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthTokensCache {
  AuthTokensCache._();

  static late ICacheService _cacheService;

  static AuthTokens? _tokens;
  static late Duration _expiration;

  static Credentials? _credentials;

  static Future<void> initialize({required ICacheService cacheService, required Duration expiration}) async {
    _cacheService = cacheService;
    _expiration = expiration;
  }

  static Future<AuthTokens?> getTokens() async {
    if (_tokens == null) return _tokens;
    final data = await _cacheService.get(box: 'auth_tokens');
    if (data != null) {
      _tokens = AuthTokens.fromMap(data);
    }
    return _tokens;
  }

  static Future<void> saveTokens(AuthTokens tokens) async {
    DateTime expiresAt = DateTime.now().add(_expiration);

    final cachedTokens = await getTokens();
    if (cachedTokens != null) {
      expiresAt = cachedTokens.expiresAt ?? DateTime.now().add(_expiration);
    }

    await _cacheService.save(
      box: 'auth_tokens',
      data: tokens.toMap(),
      expiresAt: expiresAt,
    );
    _tokens = tokens;
  }

  static Future<Credentials?> getCredentials() async {
    if (_credentials != null) return _credentials;
    final data = await _cacheService.get(box: 'credentials');
    if (data != null) {
      _credentials = Credentials.fromMap(data);
    }
    return _credentials;
  }

  static Future<void> saveCredentials(Credentials credentials) async {
    _credentials = credentials;
    await _cacheService.save(box: 'credentials', data: credentials.toMap());
  }

  static Future<void> clear() async {
    _tokens = null;
    _credentials = null;
    await _cacheService.delete(box: 'auth_tokens');
    await _cacheService.delete(box: 'credentials');
  }

  static void getAuthTokens() {}
}

class Credentials {
  final PhoneNumber? phone;
  final String? email;
  final String? password;
  final DateTime? expiresAt;

  Credentials({
    this.phone,
    this.email,
    this.password,
    this.expiresAt,
  });

  Credentials copyWith({
    PhoneNumber? phone,
    String? email,
    String? password,
    DateTime? expiresAt,
  }) {
    return Credentials(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone?.toMap(),
      'email': email,
      'password': password,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      phone: map['phone'] != null ? PhoneNumber.fromMap(map['phone']) : null,
      email: map['email'],
      password: map['password'],
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : null,
    );
  }

  AuthenticatorProvider? provider() {
    if (phone != null) return AuthenticatorProvider.phone;
    if (email != null && password != null) return AuthenticatorProvider.email;
    return null;
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;
  final String? dispositiveAuthId;

  AuthTokens({required this.accessToken, required this.refreshToken, required this.expiresAt, this.dispositiveAuthId});

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt?.toIso8601String(),
      'dispositiveAuthId': dispositiveAuthId,
    };
  }

  factory AuthTokens.fromMap(Map<String, dynamic> map) {
    return AuthTokens(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : null,
      dispositiveAuthId: map['dispositiveAuthId'],
    );
  }
}
