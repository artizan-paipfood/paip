import 'dart:convert';

class PixResponse {
  final String id;
  final String qrCode;
  final double amount;

  PixResponse({
    required this.id,
    required this.qrCode,
    required this.amount,
  });

  PixResponse copyWith({
    String? id,
    String? qrCode,
    double? amount,
  }) {
    return PixResponse(
      id: id ?? this.id,
      qrCode: qrCode ?? this.qrCode,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrCode': qrCode,
      'amount': amount,
    };
  }

  factory PixResponse.fromMap(Map<String, dynamic> map) {
    return PixResponse(
      id: map['id'],
      qrCode: map['qrCode'],
      amount: map['amount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PixResponse.fromJson(String source) => PixResponse.fromMap(json.decode(source));
}
