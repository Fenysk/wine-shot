// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../_shared/data/models/region_model.dart';
import '../../domain/entities/producer_entity.dart';

part 'producer_model.g.dart';

@HiveType(typeId: 2) // Assurez-vous que typeId est unique
@JsonSerializable(createToJson: false)
class ProducerModel extends ProducerEntity {
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
  @JsonKey(name: 'region_id')
  final String regionId;

  @override
  @HiveField(3)
  @JsonKey(name: 'region')
  final RegionModel region;

  const ProducerModel({
    required this.id,
    required this.name,
    required this.regionId,
    required this.region,
  }) : super(id: id, name: name, regionId: regionId, region: region);

  factory ProducerModel.fromJson(Map<String, dynamic> json) => _$ProducerModelFromJson(json);
}
