import 'dart:convert';

import 'package:core/src/entities/zz_entities_export.dart';

class UserMe {
  final String id;
  final UserMetadata metadata;
  final List<AddressEntity> addresses;
  UserMe({
    required this.id,
    required this.metadata,
    required this.addresses,
  });
  UserMetadata get data => metadata;

  UserMe copyWith({
    String? id,
    UserMetadata? metadata,
    List<AddressEntity>? addresses,
  }) {
    return UserMe(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      addresses: addresses ?? this.addresses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'metadata': metadata.toMap(),
      'addresses': addresses.map((x) => x.toMap()).toList(),
    };
  }

  factory UserMe.fromMap(Map<String, dynamic> map) {
    return UserMe(
      id: map['id'] ?? '',
      metadata: UserMetadata.fromMap(map['metadata']),
      addresses: List<AddressEntity>.from(map['addresses']?.map((x) => AddressEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMe.fromJson(String source) => UserMe.fromMap(json.decode(source));
}
