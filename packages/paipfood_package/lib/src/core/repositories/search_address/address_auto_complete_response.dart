import 'dart:convert';

class AddressAutoCompleteResponse {
  final String description;
  final String placeId;
  final String mainText;
  final String secondaryText;
  AddressAutoCompleteResponse({
    required this.description,
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'place_id': placeId,
      'main_text': mainText,
      'secondary_text': secondaryText,
    };
  }

  factory AddressAutoCompleteResponse.fromMap(Map<String, dynamic> map) {
    return AddressAutoCompleteResponse(
      description: map['description'],
      placeId: map['place_id'],
      mainText: map['main_text'],
      secondaryText: map['secondary_text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressAutoCompleteResponse.fromJson(String source) => AddressAutoCompleteResponse.fromMap(json.decode(source));
}
