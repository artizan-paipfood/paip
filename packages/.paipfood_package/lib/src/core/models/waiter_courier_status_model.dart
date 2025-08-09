// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';

class WaiterCourierStatusModel {
  String email;
  String phone;
  CourierStatusEnum status;

  WaiterCourierStatusModel({
    required this.email,
    required this.phone,
    required this.status,
  });

  WaiterCourierStatusModel copyWith({
    String? email,
    String? phone,
    CourierStatusEnum? status,
  }) {
    return WaiterCourierStatusModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'status': status.name,
    };
  }

  factory WaiterCourierStatusModel.fromMap(Map<String, dynamic> map) {
    return WaiterCourierStatusModel(
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      status: CourierStatusEnum.fromMap(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WaiterCourierStatusModel.fromJson(Map<String, dynamic> source) => WaiterCourierStatusModel.fromMap(source);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WaiterCourierStatusModel && other.email == email && other.phone == phone && other.status == status;
  }

  @override
  int get hashCode {
    return email.hashCode ^ phone.hashCode ^ status.hashCode;
  }
}

enum CourierStatusEnum {
  ASSIGNED(Colors.amber),
  ACCEPTED(Colors.green),
  COLLECTED(Colors.amber),
  COMPLETED(Colors.grey);

  final Color color;
  const CourierStatusEnum(this.color);

  static CourierStatusEnum fromMap(String name) {
    return CourierStatusEnum.values.firstWhere((element) => element.name == name, orElse: () => CourierStatusEnum.ASSIGNED);
  }
}
