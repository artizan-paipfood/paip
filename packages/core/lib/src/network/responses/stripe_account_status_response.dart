import 'dart:convert';

class StripeAccountStatusResponse {
  final bool chargesEnabled;
  final List<String> currentlyDue;
  StripeAccountStatusResponse({
    required this.chargesEnabled,
    required this.currentlyDue,
  });

  Map<String, dynamic> toMap() {
    return {
      'charges_enabled': chargesEnabled,
      'currently_due': currentlyDue,
    };
  }

  factory StripeAccountStatusResponse.fromMap(Map<String, dynamic> map) {
    return StripeAccountStatusResponse(
      chargesEnabled: map['charges_enabled'] ?? false,
      currentlyDue: List<String>.from(map['currently_due']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeAccountStatusResponse.fromJson(String source) => StripeAccountStatusResponse.fromMap(json.decode(source));

  StripeAccountStatusResponse copyWith({
    bool? chargesEnabled,
    List<String>? currentlyDue,
  }) {
    return StripeAccountStatusResponse(
      chargesEnabled: chargesEnabled ?? this.chargesEnabled,
      currentlyDue: currentlyDue ?? this.currentlyDue,
    );
  }
}
