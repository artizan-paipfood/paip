import 'dart:convert';

import 'package:core/core.dart';

class AutoCompleteRequest {
  /// Representa uma requisição de autocompletar endereço.
  ///
  /// Se `lat`, `lon` ou `radius` forem fornecidos, nenhum deles pode ser nulo.
  ///
  /// O `query` é o termo de busca para autocompletar.
  /// O `locale` define o idioma e região para os resultados.
  /// O `lat` é a latitude opcional do ponto central para limitar a busca.
  /// O `lon` é a longitude opcional do ponto central para limitar a busca.
  /// O `radius` é o raio opcional para limitar a busca.
  final String query;
  final AppLocaleCode locale;
  final double? lat;
  final double? lon;
  final int? radius;
  AutoCompleteRequest({
    required this.query,
    required this.locale,
    this.lat,
    this.lon,
    this.radius,
  }) {
    if ((lat != null && lon == null) || (lon != null && lat == null)) {
      throw ArgumentError('If lat, lon or radius are provided, all must be provided together');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'locale': locale.name,
      'lat': lat,
      'lon': lon,
      'radius': radius,
    };
  }

  factory AutoCompleteRequest.fromMap(Map<String, dynamic> map) {
    return AutoCompleteRequest(
      query: map['query'] ?? '',
      locale: AppLocaleCode.values.byName(map['locale']),
      lat: map['lat']?.toDouble(),
      lon: map['lon']?.toDouble(),
      radius: map['radius']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoCompleteRequest.fromJson(String source) => AutoCompleteRequest.fromMap(json.decode(source));
}
