// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WineTypeModelAdapter extends TypeAdapter<WineTypeModel> {
  @override
  final int typeId = 4;

  @override
  WineTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WineTypeModel(
      id: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WineTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WineTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WineTypeModel _$WineTypeModelFromJson(Map<String, dynamic> json) =>
    WineTypeModel(
      id: json['id'] as String,
      label: json['label'] as String,
    );
