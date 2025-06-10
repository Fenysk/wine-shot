// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../wine/data/models/wine_model.dart';
import '../../domain/entities/wine_stock_entity.dart';
import 'location_model.dart';
import 'packaging_model.dart';

part 'wine_stock_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(createToJson: false)
class WineStockModel extends WineStockEntity {
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
  @JsonKey(name: 'packaging_id')
  final String packagingId;

  @override
  @HiveField(3)
  @JsonKey(name: 'quantity')
  final int quantity;

  @override
  @HiveField(4)
  @JsonKey(name: 'location_id')
  final String? locationId;

  @override
  @HiveField(5)
  @JsonKey(name: 'wine')
  final WineModel? wine;

  @override
  @HiveField(6)
  @JsonKey(name: 'packaging')
  final PackagingModel? packaging;

  @override
  @HiveField(7)
  @JsonKey(name: 'location')
  final LocationModel? location;

  factory WineStockModel.fromJson(Map<String, dynamic> json) => _$WineStockModelFromJson(json);

  const WineStockModel({
    required this.id,
    required this.wineId,
    required this.packagingId,
    required this.quantity,
    this.locationId,
    this.wine,
    this.packaging,
    this.location,
  }) : super(
          id: id,
          wineId: wineId,
          packagingId: packagingId,
          quantity: quantity,
          locationId: locationId,
        );
}
