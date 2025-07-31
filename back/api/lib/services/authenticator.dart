import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:api/services/process_env.dart';

class Authenticator {
  static Map<String, UserModel> _users = {
    'dudu': UserModel(
      id: 'dudu',
      password: '123',
    ),
    'jack': UserModel(
      id: '2',
      password: '321',
    ),
  };

  static const _passwords = {
    // ⚠️ Never store user's password in plain text, these values are in plain text
    // just for the sake of the tutorial.
    'dudu': '123',
    'jack': '321',
  };

  UserModel? findByIdAndPassword({required String id, required String password}) {
    return _users[id];
  }

  static String buildToken({required String id, required String password}) {
    final jwt = JWT({'id': id, 'password': password});
    return jwt.sign(SecretKey(ProcessEnv.secrectKey), expiresIn: Duration(seconds: ProcessEnv.tokenExpiration));
  }

  static String buildRefreshToken({required String id, required String password}) {
    final jwt = JWT({'id': id, 'password': password});
    return jwt.sign(SecretKey(ProcessEnv.secrectKey), expiresIn: Duration(seconds: ProcessEnv.refreshTokenExpiration));
  }

  static String? refreshToken(String refreshToken) {
    final jwt = JWT.verify(refreshToken, SecretKey(ProcessEnv.secrectKey));
    final id = jwt.payload['id'];
    final password = jwt.payload['password'];
    if ((id == null || password == null) && (_validateJwtPayload(jwt.payload) == false)) return null;
    return buildRefreshToken(id: id, password: password);
  }

  static String tokenParse(String token) => token.substring(7).trim();

  static bool _validateJwtPayload(Map payload) {
    return payload['token'] != null;
  }

  static bool validateToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(ProcessEnv.secrectKey));
      if (_validateJwtPayload(jwt.payload)) return true;
      return false;
    } catch (_) {
      return false;
    }
  }
}

class UserModel {
  final String id;
  final String password;

  UserModel({
    required this.id,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      password: password ?? this.password,
    );
  }
}
