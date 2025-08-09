// import 'package:core/core.dart' hide JwtService;
// import 'package:paipfood_package/paipfood_package.dart';
// import 'package:core/src/request/delivery_tax_polygon_response.dart';

// class SearchAddressRepository implements ISearchAddressRepository {
//   final IClient http;
//   SearchAddressRepository({
//     required this.http,
//   });
//   Map<String, dynamic> buildAuthorization() {
//     final token = JwtService.buildToken(map: JwtService.toMap('token'), expiresIn: 2.hours, secret: Env.secretKey);
//     return {"Authorization": "Bearer $token"};
//   }

//   @override
//   Future<List<AddressAutoCompleteResponse>> autoComplete({required String query, required String country, double? latitudeFilter, double? longitudeFilter, int? radius}) async {
//     final request = await http.post('/v1/address/auto_complete', headers: buildAuthorization(), data: {
//       'query': query,
//       'country': country,
//       'lat': latitudeFilter,
//       'lon': longitudeFilter,
//       'radius': radius,
//     });
//     final List list = List.from(request.data);
//     return list.map((e) => AddressAutoCompleteResponse.fromMap(e)).toList();
//   }

//   @override
//   Future<AddressGeocodeResponse> geocode({required String query, required String country, String? bounds}) async {
//     final request = await http.post('/v1/address/geocode', headers: buildAuthorization(), data: {
//       'query': query,
//       'country': country,
//       'bounds': bounds,
//     });

//     return AddressGeocodeResponse.fromMap(request.data);
//   }

//   @override
//   Future<DeliveryTaxResponse> getDeliveryTax({required DeliveryTaxRequest deliveryTax}) async {
//     final request = await http.post('/v1/address/delivery_tax', headers: buildAuthorization(), data: deliveryTax.toMap());
//     return DeliveryTaxResponse.fromMap(request.data);
//   }

//   @override
//   Future<DeliveryTaxPolygonResponse> getDeliveryTaxPolygon({required double lat, required double long, required String establishmentId}) async {
//     final request = await http.post('/v1/address/delivery_tax_polygon', headers: buildAuthorization(), data: {
//       'lat': lat,
//       'long': long,
//       'establishment_id': establishmentId,
//     });
//     return DeliveryTaxPolygonResponse.fromMap(request.data);
//   }

//   @override
//   Future<GetDistanceResponse> getDistance({required GetDistanceRequest getDistanceRequest}) async {
//     final request = await http.post('/v1/address/get_distance', headers: buildAuthorization(), data: getDistanceRequest.toMap());
//     return GetDistanceResponse.fromMap(request.data);
//   }
// }
