import 'package:flutter/material.dart';

enum OrderTypeEnum {
  delivery("entrega", Colors.green),
  takeWay("retirada", Colors.orange),
  consume("consumo", Colors.blueAccent),
  kiosk("kiosk", Colors.deepPurpleAccent),

  table("mesa", Colors.red),
  undefined("undefined", Colors.black);

  final String i18nText;
  final Color color;

  bool get isDelivery => this == OrderTypeEnum.delivery;

  bool get isTakeWay => this == OrderTypeEnum.takeWay;

  bool get isConsume => this == OrderTypeEnum.consume;

  bool get isKiosk => this == OrderTypeEnum.kiosk;

  bool get isTable => this == OrderTypeEnum.table;

  bool get isUndefined => this == OrderTypeEnum.undefined;

  const OrderTypeEnum(this.i18nText, this.color);

  static OrderTypeEnum fromMap(String value) {
    return OrderTypeEnum.values.firstWhere((element) => element.name == value);
  }
}
