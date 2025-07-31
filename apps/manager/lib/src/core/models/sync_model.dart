import 'dart:convert';

import 'package:flutter/material.dart';

ValueNotifier<SyncRequestModel> syncRequest = ValueNotifier(SyncRequestModel());

class SyncRequestModel {
  bool menu;
  bool deliveryAreas;

  SyncRequestModel({
    this.menu = false,
    this.deliveryAreas = false,
  });
  SyncRequestModel copyWith({
    bool? menu,
    bool? deliveryAreas,
  }) {
    return SyncRequestModel(
      menu: menu ?? this.menu,
      deliveryAreas: deliveryAreas ?? this.deliveryAreas,
    );
  }

  static const String box = 'sync_request';
  Map<String, dynamic> toMap() {
    return {
      'menu': menu,
      'deliveryAreas': deliveryAreas,
    };
  }

  factory SyncRequestModel.fromMap(Map map) {
    return SyncRequestModel(
      menu: map['menu'] ?? false,
      deliveryAreas: map['deliveryAreas'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SyncRequestModel.fromJson(String source) => SyncRequestModel.fromMap(json.decode(source));
}
