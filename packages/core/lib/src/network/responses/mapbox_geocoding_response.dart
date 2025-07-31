class MapboxGeocodingResponse {
  final double latitude;
  final double longitude;
  MapboxGeocodingResponse({required this.latitude, required this.longitude});

  factory MapboxGeocodingResponse.fromMap(Map<String, dynamic> map) {
    final _center = map['features'][0]['geometry']['coordinates'] ?? [];
    final _latitude = _center[1] ?? 0.0;
    final _longitude = _center[0] ?? 0.0;
    return MapboxGeocodingResponse(latitude: _latitude, longitude: _longitude);
  }
}
