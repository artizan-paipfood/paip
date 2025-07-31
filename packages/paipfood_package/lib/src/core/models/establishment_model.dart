// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:core/core.dart' hide AddressModel;

import 'package:paipfood_package/paipfood_package.dart';

const List<OrderTypeEnum> orderTypesDef = [OrderTypeEnum.takeWay, OrderTypeEnum.delivery];

class EstablishmentModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String companySlug;
  final int currentOrderNumber;
  String fantasyName;
  String corporateName;
  String description;
  String personalDocument;
  String businessDocument;
  bool isOpen;
  bool isBlocked;
  double pendingRate;
  bool isHigherPricePizza;
  String? logo;
  String imageCacheId;
  Uint8List? logoBytes;
  String? banner;
  Uint8List? bannerBytes;
  AddressEntity? address;
  CulinaryStyleEnum culinaryStyle;
  double minimunOrder;
  int dueDate;
  String phone;
  String phoneCountryCode;
  String email;
  List<OrderTypeEnum> orderTypes;
  String? timeDelivery;
  String? timeTakeway;
  String city;
  bool automaticAcceptOrders;
  String? facebookPixel;
  int initialCount;
  bool enableSchedule;
  bool enableScheduleTomorrow;
  PaymentMethodModel? paymentMethod;
  final int deliveryRadius;
  final DeliveryMethod deliveryMethod;
  final DbLocale locale;
  final String? paymentProviderId;
  final double maxDistance;

  EstablishmentModel({
    required this.id,
    required this.companySlug,
    this.currentOrderNumber = 0,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.fantasyName = '',
    this.corporateName = '',
    this.description = '',
    this.personalDocument = '',
    this.businessDocument = '',
    this.isOpen = false,
    this.isBlocked = false,
    this.pendingRate = 0.0,
    this.isHigherPricePizza = false,
    this.logo,
    this.imageCacheId = 'empty',
    this.logoBytes,
    this.banner,
    this.bannerBytes,
    this.culinaryStyle = CulinaryStyleEnum.fastFood,
    this.minimunOrder = 10,
    this.dueDate = 10,
    this.orderTypes = orderTypesDef,
    this.phone = '',
    this.phoneCountryCode = '55',
    this.email = '',
    this.timeDelivery = '40|60',
    this.timeTakeway = '20|30',
    this.city = '',
    this.automaticAcceptOrders = false,
    this.facebookPixel,
    this.initialCount = 0,
    this.enableSchedule = false,
    this.enableScheduleTomorrow = false,
    this.deliveryMethod = DeliveryMethod.polygon,
    this.paymentMethod,
    this.deliveryRadius = 10,
    this.locale = DbLocale.br,
    this.paymentProviderId,
    this.maxDistance = 10,
  });
  static const String box = "establishments";
  EstablishmentModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companySlug,
    int? currentOrderNumber,
    String? fantasyName,
    String? corporateName,
    String? description,
    String? personalDocument,
    String? businessDocument,
    bool? isOpen,
    bool? isBlocked,
    double? pendingRate,
    bool? isHigherPricePizza,
    String? logo,
    String? imageCacheId,
    Uint8List? logoBytes,
    String? banner,
    Uint8List? bannerBytes,
    AddressEntity? address,
    CulinaryStyleEnum? culinaryStyle,
    double? minimunOrder,
    int? dueDate,
    String? phone,
    String? phoneCountryCode,
    String? email,
    List<OrderTypeEnum>? orderTypes,
    String? timeDelivery,
    String? timeTakeway,
    String? city,
    bool? automaticAcceptOrders,
    String? facebookPixel,
    int? initialCount,
    bool? enableSchedule,
    bool? enableScheduleTomorrow,
    PaymentMethodModel? paymentMethod,
    int? deliveryRadius,
    DeliveryMethod? deliveryMethod,
    DbLocale? locale,
    String? paymentProviderId,
    double? maxDistance,
    ResetOrderNumberPeriod? resetOrderNumberPeriod,
    DateTime? resetOrderNumberAt,
    int? resetOrderNumberReference,
  }) {
    return EstablishmentModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      companySlug: companySlug ?? this.companySlug,
      currentOrderNumber: currentOrderNumber ?? this.currentOrderNumber,
      fantasyName: fantasyName ?? this.fantasyName,
      corporateName: corporateName ?? this.corporateName,
      description: description ?? this.description,
      personalDocument: personalDocument ?? this.personalDocument,
      businessDocument: businessDocument ?? this.businessDocument,
      isOpen: isOpen ?? this.isOpen,
      isBlocked: isBlocked ?? this.isBlocked,
      pendingRate: pendingRate ?? this.pendingRate,
      isHigherPricePizza: isHigherPricePizza ?? this.isHigherPricePizza,
      logo: logo ?? this.logo,
      imageCacheId: imageCacheId ?? this.imageCacheId,
      logoBytes: logoBytes ?? this.logoBytes,
      banner: banner ?? this.banner,
      bannerBytes: bannerBytes ?? this.bannerBytes,
      address: address ?? this.address,
      culinaryStyle: culinaryStyle ?? this.culinaryStyle,
      minimunOrder: minimunOrder ?? this.minimunOrder,
      dueDate: dueDate ?? this.dueDate,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      email: email ?? this.email,
      orderTypes: orderTypes ?? this.orderTypes,
      timeDelivery: timeDelivery ?? this.timeDelivery,
      timeTakeway: timeTakeway ?? this.timeTakeway,
      city: city ?? this.city,
      automaticAcceptOrders: automaticAcceptOrders ?? this.automaticAcceptOrders,
      facebookPixel: facebookPixel ?? this.facebookPixel,
      initialCount: initialCount ?? this.initialCount,
      enableSchedule: enableSchedule ?? this.enableSchedule,
      enableScheduleTomorrow: enableScheduleTomorrow ?? this.enableScheduleTomorrow,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryRadius: deliveryRadius ?? this.deliveryRadius,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      locale: locale ?? this.locale,
      paymentProviderId: paymentProviderId ?? this.paymentProviderId,
      maxDistance: maxDistance ?? this.maxDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'current_order_number': currentOrderNumber,
      'company_slug': companySlug,
      'fantasy_name': fantasyName,
      'corporate_name': corporateName,
      'description': description,
      'personal_document': personalDocument,
      'business_document': businessDocument,
      'is_open': isOpen,
      'is_blocked': isBlocked,
      'pending_rate': pendingRate,
      'is_higher_price_pizza': isHigherPricePizza,
      'logo': logo,
      'image_cache_id': imageCacheId,
      'banner': banner,
      'culinary_style': culinaryStyle.name,
      'minimun_order': minimunOrder,
      'due_date': dueDate,
      'order_types': orderTypes.map((e) => e.name).toList(),
      'phone': phone,
      'phone_country_code': phoneCountryCode,
      'email': email,
      'locale': locale.name,
      'time_delivery': timeDelivery,
      'time_takeway': timeTakeway,
      'city': city,
      'automatic_accept_orders': automaticAcceptOrders,
      'facebook_pixel': facebookPixel,
      'initial_count': initialCount,
      'enable_schedule': enableSchedule,
      'enable_schedule_tomorrow': enableScheduleTomorrow,
      'delivery_method': deliveryMethod.name,
      'delivery_radius': deliveryRadius,
      'payment_provider_id': paymentProviderId,
      'max_distance': maxDistance,
    };
  }

  factory EstablishmentModel.fromMap(Map<String, dynamic> map) {
    return EstablishmentModel(
      id: map['id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
      updatedAt: DateTime.parse(map['updated_at']),
      currentOrderNumber: map['current_order_number']?.toInt() ?? 0,
      companySlug: map['company_slug'] ?? '',
      fantasyName: map['fantasy_name'] ?? '',
      corporateName: map['corporate_name'] ?? '',
      description: map['description'] ?? '',
      personalDocument: map['personal_document'] ?? '',
      businessDocument: map['business_document'] ?? '',
      isOpen: map['is_open'] ?? false,
      isBlocked: map['is_blocked'] ?? false,
      pendingRate: map['pending_rate']?.toDouble() ?? 0,
      isHigherPricePizza: map['is_higher_price_pizza'] ?? false,
      logo: map['logo'],
      imageCacheId: map['image_cache_id'] ?? 'empty',
      banner: map['banner'],
      culinaryStyle: map['culinary_style'] != null ? CulinaryStyleEnum.fromMap(map['culinary_style']) : CulinaryStyleEnum.fastFood,
      minimunOrder: map['minimun_order']?.toDouble() ?? 10.00,
      dueDate: map['due_date']?.toInt() ?? 0,
      orderTypes: List<OrderTypeEnum>.from(map['order_types']?.map((value) => OrderTypeEnum.fromMap(value)).toList() ?? []),
      phone: map['phone'] ?? '',
      phoneCountryCode: map['phone_country_code'] ?? '',
      email: map['email'] ?? '',
      timeDelivery: map['time_delivery'],
      timeTakeway: map['time_takeway'],
      city: map['city'],
      automaticAcceptOrders: map['automatic_accept_orders'],
      facebookPixel: map['facebook_pixel'],
      initialCount: map['initial_count']?.toInt() ?? 0,
      enableSchedule: map['enable_schedule'],
      enableScheduleTomorrow: map['enable_schedule_tomorrow'],
      deliveryMethod: DeliveryMethod.fromMap(map['delivery_method']),
      paymentMethod: map['payment_methods'] != null ? PaymentMethodModel.fromMap(map['payment_methods']) : null,
      address: map['address'] != null ? AddressEntity.fromMap(map['address']) : null,
      deliveryRadius: map['delivery_radius']?.toInt() ?? 10,
      locale: map['locale'] != null ? DbLocale.fromMap(map['locale']) : DbLocale.br,
      paymentProviderId: map['payment_provider_id'],
      maxDistance: map['max_distance']?.toDouble() ?? 10,
    );
  }

  String toJson() => json.encode(toMap());
  String? get logoPath => logo == null ? null : "$id-logo.png";
  String? get bannerPath => banner == null ? null : "$id-banner.png";
  String get buildLogoPath => "$id-logo.png";
  String get buildBannerPath => "$id-banner.png";
  String get cacheKeyLogo => "${imageCacheId}logo.png";
  String get cacheKeybanner => "${imageCacheId}banner.png";

  Locale get getLocale {
    if (locale == DbLocale.br) return Locale('pt', 'BR');
    return Locale('en');
  }

  LatLng get latLng => LatLng(address?.lat ?? 0, address?.long ?? 0);

  List<String> get getTimesDelivery => timeDelivery!.split("|");
  List<String> get getTimesTakeway => timeTakeway!.split("|");

  OrderTypeEnum getAvailableByAddress(AddressEntity? address) {
    if (address != null && orderTypes.contains(OrderTypeEnum.delivery)) {
      return OrderTypeEnum.delivery;
    }

    return OrderTypeEnum.takeWay;
  }

  factory EstablishmentModel.fromJson(String source) => EstablishmentModel.fromMap(json.decode(source));
}
