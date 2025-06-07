// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProducerModelAdapter extends TypeAdapter<ProducerModel> {
  @override
  final int typeId = 2;

  @override
  ProducerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProducerModel(
      id: fields[0] as String,
      name: fields[1] as String,
      regionId: fields[2] as String,
      region: fields[3] as RegionModel,
    );
  }

  @override
  void write(BinaryWriter writer, ProducerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.regionId)
      ..writeByte(3)
      ..write(obj.region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProducerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProducerModel _$ProducerModelFromJson(Map<String, dynamic> json) =>
    ProducerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      regionId: json['region_id'] as String,
      region: RegionModel.fromJson(json['region'] as Map<String, dynamic>),
    );
