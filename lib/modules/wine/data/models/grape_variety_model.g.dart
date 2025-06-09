// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grape_variety_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrapeVarietyModelAdapter extends TypeAdapter<GrapeVarietyModel> {
  @override
  final int typeId = 5;

  @override
  GrapeVarietyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrapeVarietyModel(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GrapeVarietyModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrapeVarietyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrapeVarietyModel _$GrapeVarietyModelFromJson(Map<String, dynamic> json) =>
    GrapeVarietyModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
