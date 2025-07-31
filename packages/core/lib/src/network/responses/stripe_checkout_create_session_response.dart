import 'dart:convert';

class StripeCheckoutCreateSessionResponse {
  final String id;
  final String url;
  StripeCheckoutCreateSessionResponse({
    required this.id,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory StripeCheckoutCreateSessionResponse.fromMap(Map<String, dynamic> map) {
    return StripeCheckoutCreateSessionResponse(
      id: map['id'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeCheckoutCreateSessionResponse.fromJson(String source) => StripeCheckoutCreateSessionResponse.fromMap(json.decode(source));
}
