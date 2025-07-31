// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class MapboxSessiontokenAdapter extends TypeAdapter<MapboxSessiontoken> {
  @override
  final typeId = 0;

  @override
  MapboxSessiontoken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapboxSessiontoken(
      token: fields[0] as String,
      expiresAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MapboxSessiontoken obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expiresAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapboxSessiontokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
