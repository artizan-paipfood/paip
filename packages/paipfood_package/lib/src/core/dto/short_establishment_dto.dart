import 'dart:convert';
import 'package:core/core.dart';

class ShortEstablishmentDto {
  final String id;
  final String fantasyName;
  final String? corporateName;
  final String? banner;
  final String? logo;
  final bool isOpen;
  final String companySlug;
  final AddressEntity address;
  ShortEstablishmentDto({
    required this.address,
    required this.id,
    required this.fantasyName,
    required this.companySlug,
    this.corporateName,
    this.banner,
    this.logo,
    this.isOpen = false,
  });

  ShortEstablishmentDto copyWith({
    String? id,
    String? fantasyName,
    String? corporateName,
    String? banner,
    String? logo,
    bool? isOpen,
    String? companySlug,
    AddressEntity? address,
  }) {
    return ShortEstablishmentDto(
      id: id ?? this.id,
      fantasyName: fantasyName ?? this.fantasyName,
      corporateName: corporateName ?? this.corporateName,
      banner: banner ?? this.banner,
      logo: logo ?? this.logo,
      isOpen: isOpen ?? this.isOpen,
      companySlug: companySlug ?? this.companySlug,
      address: address ?? this.address,
    );
  }

  factory ShortEstablishmentDto.fromMap(Map<String, dynamic> map) {
    return ShortEstablishmentDto(
      id: map['id'] ?? '',
      fantasyName: map['fantasy_name'] ?? '',
      corporateName: map['corporate_name'],
      banner: map['banner'],
      logo: map['logo'],
      isOpen: map['isOpen'] ?? false,
      companySlug: map['company_slug'] ?? '',
      address: AddressEntity.fromMap(map['address']),
    );
  }

  String? get logoPath => logo == null ? null : "$id-logo.png";
  String? get bannerPath => banner == null ? null : "$id-banner.png";

  factory ShortEstablishmentDto.fromJson(String source) => ShortEstablishmentDto.fromMap(json.decode(source));
}
