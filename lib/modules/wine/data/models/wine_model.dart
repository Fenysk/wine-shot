// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../_shared/data/models/region_model.dart';
import '../../../producer/data/models/producer_model.dart';
import '../../domain/entities/wine_entity.dart';
import 'wine_type_model.dart';

part 'wine_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class WineModel extends WineEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @override
  @HiveField(2)
  @JsonKey(name: 'alcohol_percentage')
  final double? alcoholPercentage;

  @override
  @HiveField(3)
  @JsonKey(name: 'description')
  final String? description;

  @override
  @HiveField(4)
  @JsonKey(name: 'producer_id')
  final String? producerId;

  @override
  @HiveField(5)
  @JsonKey(name: 'region_id')
  final String? regionId;

  @override
  @HiveField(6)
  @JsonKey(name: 'wine_type_id')
  final String? wineTypeId;

  @override
  @HiveField(7)
  @JsonKey(name: 'producer')
  final ProducerModel? producer;

  @override
  @HiveField(8)
  @JsonKey(name: 'region')
  final RegionModel? region;

  @override
  @HiveField(9)
  @JsonKey(name: 'wine_type')
  final WineTypeModel? wineType;

  const WineModel({
    required this.id,
    required this.name,
    this.alcoholPercentage,
    this.description,
    this.producerId,
    this.regionId,
    this.wineTypeId,
    this.producer,
    this.region,
    this.wineType,
  }) : super(
          id: id,
          name: name,
          alcoholPercentage: alcoholPercentage,
          description: description,
          producerId: producerId,
          regionId: regionId,
          wineTypeId: wineTypeId,
          producer: producer,
          region: region,
          wineType: wineType,
        );

  factory WineModel.fromJson(Map<String, dynamic> json) => _$WineModelFromJson(json);
}
