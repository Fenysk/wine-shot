// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../wine/data/models/wine_model.dart';
import '../../domain/entities/stock_movement_entity.dart';
import 'location_model.dart';
import 'packaging_model.dart';

part 'stock_movement_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable(createToJson: false)
class StockMovementModel extends StockMovement {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'wine_id')
  final String wineId;

  @override
  @HiveField(2)
  @JsonKey(name: 'from_packaging_id')
  final String? fromPackagingId;

  @override
  @HiveField(3)
  @JsonKey(name: 'to_packaging_id')
  final String? toPackagingId;

  @override
  @HiveField(4)
  @JsonKey(name: 'from_location_id')
  final String? fromLocationId;

  @override
  @HiveField(5)
  @JsonKey(name: 'to_location_id')
  final String? toLocationId;

  @override
  @HiveField(6)
  @JsonKey(name: 'quantity')
  final int quantity;

  @override
  @HiveField(7)
  @JsonKey(name: 'movement_type')
  final StockMovementType movementType;

  @override
  @HiveField(8)
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  @HiveField(9)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  @HiveField(10)
  @JsonKey(name: 'wine')
  final WineModel? wine;

  @override
  @HiveField(11)
  @JsonKey(name: 'from_packaging')
  final PackagingModel? fromPackaging;

  @override
  @HiveField(12)
  @JsonKey(name: 'to_packaging')
  final PackagingModel? toPackaging;

  @override
  @HiveField(13)
  @JsonKey(name: 'from_location')
  final LocationModel? fromLocation;

  @override
  @HiveField(14)
  @JsonKey(name: 'to_location')
  final LocationModel? toLocation;

  const StockMovementModel({
    required this.id,
    required this.wineId,
    this.fromPackagingId,
    this.toPackagingId,
    this.fromLocationId,
    this.toLocationId,
    required this.quantity,
    required this.movementType,
    this.notes,
    this.createdAt,
    this.wine,
    this.fromPackaging,
    this.toPackaging,
    this.fromLocation,
    this.toLocation,
  }) : super(
          id: id,
          wineId: wineId,
          fromPackagingId: fromPackagingId,
          toPackagingId: toPackagingId,
          fromLocationId: fromLocationId,
          toLocationId: toLocationId,
          quantity: quantity,
          movementType: movementType,
          notes: notes,
          createdAt: createdAt,
          wine: wine,
          fromPackaging: fromPackaging,
          toPackaging: toPackaging,
          fromLocation: fromLocation,
          toLocation: toLocation,
        );

  factory StockMovementModel.fromJson(Map<String, dynamic> json) => _$StockMovementModelFromJson(json);
}
