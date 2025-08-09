import 'dart:convert';

import 'package:paipfood_package/src/core/models/adapters/wpp/wpp_evolution_instance.dart';

class WppEvolutionQrcodeModel {
  String pairingCode;
  String code;
  String base64;
  int count;
  String instanceName;
  WppStatus state;
  WppEvolutionQrcodeModel({
    required this.state,
    this.pairingCode = '',
    this.code = '',
    this.base64 = '',
    this.count = 0,
    this.instanceName = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'pairingCode': pairingCode,
      'code': code,
      'base64': base64,
      'count': count,
      'instanceName': instanceName,
      'state': state,
    };
  }

  factory WppEvolutionQrcodeModel.fromMap(Map map) {
    return WppEvolutionQrcodeModel(
      pairingCode: map['pairingCode'] ?? '',
      code: map['code'] ?? '',
      base64: map['base64'] ?? '',
      count: map['count']?.toInt() ?? 0,
      instanceName: map['instanceName'] ?? '',
      state: map['state'] != null ? WppStatus.fromMap(map['state']) : WppStatus.close,
    );
  }

  String toJson() => json.encode(toMap());

  factory WppEvolutionQrcodeModel.fromJson(String source) => WppEvolutionQrcodeModel.fromMap(json.decode(source));
}
