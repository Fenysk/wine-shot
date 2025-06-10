// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockMovementModelAdapter extends TypeAdapter<StockMovementModel> {
  @override
  final int typeId = 5;

  @override
  StockMovementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockMovementModel(
      id: fields[0] as String,
      wineId: fields[1] as String,
      fromPackagingId: fields[2] as String?,
      toPackagingId: fields[3] as String?,
      locationId: fields[4] as String,
      quantity: fields[5] as int,
      movementType: fields[6] as StockMovementType,
      notes: fields[7] as String?,
      createdAt: fields[8] as DateTime?,
      wine: fields[9] as WineModel?,
      fromPackaging: fields[10] as PackagingModel?,
      toPackaging: fields[11] as PackagingModel?,
      location: fields[12] as LocationModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StockMovementModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wineId)
      ..writeByte(2)
      ..write(obj.fromPackagingId)
      ..writeByte(3)
      ..write(obj.toPackagingId)
      ..writeByte(4)
      ..write(obj.locationId)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.movementType)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.wine)
      ..writeByte(10)
      ..write(obj.fromPackaging)
      ..writeByte(11)
      ..write(obj.toPackaging)
      ..writeByte(12)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockMovementModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockMovementModel _$StockMovementModelFromJson(Map<String, dynamic> json) =>
    StockMovementModel(
      id: json['id'] as String,
      wineId: json['wine_id'] as String,
      fromPackagingId: json['from_packaging_id'] as String?,
      toPackagingId: json['to_packaging_id'] as String?,
      locationId: json['location_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      movementType:
          $enumDecode(_$StockMovementTypeEnumMap, json['movement_type']),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      wine: json['wine'] == null
          ? null
          : WineModel.fromJson(json['wine'] as Map<String, dynamic>),
      fromPackaging: json['from_packaging'] == null
          ? null
          : PackagingModel.fromJson(
              json['from_packaging'] as Map<String, dynamic>),
      toPackaging: json['to_packaging'] == null
          ? null
          : PackagingModel.fromJson(
              json['to_packaging'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

const _$StockMovementTypeEnumMap = {
  StockMovementType.entry: 'entry',
  StockMovementType.exit: 'exit',
  StockMovementType.transform: 'transform',
  StockMovementType.inventory: 'inventory',
  StockMovementType.transfer: 'transfer',
};
