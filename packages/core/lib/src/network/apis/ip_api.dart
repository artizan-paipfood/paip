import 'dart:convert';

import 'package:core/core.dart';

abstract class IIpApi {
  Future<IpApiResponse> get();
}

class IpApi implements IIpApi {
  IpApi({required this.client});

  final IClient client;

  @override
  Future<IpApiResponse> get() async {
    final response = await client.get('https://ipapi.co/json/');
    return IpApiResponse.fromJson(response.data);
  }
}

class IpApiResponse {
  final String status;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String timezone;
  final String isp;
  final String org;
  final String as;
  final String query;
  IpApiResponse({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.as,
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'country': country,
      'countryCode': countryCode,
      'region': region,
      'regionName': regionName,
      'city': city,
      'zip': zip,
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'isp': isp,
      'org': org,
      'as': as,
      'query': query,
    };
  }

  factory IpApiResponse.fromMap(Map<String, dynamic> map) {
    return IpApiResponse(
      status: map['status'] ?? '',
      country: map['country'] ?? '',
      countryCode: map['countryCode'] ?? '',
      region: map['region'] ?? '',
      regionName: map['regionName'] ?? '',
      city: map['city'] ?? '',
      zip: map['zip'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      timezone: map['timezone'] ?? '',
      isp: map['isp'] ?? '',
      org: map['org'] ?? '',
      as: map['as'] ?? '',
      query: map['query'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IpApiResponse.fromJson(String source) => IpApiResponse.fromMap(json.decode(source));
}
