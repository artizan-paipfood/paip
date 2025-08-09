import 'dart:convert';

class EstablishmentIdDto {
  final String establishmentId;
  EstablishmentIdDto({
    this.establishmentId = '',
  });

  static const String box = 'establishment_id';

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
    };
  }

  factory EstablishmentIdDto.fromMap(Map map) {
    return EstablishmentIdDto(
      establishmentId: map['establishment_Id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentIdDto.fromJson(String source) => EstablishmentIdDto.fromMap(json.decode(source));
}
