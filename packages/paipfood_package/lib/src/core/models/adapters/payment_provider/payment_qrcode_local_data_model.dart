import 'dart:convert';

class PaymentQrcodeLocalDataModel {
  String? keyType;
  String? key;
  String? bankData;
  PaymentQrcodeLocalDataModel({
    this.keyType,
    this.key,
    this.bankData,
  });

  PaymentQrcodeLocalDataModel copyWith({
    String? keyType,
    String? key,
    String? bankData,
  }) {
    return PaymentQrcodeLocalDataModel(
      keyType: keyType ?? this.keyType,
      key: key ?? this.key,
      bankData: bankData ?? this.bankData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key_type': keyType,
      'key': key,
      'bank_data': bankData,
    };
  }

  factory PaymentQrcodeLocalDataModel.fromMap(Map<String, dynamic> map) {
    return PaymentQrcodeLocalDataModel(
      keyType: map['key_type'],
      key: map['key'],
      bankData: map['bank_data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentQrcodeLocalDataModel.fromJson(String source) => PaymentQrcodeLocalDataModel.fromMap(json.decode(source));
}
