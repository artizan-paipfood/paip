import 'dart:convert';
import 'package:core/core.dart';

class CredentialAuthModel {
  final PhoneNumber? phone;
  final String? email;
  final String? password;

  CredentialAuthModel({this.phone, this.email, this.password});

  CredentialAuthModel copyWith({
    PhoneNumber? phone,
    String? email,
    String? password,
  }) {
    return CredentialAuthModel(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone?.toMap(),
      'email': email,
      'password': password,
    };
  }

  factory CredentialAuthModel.fromMap(Map<String, dynamic> map) {
    return CredentialAuthModel(
      phone: map['phone'] != null ? PhoneNumber.fromMap(map['phone']) : null,
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CredentialAuthModel.fromJson(String source) => CredentialAuthModel.fromMap(json.decode(source));
}
