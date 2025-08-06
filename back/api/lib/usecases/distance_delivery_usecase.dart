import 'package:api/apis/adress/address_user_establishment_api.dart';
import 'package:api/repositories/address/delivery_repository.dart';
import 'package:api/dtos/distance_dto.dart';
import 'package:api/services/utils.dart';
import 'package:core/core.dart';

class DistanceDeliveryUsecase {
  final IDeliveryRepository addressRespository;
  final IAddressUserEstablishmentApi addressUserEstablishmentApi;

  DistanceDeliveryUsecase({required this.addressRespository, required this.addressUserEstablishmentApi});

  Future<DeliveryTaxResponse> getDeliveryTax({
    required String establishmentId,
    required double lat,
    required double long,
    required double establishmentLat,
    required double establishmentLong,
    required DeliveryMethod deliveryMethod,
    required AppLocaleCode locale,
    required String establishmentAddressId,
    String? userAddressId,
  }) async {
    if (deliveryMethod == DeliveryMethod.miles) {
      final result = await getDistance(originlat: lat, originlong: long, destlat: establishmentLat, destlong: establishmentLong, userAddressId: userAddressId, establishmentAddressId: establishmentAddressId);

      final price = await addressRespository.getTaxByDistance(establishmentId: establishmentId, distanceRadius: result.distance.convertMetersToRadius(locale));

      return DeliveryTaxResponse(deliveryMethod: deliveryMethod, straightDistance: result.straightDistance, distance: result.distance, price: price);
    }

    final result = await getDeliveryTaxPolygon(establishmentId: establishmentId, lat: lat, long: long);

    final straightDistance = BackUtils.calculateStraightDistance(lat1: lat, lon1: long, lat2: establishmentLat, lon2: establishmentLong);
    return DeliveryTaxResponse(deliveryMethod: deliveryMethod, price: result.price, straightDistance: straightDistance.toDouble());
  }

  Future<DeliveryTaxPolygonResponse> getDeliveryTaxPolygon({required String establishmentId, required double lat, required double long}) async {
    final response = await addressRespository.getDeliveryAreaByLatLong(establishmentId: establishmentId, lat: lat, long: long);

    if (response == null) {
      return DeliveryTaxPolygonResponse(price: 0);
    }
    return DeliveryTaxPolygonResponse(price: response.price, deliveryAreaId: response.id);
  }

  Future<DistanceDto> getDistance({
    required double originlat,
    required double originlong,
    required double destlat,
    required double destlong,
    String? establishmentAddressId,
    String? userAddressId,
  }) async {
    if (userAddressId != null && establishmentAddressId != null) {
      final addressUserEstablishmentResponse = await addressUserEstablishmentApi.get(userAddressId: userAddressId, establishmentAddressId: establishmentAddressId);

      if (addressUserEstablishmentResponse != null) {
        return DistanceDto(distance: addressUserEstablishmentResponse.distance, straightDistance: addressUserEstablishmentResponse.straightDistance);
      }
    }

    final distance = await addressRespository.getDistance(originlat: originlat, originlong: originlong, destlat: destlat, destlong: destlong);

    if (userAddressId != null && establishmentAddressId != null) {
      final entity = AddressUserEstablishmentEntity(distance: distance.distance, userAddressId: userAddressId, establishmentAddressId: establishmentAddressId, straightDistance: distance.straightDistance);

      await addressUserEstablishmentApi.create(entity);
    }
    return distance;
  }
}
