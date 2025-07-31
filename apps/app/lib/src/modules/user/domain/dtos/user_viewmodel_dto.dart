import 'dart:convert';

import 'package:app/src/modules/user/domain/dtos/user_dto.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:core/core.dart';

class UserViewmodelCacheDto {
  final UserDto userDto;
  final UserNavigationMode userNavigationMode;
  final bool isZipCode = false;
  final String finishRoute;
  final AddressEntity? establishmentAdress;
  final String? establishmentId;
  UserViewmodelCacheDto({
    required this.userDto,
    this.userNavigationMode = UserNavigationMode.loginPickup,
    this.finishRoute = '/login',
    this.establishmentAdress,
    this.establishmentId,
  });
  static String key = 'paip_user_viewmodel_cache';
  Map<String, dynamic> toMap() {
    return {
      'user_dto': userDto.toMap(),
      'user_navigation_mode': userNavigationMode.name,
      'finish_route': finishRoute,
      'establishment_adress': establishmentAdress?.toMap(),
      'establishment_id': establishmentId,
    };
  }

  factory UserViewmodelCacheDto.fromMap(Map map) {
    return UserViewmodelCacheDto(
      userDto: UserDto.fromMap(map['user_dto']),
      userNavigationMode: UserNavigationMode.fromMap(map['user_navigation_mode']),
      finishRoute: map['finish_route'] ?? '',
      establishmentAdress: map['establishment_adress'] != null ? AddressEntity.fromMap(map['establishment_adress']) : null,
      establishmentId: map['establishment_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserViewmodelCacheDto.fromJson(String source) => UserViewmodelCacheDto.fromMap(json.decode(source));

  UserViewmodelCacheDto copyWith({
    UserDto? userDto,
    UserNavigationMode? userNavigationMode,
    String? finishRouteName,
    AddressEntity? establishmentAdress,
    String? establishmentId,
  }) {
    return UserViewmodelCacheDto(
      userDto: userDto ?? this.userDto,
      userNavigationMode: userNavigationMode ?? this.userNavigationMode,
      finishRoute: finishRouteName ?? finishRoute,
      establishmentAdress: establishmentAdress ?? this.establishmentAdress,
      establishmentId: establishmentId ?? this.establishmentId,
    );
  }
}
