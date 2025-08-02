import 'package:core/core.dart';

class AddressManuallyModel {
  final AddressEntity address;
  final bool addressWithoutNumber;
  final bool addressWithoutComplement;

  AddressManuallyModel({
    required this.address,
    required this.addressWithoutNumber,
    required this.addressWithoutComplement,
  });

  AddressManuallyModel copyWith({
    AddressEntity? address,
    bool? addressWithoutNumber,
    bool? addressWithoutComplement,
  }) {
    return AddressManuallyModel(
      address: address ?? this.address,
      addressWithoutNumber: addressWithoutNumber ?? this.addressWithoutNumber,
      addressWithoutComplement: addressWithoutComplement ?? this.addressWithoutComplement,
    );
  }
}
