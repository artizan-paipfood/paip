import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class EstablishmentEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fantasyName;
  final String? corporateName;
  final String? description;
  final String? personalDocument;
  final String? businessDocument;
  final bool isOpen;
  final bool? isBlocked;
  final double? pendingRate;
  final bool? isHigherPricePizza;
  final String? logo;
  final double? minimunOrder;
  final int? dueDate;
  final String? banner;
  final String companySlug;
  final List<OrderType> orderTypes;
  final CulinaryStyle? culinaryStyle;
  final String? phone;
  final String? phoneCountryCode;
  final String email;
  final int totalOrders;
  final int currentOrderNumber;
  final int currentLocalOrderNumber;
  final List<PaymentType> paymentTypes;
  final String timeDelivery;
  final String timeTakeway;
  final String city;
  final bool? automaticAcceptOrders;
  final String imageCacheId;
  final bool enableSchedule;
  final bool enableScheduleTomorrow;
  final int? deliveryRadius;
  final String deliveryMethod;
  final String? facebookPixel;
  final AppLocaleCode? locale;
  final String? paymentProviderId;
  final double? maxDistance;

  static const String table = 'establishments';

  EstablishmentEntity({
    required this.id,
    this.createdAt,
    this.fantasyName,
    this.corporateName,
    this.description,
    this.personalDocument,
    this.businessDocument,
    this.isOpen = false,
    this.isBlocked,
    this.pendingRate,
    this.isHigherPricePizza,
    this.logo,
    this.minimunOrder,
    this.dueDate,
    this.updatedAt,
    this.banner,
    required this.companySlug,
    required this.orderTypes,
    this.culinaryStyle,
    this.phone,
    this.phoneCountryCode,
    required this.email,
    this.totalOrders = 0,
    this.currentOrderNumber = 0,
    this.currentLocalOrderNumber = 1000,
    this.paymentTypes = const [],
    this.timeDelivery = '40|60',
    this.timeTakeway = '20|30',
    required this.city,
    this.automaticAcceptOrders,
    this.imageCacheId = '',
    this.enableSchedule = false,
    this.enableScheduleTomorrow = false,
    this.deliveryRadius,
    this.deliveryMethod = 'polygon',
    this.facebookPixel,
    this.locale,
    this.paymentProviderId,
    this.maxDistance,
  });

  EstablishmentEntity copyWith({
    String? id,
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
    double? minimunOrder,
    int? dueDate,
    String? banner,
    String? companySlug,
    List<OrderType>? orderTypes,
    CulinaryStyle? culinaryStyle,
    String? phone,
    String? phoneCountryCode,
    String? email,
    int? totalOrders,
    int? currentOrderNumber,
    int? currentLocalOrderNumber,
    List<PaymentType>? paymentTypes,
    String? timeDelivery,
    String? timeTakeway,
    String? city,
    bool? automaticAcceptOrders,
    String? imageCacheId,
    bool? enableSchedule,
    bool? enableScheduleTomorrow,
    int? deliveryRadius,
    String? deliveryMethod,
    String? facebookPixel,
    AppLocaleCode? locale,
    String? paymentProviderId,
    double? maxDistance,
  }) {
    return EstablishmentEntity(
      id: id ?? this.id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
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
      minimunOrder: minimunOrder ?? this.minimunOrder,
      dueDate: dueDate ?? this.dueDate,
      banner: banner ?? this.banner,
      companySlug: companySlug ?? this.companySlug,
      orderTypes: orderTypes ?? this.orderTypes,
      culinaryStyle: culinaryStyle ?? this.culinaryStyle,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      email: email ?? this.email,
      totalOrders: totalOrders ?? this.totalOrders,
      currentOrderNumber: currentOrderNumber ?? this.currentOrderNumber,
      currentLocalOrderNumber: currentLocalOrderNumber ?? this.currentLocalOrderNumber,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      timeDelivery: timeDelivery ?? this.timeDelivery,
      timeTakeway: timeTakeway ?? this.timeTakeway,
      city: city ?? this.city,
      automaticAcceptOrders: automaticAcceptOrders ?? this.automaticAcceptOrders,
      imageCacheId: imageCacheId ?? this.imageCacheId,
      enableSchedule: enableSchedule ?? this.enableSchedule,
      enableScheduleTomorrow: enableScheduleTomorrow ?? this.enableScheduleTomorrow,
      deliveryRadius: deliveryRadius ?? this.deliveryRadius,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      facebookPixel: facebookPixel ?? this.facebookPixel,
      locale: locale ?? this.locale,
      paymentProviderId: paymentProviderId ?? this.paymentProviderId,
      maxDistance: maxDistance ?? this.maxDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt?.toPaipDB(),
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
      'minimun_order': minimunOrder,
      'due_date': dueDate,
      'updated_at': updatedAt?.toPaipDB(),
      'banner': banner,
      'company_slug': companySlug,
      'order_types': orderTypes.map((e) => e.name).toList(),
      'culinary_style': culinaryStyle?.name,
      'phone': phone,
      'phone_country_code': phoneCountryCode,
      'email': email,
      'id': id,
      'total_orders': totalOrders,
      'current_order_number': currentOrderNumber,
      'current_local_order_number': currentLocalOrderNumber,
      'payment_types': paymentTypes.map((e) => e.name).toList(),
      'time_delivery': timeDelivery,
      'time_takeway': timeTakeway,
      'city': city,
      'automatic_accept_orders': automaticAcceptOrders,
      'image_cache_id': imageCacheId,
      'enable_schedule': enableSchedule,
      'enable_schedule_tomorrow': enableScheduleTomorrow,
      'delivery_radius': deliveryRadius,
      'delivery_method': deliveryMethod,
      'facebook_pixel': facebookPixel,
      'locale': locale?.name,
      'payment_provider_id': paymentProviderId,
      'max_distance': maxDistance,
    };
  }

  factory EstablishmentEntity.fromMap(Map<String, dynamic> map) {
    try {
      return EstablishmentEntity(
        createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
        fantasyName: map['fantasy_name'],
        corporateName: map['corporate_name'],
        description: map['description'],
        personalDocument: map['personal_document'],
        businessDocument: map['business_document'],
        isOpen: map['is_open'],
        isBlocked: map['is_blocked'],
        pendingRate: map['pending_rate']?.toDouble(),
        isHigherPricePizza: map['is_higher_price_pizza'],
        logo: map['logo'],
        minimunOrder: map['minimun_order']?.toDouble(),
        dueDate: map['due_date']?.toInt(),
        updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
        banner: map['banner'],
        companySlug: map['company_slug'] ?? '',
        orderTypes: (map['order_types'] as List<dynamic>?)?.map((e) => OrderType.values.firstWhere((v) => v.name == e)).toList() ?? [],
        culinaryStyle: map['culinary_style'] != null ? CulinaryStyle.values.firstWhere((v) => v.name == map['culinary_style']) : null,
        phone: map['phone'],
        phoneCountryCode: map['phone_country_code'],
        email: map['email'] ?? '',
        id: map['id'] ?? const Uuid().v4(),
        totalOrders: map['total_orders']?.toInt() ?? 0,
        currentOrderNumber: map['current_order_number']?.toInt() ?? 0,
        currentLocalOrderNumber: map['current_local_order_number']?.toInt() ?? 1000,
        paymentTypes: (map['payment_types'] as List<dynamic>?)?.map((e) => PaymentType.values.firstWhere((v) => v.name == e)).toList() ?? [],
        timeDelivery: map['time_delivery'] ?? '40|60',
        timeTakeway: map['time_takeway'] ?? '20|30',
        city: map['city'] ?? '',
        automaticAcceptOrders: map['automatic_accept_orders'],
        imageCacheId: map['image_cache_id'] ?? '',
        enableSchedule: map['enable_schedule'] ?? false,
        enableScheduleTomorrow: map['enable_schedule_tomorrow'] ?? false,
        deliveryRadius: map['delivery_radius']?.toInt(),
        deliveryMethod: map['delivery_method'] ?? 'polygon',
        facebookPixel: map['facebook_pixel'],
        locale: map['locale'] != null ? AppLocaleCode.fromMap(map['locale']) : null,
        paymentProviderId: map['payment_provider_id'],
        maxDistance: map['max_distance']?.toDouble(),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'EstablishmentEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentEntity.fromJson(String source) => EstablishmentEntity.fromMap(json.decode(source));

  //*******************************************************
  // custom methods
  //*******************************************************

  String? get logoPath => logo == null ? null : "${AppCoreConstants.baseUrlAws}/$id-logo.png";
  String? get bannerPath => banner == null ? null : "${AppCoreConstants.baseUrlAws}/$id-banner.png";
  String get buildLogoPath => "$id-logo.png";
  String get buildBannerPath => "$id-banner.png";
  String get cacheKeyLogo => "${imageCacheId}logo.png";
  String get cacheKeybanner => "${imageCacheId}banner.png";

  List<String> get getTimesDelivery => timeDelivery.split("|");
  List<String> get getTimesTakeway => timeTakeway.split("|");
}
