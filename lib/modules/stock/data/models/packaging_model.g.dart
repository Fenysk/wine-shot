// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackagingModelAdapter extends TypeAdapter<PackagingModel> {
  @override
  final int typeId = 6;

  @override
  PackagingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackagingModel(
      id: fields[0] as String,
      label: fields[1] as String,
      unitVolumeMl: fields[2] as int,
      quantityPerUnit: fields[3] as int,
      parentPackagingId: fields[4] as String?,
      parentPackaging: fields[5] as PackagingModel?,
    );
  }

  @override
  void write(BinaryWriter writer, PackagingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.unitVolumeMl)
      ..writeByte(3)
      ..write(obj.quantityPerUnit)
      ..writeByte(4)
      ..write(obj.parentPackagingId)
      ..writeByte(5)
      ..write(obj.parentPackaging);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackagingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingModel _$PackagingModelFromJson(Map<String, dynamic> json) =>
    PackagingModel(
      id: json['id'] as String,
      label: json['label'] as String,
      unitVolumeMl: (json['unit_volume_ml'] as num).toInt(),
      quantityPerUnit: (json['quantity_per_unit'] as num).toInt(),
      parentPackagingId: json['parent_packaging_id'] as String?,
      parentPackaging: json['parent_packaging'] == null
          ? null
          : PackagingModel.fromJson(
              json['parent_packaging'] as Map<String, dynamic>),
    );
