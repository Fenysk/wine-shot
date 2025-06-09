// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/wine_type_entity.dart';

part 'wine_type_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(createToJson: false)
class WineTypeModel extends WineTypeEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'label')
  final String label;

  const WineTypeModel({
    required this.id,
    required this.label,
  }) : super(
          id: id,
          label: label,
        );

  factory WineTypeModel.fromJson(Map<String, dynamic> json) => _$WineTypeModelFromJson(json);
}
