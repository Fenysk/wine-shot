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
      fromLocationId: fields[4] as String?,
      toLocationId: fields[5] as String?,
      quantity: fields[6] as int,
      movementType: fields[7] as StockMovementType,
      notes: fields[8] as String?,
      createdAt: fields[9] as DateTime?,
      wine: fields[10] as WineModel?,
      fromPackaging: fields[11] as PackagingModel?,
      toPackaging: fields[12] as PackagingModel?,
      fromLocation: fields[13] as LocationModel?,
      toLocation: fields[14] as LocationModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StockMovementModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wineId)
      ..writeByte(2)
      ..write(obj.fromPackagingId)
      ..writeByte(3)
      ..write(obj.toPackagingId)
      ..writeByte(4)
      ..write(obj.fromLocationId)
      ..writeByte(5)
      ..write(obj.toLocationId)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.movementType)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.wine)
      ..writeByte(11)
      ..write(obj.fromPackaging)
      ..writeByte(12)
      ..write(obj.toPackaging)
      ..writeByte(13)
      ..write(obj.fromLocation)
      ..writeByte(14)
      ..write(obj.toLocation);
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
      fromLocationId: json['from_location_id'] as String?,
      toLocationId: json['to_location_id'] as String?,
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
      fromLocation: json['from_location'] == null
          ? null
          : LocationModel.fromJson(
              json['from_location'] as Map<String, dynamic>),
      toLocation: json['to_location'] == null
          ? null
          : LocationModel.fromJson(json['to_location'] as Map<String, dynamic>),
    );

const _$StockMovementTypeEnumMap = {
  StockMovementType.entry: 'entry',
  StockMovementType.exit: 'exit',
  StockMovementType.transform: 'transform',
  StockMovementType.inventory: 'inventory',
  StockMovementType.transfer: 'transfer',
};
