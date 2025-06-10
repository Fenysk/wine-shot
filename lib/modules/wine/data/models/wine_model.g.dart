// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WineModelAdapter extends TypeAdapter<WineModel> {
  @override
  final int typeId = 3;

  @override
  WineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WineModel(
      id: fields[0] as String,
      name: fields[1] as String,
      alcoholPercentage: fields[2] as double?,
      description: fields[3] as String?,
      producerId: fields[4] as String?,
      regionId: fields[5] as String?,
      wineTypeId: fields[6] as String?,
      producer: fields[7] as ProducerModel?,
      region: fields[8] as RegionModel?,
      wineType: fields[9] as WineTypeModel?,
    );
  }

  @override
  void write(BinaryWriter writer, WineModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.alcoholPercentage)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.producerId)
      ..writeByte(5)
      ..write(obj.regionId)
      ..writeByte(6)
      ..write(obj.wineTypeId)
      ..writeByte(7)
      ..write(obj.producer)
      ..writeByte(8)
      ..write(obj.region)
      ..writeByte(9)
      ..write(obj.wineType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WineModel _$WineModelFromJson(Map<String, dynamic> json) => WineModel(
      id: json['id'] as String,
      name: json['name'] as String,
      alcoholPercentage: (json['alcohol_percentage'] as num?)?.toDouble(),
      description: json['description'] as String?,
      producerId: json['producer_id'] as String?,
      regionId: json['region_id'] as String?,
      wineTypeId: json['wine_type_id'] as String?,
      producer: json['producer'] == null
          ? null
          : ProducerModel.fromJson(json['producer'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : RegionModel.fromJson(json['region'] as Map<String, dynamic>),
      wineType: json['wine_type'] == null
          ? null
          : WineTypeModel.fromJson(json['wine_type'] as Map<String, dynamic>),
    );
