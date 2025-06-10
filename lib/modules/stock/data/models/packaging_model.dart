// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/packaging_entity.dart';

part 'packaging_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable(createToJson: false)
class PackagingModel extends PackagingEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'label')
  final String label;

  @override
  @HiveField(2)
  @JsonKey(name: 'unit_volume_ml')
  final int unitVolumeMl;

  @override
  @HiveField(3)
  @JsonKey(name: 'quantity_per_unit')
  final int quantityPerUnit;

  @override
  @HiveField(4)
  @JsonKey(name: 'parent_packaging_id')
  final String? parentPackagingId;

  @override
  @HiveField(5)
  @JsonKey(name: 'parent_packaging')
  final PackagingModel? parentPackaging;

  factory PackagingModel.fromJson(Map<String, dynamic> json) => _$PackagingModelFromJson(json);

  const PackagingModel({
    required this.id,
    required this.label,
    required this.unitVolumeMl,
    required this.quantityPerUnit,
    this.parentPackagingId,
    this.parentPackaging,
  }) : super(
          id: id,
          label: label,
          unitVolumeMl: unitVolumeMl,
          quantityPerUnit: quantityPerUnit,
          parentPackagingId: parentPackagingId,
          parentPackaging: parentPackaging,
        );
}
