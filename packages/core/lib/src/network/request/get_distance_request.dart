class GetDistanceRequest {
  /// The `originlat` is the latitude coordinate of the starting location.
  /// /// The `originlong` is the longitude coordinate of the starting location.
  /// /// The `destlat` is the latitude coordinate of the ending location.
  ///  /// The `destlong` is the longitude coordinate of the ending location.
  final double originlat;
  final double originlong;
  final double destlat;
  final double destlong;
  final String? userAddessId;
  final String? establishmentAddressId;

  GetDistanceRequest({
    required this.originlat,
    required this.originlong,
    required this.destlat,
    required this.destlong,
    this.userAddessId,
    this.establishmentAddressId,
  }) {
    if (userAddessId != null && establishmentAddressId == null || establishmentAddressId != null && userAddessId == null) {
      throw FormatException('Both user_address_id and establishment_address_id must be provided');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "originlat": originlat,
      "originlong": originlong,
      "destlat": destlat,
      "destlong": destlong,
      "user_address_id": userAddessId,
      "establishment_address_id": establishmentAddressId,
    };
  }

  factory GetDistanceRequest.fromMap(Map<String, dynamic> map) {
    return GetDistanceRequest(
      originlat: map['originlat'],
      originlong: map['originlong'],
      destlat: map['destlat'],
      destlong: map['destlong'],
      userAddessId: map['user_address_id'],
      establishmentAddressId: map['establishment_address_id'],
    );
  }
}
