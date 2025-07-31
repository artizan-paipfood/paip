import 'dart:convert';

import 'package:core/core.dart';

class PostalcodeGeocodeRequest {
  /// Representa uma requisição de geocodificação com uma consulta, país e limites opcionais.
  ///
  /// O `postalCode` é o termo de busca para a requisição de geocodificação.
  /// O `provider` especifica o provedor de serviço de geocodificação (Google ou Mapbox).
  /// O `locale` define o idioma e região para os resultados.
  /// O `address` é o modelo de endereço base para complementar com os dados de geocodificação.
  /// O `lat` é a latitude opcional do ponto central para limitar a busca.
  /// O `lon` é a longitude opcional do ponto central para limitar a busca.
  /// O `radius` é o raio opcional em metros para limitar a busca ao redor do ponto central.
  ///
  /// Se `lat`, `lon` ou `radius` forem fornecidos, todos devem ser não-nulos.
  final String postalCode;
  final AutoCompleteProvider provider;
  final DbLocale locale;
  final double? lat;
  final double? lon;
  final int? radius;

  PostalcodeGeocodeRequest({
    required this.postalCode,
    required this.provider,
    required this.locale,
    this.lat,
    this.lon,
    this.radius,
  });

  Map<String, dynamic> toMap() {
    return {
      'postal_code': postalCode,
      'provider': provider.name,
      'locale': locale.name,
      'lat': lat,
      'lon': lon,
      'radius': radius,
    };
  }

  factory PostalcodeGeocodeRequest.fromMap(Map<String, dynamic> map) {
    return PostalcodeGeocodeRequest(
      postalCode: map['postal_code'] ?? '',
      provider: AutoCompleteProvider.values.byName(map['provider']),
      locale: DbLocale.fromMap(map['locale']),
      lat: map['lat']?.toDouble(),
      lon: map['lon']?.toDouble(),
      radius: map['radius']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostalcodeGeocodeRequest.fromJson(String source) => PostalcodeGeocodeRequest.fromMap(json.decode(source));
}
