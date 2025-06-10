// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/region_entity.dart';

part 'region_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class RegionModel extends RegionEntity {
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
  @JsonKey(name: 'country_id')
  final String? countryId;

  @override
  @HiveField(3)
  @JsonKey(name: 'parent_id')
  final String? parentId;

  const RegionModel({
    required this.id,
    required this.name,
    this.countryId,
    this.parentId,
  }) : super(id: id, name: name, countryId: countryId, parentId: parentId);

  factory RegionModel.fromJson(Map<String, dynamic> json) => _$RegionModelFromJson(json);
}
