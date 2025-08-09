import 'dart:convert';

enum ImageMenuType {
  product,
  item,
  complement;
}

class ImageMenuModel {
  String path;
  String id;
  ImageMenuType imageMenuType;
  ImageMenuModel({
    required this.path,
    required this.id,
    required this.imageMenuType,
  });
  static const String box = 'image_menu';
  ImageMenuModel copyWith({
    String? path,
    String? id,
    ImageMenuType? imageMenuType,
  }) {
    return ImageMenuModel(
      path: path ?? this.path,
      id: id ?? this.id,
      imageMenuType: imageMenuType ?? this.imageMenuType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'id': id,
      'imageMenuType': imageMenuType.name,
    };
  }

  factory ImageMenuModel.fromMap(Map map) {
    return ImageMenuModel(
      path: map['path'] ?? '',
      id: map['id'] ?? '',
      imageMenuType: ImageMenuType.values.firstWhere((element) => element.name == map['imageMenuType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageMenuModel.fromJson(String source) => ImageMenuModel.fromMap(json.decode(source));
}
