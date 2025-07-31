import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

enum PlatformEnum {
  android,
  ios,
  windows;

  static PlatformEnum fromMap(String value) => PlatformEnum.values.firstWhere((element) => element.name == value);
}

class VersionModel {
  final int id;
  final DateTime createdAt;
  final String version;
  final String? urlDownload;
  final PlatformEnum platform;
  final String? fileName;

  final bool isRequired;

  VersionModel({
    required this.id,
    required this.createdAt,
    required this.version,
    required this.platform,
    required this.isRequired,
    this.fileName,
    this.urlDownload,
  });

  VersionModel copyWith({
    int? id,
    DateTime? createdAt,
    String? version,
    String? urlDownload,
    PlatformEnum? platform,
    String? fileName,
    bool? isRequired,
  }) {
    return VersionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
      urlDownload: urlDownload ?? this.urlDownload,
      platform: platform ?? this.platform,
      fileName: fileName ?? this.fileName,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.pToTimesTamptzFormat(),
      'version': version,
      'url_download': urlDownload,
      'platform': platform.name,
      'file_name': fileName,
      'is_required': isRequired
    };
  }

  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      id: map['id'].toInt(),
      createdAt: DateTime.parse(map['created_at']),
      version: map['version'] ?? '',
      urlDownload: map['url_download'],
      platform: PlatformEnum.fromMap(map['platform']),
      fileName: map['file_name'],
      isRequired: map['is_required'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionModel.fromJson(String source) => VersionModel.fromMap(json.decode(source));
}
