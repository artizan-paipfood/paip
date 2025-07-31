import 'dart:convert';

class GoogleAutoCompleteResponse {
  final String description;
  final String placeId;
  final String mainText;
  final String secondaryText;

  GoogleAutoCompleteResponse({required this.description, required this.placeId, this.mainText = '', this.secondaryText = ''});

  Map<String, dynamic> toMap() {
    return {'description': description, 'place_id': placeId, 'main_text': mainText, 'secondary_text': secondaryText};
  }

  factory GoogleAutoCompleteResponse.fromMap(Map<String, dynamic> map) {
    return GoogleAutoCompleteResponse(description: map['description'] ?? '', placeId: map['place_id'] ?? '', mainText: map['structured_formatting']['main_text'] ?? '', secondaryText: map['structured_formatting']['secondary_text'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory GoogleAutoCompleteResponse.fromJson(String source) => GoogleAutoCompleteResponse.fromMap(json.decode(source));
}
