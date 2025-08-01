import 'dart:convert';

import 'package:core/core.dart';

class UserPhoneModel {
  final String name;
  final String phoneDialCode;
  final String phoneNumber;

  UserPhoneModel({
    required this.name,
    required this.phoneDialCode,
    required this.phoneNumber,
  });

  UserPhoneModel copyWith({
    String? name,
    String? phoneDialCode,
    String? phoneNumber,
  }) {
    return UserPhoneModel(
      name: name ?? this.name,
      phoneDialCode: phoneDialCode ?? this.phoneDialCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneDialCode': phoneDialCode,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserPhoneModel.fromMap(Map<String, dynamic> map) {
    return UserPhoneModel(
      name: map['name'] ?? '',
      phoneDialCode: map['phoneDialCode'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  PhoneNumber buildPhoneNumber() => PhoneNumber(number: phoneNumber, dialCode: phoneDialCode);

  factory UserPhoneModel.fromJson(String source) => UserPhoneModel.fromMap(json.decode(source));
}
