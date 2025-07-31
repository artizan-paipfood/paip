import 'dart:convert';

class CardInformationModel {
  final String email;
  final String number;
  final String name;
  final String date;
  final String cvv;

  CardInformationModel({
    required this.email,
    required this.number,
    required this.name,
    required this.date,
    required this.cvv,
  });

  CardInformationModel copyWith({
    String? email,
    String? number,
    String? name,
    String? date,
    String? cvv,
  }) {
    return CardInformationModel(
      email: email ?? this.email,
      number: number ?? this.number,
      name: name ?? this.name,
      date: date ?? this.date,
      cvv: cvv ?? this.cvv,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'number': number,
      'name': name,
      'date': date,
      'cvv': cvv,
    };
  }

  factory CardInformationModel.fromMap(Map<String, dynamic> map) {
    return CardInformationModel(
      email: map['email'] ?? '',
      number: map['number'] ?? '',
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      cvv: map['cvv'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CardInformationModel.fromJson(String source) => CardInformationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardInformationModel(email: $email, number: $number, name: $name, date: $date, cvv: $cvv)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CardInformationModel &&
      other.email == email &&
      other.number == number &&
      other.name == name &&
      other.date == date &&
      other.cvv == cvv;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      number.hashCode ^
      name.hashCode ^
      date.hashCode ^
      cvv.hashCode;
  }
}
