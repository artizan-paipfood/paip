import 'dart:convert';

class StripeCreateAccountResponse {
  final String accountId;
  final String link;

  StripeCreateAccountResponse({required this.accountId, required this.link});

  StripeCreateAccountResponse copyWith({
    String? accountId,
    String? link,
  }) {
    return StripeCreateAccountResponse(
      accountId: accountId ?? this.accountId,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'link': link,
    };
  }

  factory StripeCreateAccountResponse.fromMap(Map<String, dynamic> map) {
    return StripeCreateAccountResponse(
      accountId: map['account_id'] ?? '',
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeCreateAccountResponse.fromJson(String source) => StripeCreateAccountResponse.fromMap(json.decode(source));
}
