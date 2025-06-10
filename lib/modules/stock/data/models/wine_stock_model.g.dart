// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_stock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WineStockModelAdapter extends TypeAdapter<WineStockModel> {
  @override
  final int typeId = 4;

  @override
  WineStockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WineStockModel(
      id: fields[0] as String,
      wineId: fields[1] as String,
      packagingId: fields[2] as String,
      quantity: fields[3] as int,
      locationId: fields[4] as String?,
      wine: fields[5] as WineModel?,
      packaging: fields[6] as PackagingModel?,
      location: fields[7] as LocationModel?,
    );
  }

  @override
  void write(BinaryWriter writer, WineStockModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wineId)
      ..writeByte(2)
      ..write(obj.packagingId)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.locationId)
      ..writeByte(5)
      ..write(obj.wine)
      ..writeByte(6)
      ..write(obj.packaging)
      ..writeByte(7)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WineStockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WineStockModel _$WineStockModelFromJson(Map<String, dynamic> json) =>
    WineStockModel(
      id: json['id'] as String,
      wineId: json['wine_id'] as String,
      packagingId: json['packaging_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      locationId: json['location_id'] as String?,
      wine: json['wine'] == null
          ? null
          : WineModel.fromJson(json['wine'] as Map<String, dynamic>),
      packaging: json['packaging'] == null
          ? null
          : PackagingModel.fromJson(json['packaging'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );
