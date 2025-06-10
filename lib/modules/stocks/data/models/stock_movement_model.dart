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
  @JsonKey(name: 'location_id')
  final String locationId;

  @override
  @HiveField(5)
  @JsonKey(name: 'quantity')
  final int quantity;

  @override
  @HiveField(6)
  @JsonKey(name: 'movement_type')
  final StockMovementType movementType;

  @override
  @HiveField(7)
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  @HiveField(8)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @HiveField(9)
  @JsonKey(name: 'wine')
  final WineModel? wine;

  @HiveField(10)
  @JsonKey(name: 'from_packaging')
  final PackagingModel? fromPackaging;

  @HiveField(11)
  @JsonKey(name: 'to_packaging')
  final PackagingModel? toPackaging;

  @HiveField(12)
  @JsonKey(name: 'location')
  final LocationModel? location;

  factory StockMovementModel.fromJson(Map<String, dynamic> json) => _$StockMovementModelFromJson(json);

  const StockMovementModel({
    required this.id,
    required this.wineId,
    this.fromPackagingId,
    this.toPackagingId,
    required this.locationId,
    required this.quantity,
    required this.movementType,
    this.notes,
    this.createdAt,
    this.wine,
    this.fromPackaging,
    this.toPackaging,
    this.location,
  }) : super(
          id: id,
          wineId: wineId,
          fromPackagingId: fromPackagingId,
          toPackagingId: toPackagingId,
          locationId: locationId,
          quantity: quantity,
          movementType: movementType,
          notes: notes,
          createdAt: createdAt,
        );
}
