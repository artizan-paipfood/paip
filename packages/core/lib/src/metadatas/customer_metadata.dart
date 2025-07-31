import 'dart:convert';
import 'package:core/src/entities/address_entity.dart';

class CustomerMetadata {
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
  CustomerMetadata({
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

  static String getFileName(
    String establishmentId,
  ) =>
      '$establishmentId-$box.json';

  CustomerMetadata copyWith({
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
    return CustomerMetadata(
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

  CustomerMetadata clone() {
    return CustomerMetadata(
      name: name,
      phone: phone,
      birthdate: birthdate,
      addresses: addresses
          .map(
            (
              e,
            ) =>
                e.copyWith(),
          )
          .toList(),
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
      'addresses': addresses
          .map(
            (
              x,
            ) =>
                x.toMap(),
          )
          .toList(),
      'address': address?.toMap(),
      'is_single_customer': isSingleCustomer,
      'wpp_phone_formated': wppPhoneFormated,
      'phone_country_code': phoneCountryCode,
      'last_order_at': lastOrderAt?.toUtc().toIso8601String() ?? DateTime.now().toUtc().toIso8601String(),
      'qty_orders': qtyOrders,
    };
  }

  factory CustomerMetadata.fromMap(
    Map map,
  ) {
    return CustomerMetadata(
      userId: map['user_id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      birthdate: map['birthdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['birthdate'],
            )
          : null,
      addresses: List<AddressEntity>.from(
        map['addresses']?.map(
              (
                x,
              ) =>
                  AddressEntity.fromMap(
                x,
              ),
            ) ??
            const [],
      ),
      address: map['address'] != null
          ? AddressEntity.fromMap(
              map['address'],
            )
          : null,
      isSingleCustomer: map['is_single_customer'] ?? false,
      wppPhoneFormated: map['wpp_phone_formated'] ?? '',
      phoneCountryCode: map['phone_country_code'] ?? '+55',
      lastOrderAt: map['last_order_at'] != null
          ? DateTime.parse(
              map['last_order_at'],
            )
          : DateTime.now(),
      qtyOrders: map['qty_orders'] ?? 0,
    );
  }

  // factory CustomerDto.fromUser(UserModel? user) {
  //   return CustomerDto(
  //     userId: user?.id,
  //     name: user?.name ?? '',
  //     phone: user?.phone ?? '',
  //     // birthdate: null,
  //     addresses: [...user?.addresses ?? []],
  //     address: user?.getAddress,
  //     wppPhoneFormated: user?.wppPhoneFormated ?? '',
  //     phoneCountryCode: user?.phoneCountryCode ?? '+55',
  //     // isSingleCustomer: false,
  //     lastOrderAt: DateTime.now(),
  //   );
  // }

  String toJson() => json.encode(
        toMap(),
      );

  factory CustomerMetadata.fromJson(
    String source,
  ) =>
      CustomerMetadata.fromMap(
        json.decode(
          source,
        ),
      );
  // String get getPhoneOnlyNumber {
  //   if (phone.startsWith("0")) {
  //     phone = phone.substring(1, phone.length);
  //   }
  //   return Utils.onlyNumbersRgx("$phoneCountryCode$phone");
  // }
}
