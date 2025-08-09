import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class DriverAndUserAdapter {
  final bool isAccepted;
  final DriverModel driver;
  final UserModel user;
  DriverAndUserAdapter({
    required this.driver,
    required this.user,
    this.isAccepted = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'driver': driver.toMap(),
      'user': user.toMap(),
      'is_accepted': isAccepted,
    };
  }

  factory DriverAndUserAdapter.fromMap(Map map) {
    return DriverAndUserAdapter(
      isAccepted: map['is_accepted'] ?? true,
      driver: DriverModel.fromMap(map),
      user: UserModel.fromMap(List.from(map['users'])[0]),
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverAndUserAdapter.fromJson(String source) => DriverAndUserAdapter.fromMap(json.decode(source));
}
