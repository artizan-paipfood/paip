
class RetrieveAccountResponse {
  final bool chargesEnabled;
  final List<String> currentlyDue;
  RetrieveAccountResponse({
    required this.chargesEnabled,
    this.currentlyDue = const [],
  });

  RetrieveAccountResponse copyWith({
    bool? chargesEnabled,
    List<String>? currentlyDue,
  }) {
    return RetrieveAccountResponse(
      chargesEnabled: chargesEnabled ?? this.chargesEnabled,
      currentlyDue: currentlyDue ?? this.currentlyDue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'charges_enabled': chargesEnabled,
      'currently_due': currentlyDue,
    };
  }

  factory RetrieveAccountResponse.fromMap(Map<String, dynamic> map) {
    return RetrieveAccountResponse(
      chargesEnabled: map['charges_enabled'] ?? false,
      currentlyDue: List<String>.from(map['requirements']['currently_due'] ?? []),
    );
  }
}
