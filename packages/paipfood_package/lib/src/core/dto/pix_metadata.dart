import 'dart:convert';

enum PixKeyType {
  cpf(label: "CPF", mask: "###.###.###-##"),
  cnpj(label: "CNPJ", mask: "##.###.###/####-##"),
  telefone(label: "Telefone", mask: "(##)# ####-####"),
  email(label: "E-mail"),
  aleatoria(label: "Aleatória");

  final String label;
  final String? mask;
  const PixKeyType({required this.label, this.mask});

  static PixKeyType fromMap(String value) {
    return PixKeyType.values.firstWhere((element) => element.name == value);
  }
}

class PixMetadata {
  final String key;
  final PixKeyType type;
  final String receipientName;

  PixMetadata(
      {required this.key, required this.type, required this.receipientName});

  PixMetadata copyWith({
    String? key,
    PixKeyType? type,
    String? receipientName,
  }) {
    return PixMetadata(
      key: key ?? this.key,
      type: type ?? this.type,
      receipientName: receipientName ?? this.receipientName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'type': type.name,
      'receipient_name': receipientName,
    };
  }

  factory PixMetadata.fromMap(Map<String, dynamic> map) {
    return PixMetadata(
      key: map['key'] ?? '',
      type: PixKeyType.fromMap(map['type']),
      receipientName: map['receipient_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PixMetadata.fromJson(String source) =>
      PixMetadata.fromMap(json.decode(source));
}
