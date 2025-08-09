import 'dart:convert';

enum WppStatus {
  notInitialized,
  open,
  connecting,
  close,
  created;

  const WppStatus();

  static WppStatus fromMap(String status) => WppStatus.values.firstWhere((test) => test.name == status, orElse: () => WppStatus.close);
}

class WppEvolutionInstance {
  String apiKey;
  WppStatus status;
  WppEvolutionInstance({
    required this.status,
    this.apiKey = '',
  });

  WppEvolutionInstance copyWith({
    String? apiKey,
    WppStatus? status,
  }) {
    return WppEvolutionInstance(
      apiKey: apiKey ?? this.apiKey,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apiKey': apiKey,
      'status': status,
    };
  }

  factory WppEvolutionInstance.fromMap(Map<String, dynamic> map) {
    return WppEvolutionInstance(
      apiKey: map['apikey'] ?? '',
      status: WppStatus.fromMap(map['status']),
    );
  }

  factory WppEvolutionInstance.onCreate(Map<String, dynamic> map) {
    return WppEvolutionInstance(
      apiKey: map['hash']['apikey'] ?? '',
      status: WppStatus.fromMap(map['instance']['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WppEvolutionInstance.fromJson(String source) => WppEvolutionInstance.fromMap(json.decode(source));
}
