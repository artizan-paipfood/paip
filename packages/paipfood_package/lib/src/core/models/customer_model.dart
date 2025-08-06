import 'dart:convert';

import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CustomerModel {
  String? userId;
  String name;
  String phone;
  String phoneCountryCode;
  DateTime? birthdate;
  List<AddressEntity> addresses;
  AddressEntity? address;
  bool isSingleCustomer;
  String wppPhoneFormated;
  DateTime? lastOrderAt;
  int qtyOrders;

  CustomerModel({
    required this.addresses,
    this.lastOrderAt,
    this.phoneCountryCode = '+44',
    this.userId,
    this.name = '',
    this.phone = '',
    this.birthdate,
    this.address,
    this.isSingleCustomer = false,
    this.wppPhoneFormated = '',
    this.qtyOrders = 0,
  });

  static String box = 'customer_model';

  static String getFileName(String establishmentId) => '$establishmentId-$box.json';

  CustomerModel copyWith({
    String? userId,
    String? name,
    String? phone,
    String? phoneCountryCode,
    DateTime? birthdate,
    List<AddressEntity>? addresses,
    AddressEntity? address,
    bool? isSingleCustomer,
    String? wppPhoneFormated,
    DateTime? lastOrderAt,
    int? qtyOrders,
  }) {
    return CustomerModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      birthdate: birthdate ?? this.birthdate,
      addresses: addresses ?? this.addresses,
      address: address ?? this.address,
      isSingleCustomer: isSingleCustomer ?? this.isSingleCustomer,
      wppPhoneFormated: wppPhoneFormated ?? this.wppPhoneFormated,
      lastOrderAt: lastOrderAt ?? this.lastOrderAt,
      qtyOrders: qtyOrders ?? this.qtyOrders,
    );
  }

  CustomerModel clone() {
    return CustomerModel(
      name: name,
      phone: phone,
      birthdate: birthdate,
      addresses: addresses.map((e) => e.copyWith()).toList(),
      address: address,
      isSingleCustomer: isSingleCustomer,
      wppPhoneFormated: wppPhoneFormated,
      userId: userId,
      phoneCountryCode: phoneCountryCode,
      lastOrderAt: lastOrderAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'phone': phone,
      'birthdate': birthdate?.millisecondsSinceEpoch,
      'addresses': addresses.map((x) => x.toMap()).toList(),
      'address': address?.toMap(),
      'is_single_customer': isSingleCustomer,
      'wpp_phone_formated': wppPhoneFormated,
      'phone_country_code': phoneCountryCode,
      'last_order_at': lastOrderAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
      'qty_orders': qtyOrders
    };
  }

  factory CustomerModel.fromMap(Map map) {
    return CustomerModel(
      userId: map['user_id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      birthdate: map['birthdate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthdate']) : null,
      addresses: List<AddressEntity>.from(map['addresses']?.map((x) => AddressEntity.fromMap(x)) ?? const []),
      address: map['address'] != null ? AddressEntity.fromMap(map['address']) : null,
      isSingleCustomer: map['is_single_customer'] ?? false,
      wppPhoneFormated: map['wpp_phone_formated'] ?? '',
      phoneCountryCode: map['phone_country_code'] ?? '+55',
      lastOrderAt: map['last_order_at'] != null ? DateTime.parse(map['last_order_at']) : DateTime.now(),
      qtyOrders: map['qty_orders'] ?? 0,
    );
  }
  factory CustomerModel.fromUser(UserModel? user) {
    return CustomerModel(
      userId: user?.id,
      name: user?.name ?? '',
      phone: user?.phone ?? '',
      // birthdate: null,
      addresses: [...user?.addresses ?? []],
      address: user?.getAddress,
      wppPhoneFormated: user?.wppPhoneFormated ?? '',
      phoneCountryCode: user?.phoneCountryCode ?? '+55',
      // isSingleCustomer: false,
      lastOrderAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source));
  String get getPhoneOnlyNumber {
    if (PaipAppLocale.locale.isGb && phone.startsWith("0")) {
      phone = phone.substring(1, phone.length);
    }
    return Utils.onlyNumbersRgx("$phoneCountryCode$phone");
  }
}

class CustomerDeliveryTaxPolygon {
  final String addressId;
  final double distance;
  final double straightDistance;
  CustomerDeliveryTaxPolygon({
    required this.addressId,
    required this.distance,
    required this.straightDistance,
  });
  static String box = 'paip_customer_delivery_tax_polygon';

  CustomerDeliveryTaxPolygon copyWith({
    String? addressId,
    double? distance,
    double? straightDistance,
  }) {
    return CustomerDeliveryTaxPolygon(
      addressId: addressId ?? this.addressId,
      distance: distance ?? this.distance,
      straightDistance: straightDistance ?? this.straightDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_id': addressId,
      'distance': distance,
      'straight_distance': straightDistance,
    };
  }

  factory CustomerDeliveryTaxPolygon.fromMap(Map map) {
    return CustomerDeliveryTaxPolygon(
      addressId: map['address_id'],
      distance: map['distance']?.toDouble() ?? 0.0,
      straightDistance: map['straight_distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDeliveryTaxPolygon.fromJson(String source) => CustomerDeliveryTaxPolygon.fromMap(json.decode(source));
}
