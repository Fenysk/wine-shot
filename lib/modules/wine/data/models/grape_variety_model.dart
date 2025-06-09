// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/grape_variety_entity.dart';

part 'grape_variety_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable(createToJson: false)
class GrapeVarietyModel extends GrapeVarietyEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  const GrapeVarietyModel({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  factory GrapeVarietyModel.fromJson(Map<String, dynamic> json) => _$GrapeVarietyModelFromJson(json);
}
