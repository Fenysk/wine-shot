// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegionModelAdapter extends TypeAdapter<RegionModel> {
  @override
  final int typeId = 1;

  @override
  RegionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegionModel(
      id: fields[0] as String,
      name: fields[1] as String,
      countryId: fields[2] as String?,
      parentId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.countryId)
      ..writeByte(3)
      ..write(obj.parentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) => RegionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      countryId: json['country_id'] as String?,
      parentId: json['parent_id'] as String?,
    );
