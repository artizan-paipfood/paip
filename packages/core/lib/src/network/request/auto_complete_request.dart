import 'dart:convert';

import 'package:core/core.dart';

class AutoCompleteRequest {
  /// Representa uma requisição de autocompletar endereço.
  ///
  /// Se `lat`, `lon` ou `radius` forem fornecidos, nenhum deles pode ser nulo.
  ///
  /// O `query` é o termo de busca para autocompletar.
  /// O `locale` define o idioma e região para os resultados.
  /// O `provider` especifica o provedor de serviço (Google ou Mapbox).
  /// O `lat` é a latitude opcional do ponto central para limitar a busca.
  /// O `lon` é a longitude opcional do ponto central para limitar a busca.
  final String query;
  final DbLocale locale;
  final AutoCompleteProvider provider;
  final double? lat;
  final double? lon;
  AutoCompleteRequest({
    required this.query,
    required this.locale,
    required this.provider,
    this.lat,
    this.lon,
  }) {
    if ((lat != null || lon == null || lon != null && lat == null)) {
      throw ArgumentError('If lat, lon or radius are provided, all must be provided together');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'locale': locale.name,
      'provider': provider.name,
      'lat': lat,
      'lon': lon,
    };
  }

  factory AutoCompleteRequest.fromMap(Map<String, dynamic> map) {
    return AutoCompleteRequest(
      query: map['query'] ?? '',
      locale: DbLocale.values.byName(map['locale']),
      provider: AutoCompleteProvider.values.byName(map['provider']),
      lat: map['lat']?.toDouble(),
      lon: map['lon']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoCompleteRequest.fromJson(String source) => AutoCompleteRequest.fromMap(json.decode(source));
}
