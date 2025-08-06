import 'dart:convert';

import 'package:core/core.dart';

class GeocodeRequest {
  /// Representa uma requisição de geocodificação com uma consulta, país e limites opcionais.
  ///
  /// O `query` é o termo de busca para a requisição de geocodificação.
  /// O `locale` define o idioma e região para os resultados.
  /// O `address` é o modelo de endereço base para complementar com os dados de geocodificação.
  /// O `lat` é a latitude opcional do ponto central para limitar a busca.
  /// O `lon` é a longitude opcional do ponto central para limitar a busca.
  /// O `radius` é o raio opcional em metros para limitar a busca ao redor do ponto central.
  ///
  /// Se `lat`, `lon` ou `radius` forem fornecidos, todos devem ser não-nulos.
  final String query;
  final AppLocaleCode locale;
  final AddressModel address;
  final double? lat;
  final double? lon;
  final int? radius;

  GeocodeRequest({
    required this.query,
    required this.locale,
    required this.address,
    this.lat,
    this.lon,
    this.radius,
  });

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'locale': locale.name,
      'address': address.toMap(),
      'lat': lat,
      'lon': lon,
      'radius': radius,
    };
  }

  factory GeocodeRequest.fromMap(Map<String, dynamic> map) {
    return GeocodeRequest(
      query: map['query'] ?? '',
      locale: AppLocaleCode.fromMap(map['locale']),
      address: AddressModel.fromMap(map['address']),
      lat: map['lat']?.toDouble(),
      lon: map['lon']?.toDouble(),
      radius: map['radius']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeocodeRequest.fromJson(String source) => GeocodeRequest.fromMap(json.decode(source));
}
